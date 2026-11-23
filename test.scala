//> using scala "2.13.12"
//> using dep "edu.berkeley.cs::chisel3:3.6.1"
//> using plugin "edu.berkeley.cs:::chisel3-plugin:3.6.1"
//> using options "-language:reflectiveCalls"

package personcnn

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline
import scala.io.Source
import scala.language.reflectiveCalls
import java.nio.file.{Files, Paths}
import java.nio.charset.StandardCharsets

// Helpers to read the golden_out/*.hex files at elaboration time.
object HexIO {
  def unsigned(path: String): Seq[BigInt] = {
    val src = Source.fromFile(path)
    try src.getLines().map(_.trim).filter(_.nonEmpty).map(BigInt(_, 16)).toList
    finally src.close()
  }

  def signed(path: String, bits: Int): Seq[BigInt] =
    unsigned(path).map(v => if (v >= (BigInt(1) << (bits - 1))) v - (BigInt(1) << bits) else v)
}

/** Static configuration. Defaults match params.json (arch 8p-16p-24-32p-32). */
case class CnnConfig(
    hexDir: String      = "golden_out",
    cin: Seq[Int]       = Seq(1, 8, 16, 23, 31),
    cout: Seq[Int]      = Seq(8, 16, 23, 31, 29),
    hIn: Seq[Int]       = Seq(64, 32, 16, 16, 8),
    pools: Seq[Boolean] = Seq(true, true, false, true, false),
    sh: Seq[Int]        = Seq(19, 21, 22, 22, 23),
    mBits: Int          = 16,
    bqBits: Int         = 30,
    threshold: Int      = 2688
) {
  val nLayers  = cin.length
  val hOut     = hIn.zip(pools).map { case (h, p) => if (p) h / 2 else h }
  val wTotal   = cin.zip(cout).map { case (i, o) => i * o * 9 }.sum
  val bnTotal  = cout.sum
  val nFcIn    = cout.last
  val nPixLog2 = 2 * log2Ceil(hOut.last)                 // pixels/channel at GAP (64 -> 6)
  val actDepth = (0 until nLayers).map { i =>
    math.max(cin(i) * hIn(i) * hIn(i), cout(i) * hOut(i) * hOut(i))
  }.max
}

object St extends ChiselEnum {
  val idle, cfg, conv, drain, gap, gapDrain, fin, done = Value
}

/**
 * Loop counter whose "last" flag is a REGISTER (updated together with cnt),
 * so the nested-loop enable chain is only a short AND tree of flops.
 */
class LoopCnt(w: Int) {
  val cnt  = RegInit(0.U(w.W))
  val last = RegInit(false.B)
  val max  = RegInit(0.U(w.W))                            // n-1
  def init(newMax: UInt): Unit = { max := newMax; cnt := 0.U; last := newMax === 0.U }
  def step(en: Bool): Unit = when(en) {
    when(last) { cnt := 0.U; last := max === 0.U }
      .otherwise { cnt := cnt + 1.U; last := (cnt + 1.U) === max }
  }
}

/**
 * Fully pipelined version (every stage = registers -> small logic -> registers).
 *
 *  S0 counters (flop-only enable chain)
 *  S1 iy/ix/weight index            S2 pad, shifts, weight BRAM out
 *  S3 partial addr sum              S4 final addr (register -> BRAM address)
 *  S5 BRAM data                     S6 pixel/shift select
 *  S7 shift                         S8 +/- sign
 *  S9 accumulate (+ BN ROM read)    S10-11 multiply (DSP regs)
 *  S12 + Bq                         S13 >>> SH
 *  S14 clamp                        S15 2x2 max + registered BRAM write
 */
class PersonCnn(cfg: CnnConfig) extends Module {
  import cfg._

  val io = IO(new Bundle {
    val loadEn   = Input(Bool())
    val loadAddr = Input(UInt(12.W))    // row-major 64x64
    val loadData = Input(UInt(4.W))
    val start    = Input(Bool())
    val busy     = Output(Bool())
    val done     = Output(Bool())
    val pred     = Output(Bool())
    val dOut     = Output(SInt(32.W))   // D = acc_fc1 - acc_fc0
  })

  val AW = log2Ceil(actDepth)

  // ---------------- ROMs ----------------
  val wAllValues = (0 until nLayers).flatMap(i => HexIO.unsigned(s"$hexDir/w_L$i.hex"))
  require(wAllValues.length == wTotal, s"w hex size ${wAllValues.length} != $wTotal")
  val wAllHexPath = s"$hexDir/w_all_merged.hex"
  Files.write(
    Paths.get(wAllHexPath),
    (wAllValues.map(_.toString(16)).mkString("\n") + "\n").getBytes(StandardCharsets.UTF_8)
  )
  val wRom = SyncReadMem(wTotal, UInt(4.W))
  loadMemoryFromFileInline(wRom, wAllHexPath)

  val mRom  = VecInit((0 until nLayers).flatMap(i => HexIO.signed(s"$hexDir/bn_M_L$i.hex", mBits)).map(_.S(mBits.W)))
  val bqRom = VecInit((0 until nLayers).flatMap(i => HexIO.signed(s"$hexDir/bn_B_L$i.hex", bqBits)).map(_.S(bqBits.W)))
  val fcRom = VecInit(HexIO.unsigned(s"$hexDir/fc_w.hex").map(_.U(4.W)))
  require(mRom.length == bnTotal && bqRom.length == bnTotal, "BN hex size mismatch")
  require(fcRom.length == 2 * nFcIn, "fc hex size mismatch")

  // per-layer constants (only read once per layer, in state cfg)
  def romU(s: Seq[Int], w: Int) = VecInit((s :+ s.last).map(_.U(w.W)))
  val cinM1V  = romU(cin.map(_ - 1), 6)
  val coutM1V = romU(cout.map(_ - 1), 6)
  val hOutM1V = romU(hOut.map(_ - 1), 6)
  val pxMaxV  = romU(pools.map(p => if (p) 1 else 0), 1)
  val poolV   = VecInit((pools :+ false).map(_.B))
  val hInV    = romU(hIn, 7)
  val lgHinV  = romU(hIn.map(log2Ceil(_)), 3)
  val lgHinwV = romU(hIn.map(h => 2 * log2Ceil(h)), 4)
  val shV     = romU(sh, 5)
  val cin9V   = romU(cin.map(_ * 9), 9)

  // per-layer configuration REGISTERS (datapath never touches the ROM vectors above)
  val poolR   = RegInit(false.B)
  val hinR    = RegInit(0.U(7.W))
  val lgHinR  = RegInit(0.U(3.W))
  val lgHinwR = RegInit(0.U(4.W))
  val shR     = RegInit(0.U(5.W))
  val cin9R   = RegInit(0.U(9.W))

  // ---------------- activation buffers (ping-pong) ----------------
  val actA = SyncReadMem(actDepth, UInt(6.W))
  val actB = SyncReadMem(actDepth, UInt(6.W))

  // ---------------- control ----------------
  val state = RegInit(St.idle)
  val ready = state === St.idle || state === St.done
  val layer = RegInit(0.U(3.W))
  val sel   = RegInit(false.B)       // false: read A / write B ; true: read B / write A

  val kx   = new LoopCnt(2)
  val ky   = new LoopCnt(2)
  val ci   = new LoopCnt(6)
  val px   = new LoopCnt(1)
  val py   = new LoopCnt(1)
  val ocol = new LoopCnt(6)
  val orow = new LoopCnt(6)
  val co   = new LoopCnt(6)
  val k       = RegInit(0.U(9.W))    // ci*9 + ky*3 + kx
  val wCoBase = RegInit(0.U(15.W))   // wraps naturally to next layer's base
  val bnPtr   = RegInit(0.U(7.W))    // idem for BN tables
  val wrPtr   = RegInit(0.U(AW.W))   // outputs are written in raster order -> plain counter

  val run   = state === St.conv
  val enKy  = run && kx.last
  val enCi  = enKy && ky.last
  val enPx  = enCi && ci.last
  val enPy  = enPx && px.last
  val enCol = enPy && py.last
  val enRow = enCol && ocol.last
  val enCo  = enRow && orow.last
  kx.step(run); ky.step(enKy); ci.step(enCi); px.step(enPx)
  py.step(enPy); ocol.step(enCol); orow.step(enRow); co.step(enCo)

  val lastTap  = kx.last && ky.last && ci.last
  val firstTap = k === 0.U
  when(run) { k := Mux(lastTap, 0.U, k + 1.U) }
  when(enCo) {
    wCoBase := wCoBase + cin9R
    bnPtr   := bnPtr + 1.U
    when(co.last) { state := St.drain }
  }

  // ---------------- pipeline helpers ----------------
  class Ctl extends Bundle {
    val v         = Bool()
    val first     = Bool()
    val last      = Bool()
    val firstPool = Bool()
    val lastPool  = Bool()
    val bn        = UInt(7.W)
  }
  val valids = scala.collection.mutable.ArrayBuffer[Bool]()
  def stage(c: Ctl): Ctl = {
    val r = RegNext(c, 0.U.asTypeOf(new Ctl))
    valids += r.v
    r
  }
  def z(u: UInt): SInt = Cat(0.U(1.W), u).asSInt

  // ---------------- S0: counters -> control word ----------------
  val c0 = Wire(new Ctl)
  c0.v         := run
  c0.first     := firstTap
  c0.last      := lastTap
  c0.firstPool := px.cnt === 0.U && py.cnt === 0.U
  c0.lastPool  := lastTap && px.last && py.last
  c0.bn        := bnPtr

  val rU  = Mux(poolR, Cat(orow.cnt, py.cnt), orow.cnt)
  val cU  = Mux(poolR, Cat(ocol.cnt, px.cnt), ocol.cnt)
  val iy0 = z(rU) + z(ky.cnt) - 1.S
  val ix0 = z(cU) + z(kx.cnt) - 1.S

  // ---------------- S1 ----------------
  val c1    = stage(c0)
  val iy1   = RegNext(iy0)
  val ix1   = RegNext(ix0)
  val ci1   = RegNext(ci.cnt)
  val wIdx1 = RegNext(wCoBase + k)
  val wcode2 = wRom.read(wIdx1, c1.v)

  // ---------------- S2: pad flag, address terms, weight BRAM out ----------------
  val c2     = stage(c1)
  val pad1   = iy1 < 0.S || iy1 >= z(hinR) || ix1 < 0.S || ix1 >= z(hinR)
  val pad2   = RegNext(pad1)
  val ciSh2  = RegNext((ci1 << lgHinwR)(AW - 1, 0))
  val iySh2  = RegNext((iy1.asUInt << lgHinR)(AW - 1, 0))
  val ix2    = RegNext(ix1.asUInt.pad(AW)(AW - 1, 0))

  // ---------------- S3: partial address ----------------
  val c3     = stage(c2)
  val pad3   = RegNext(pad2)
  val part3  = RegNext(ciSh2 + iySh2)
  val ix3    = RegNext(ix2)
  val wcode3 = RegNext(wcode2)

  // ---------------- S4: final address register ----------------
  val c4     = stage(c3)
  val pad4   = RegNext(pad3)
  val addr4  = RegNext(part3 + ix3)
  val wcode4 = RegNext(wcode3)

  // ---------------- memory read (shared with GAP) ----------------
  val inGap    = state === St.gap
  val gapIdxW  = log2Ceil(nFcIn << nPixLog2)
  val gapIdx   = RegInit(0.U(gapIdxW.W))
  val finalInB = nLayers % 2 == 1

  val rdAddr = Mux(inGap, gapIdx, addr4)(AW - 1, 0)
  val rdEnA  = (c4.v && !sel) || (inGap && !finalInB.B)
  val rdEnB  = (c4.v && sel) || (inGap && finalInB.B)
  val rdA    = actA.read(rdAddr, rdEnA)
  val rdB    = actB.read(rdAddr, rdEnB)

  // ---------------- S5: BRAM data valid ----------------
  val c5     = stage(c4)
  val pad5   = RegNext(pad4)
  val wcode5 = RegNext(wcode4)
  val rd5    = Mux(sel, rdB, rdA)

  // ---------------- S6: pixel / shift select ----------------
  val c6     = stage(c5)
  val pixel6 = RegNext(Mux(pad5, 0.U(6.W), rd5))
  val sh6    = RegNext(7.U(3.W) - wcode5(2, 0))
  val zero6  = RegNext(wcode5(2, 0) === 0.U)
  val sg6    = RegNext(wcode5(3))

  // ---------------- S7: barrel shift ----------------
  val c7   = stage(c6)
  val mag7 = RegNext(Mux(zero6, 0.U(13.W), (pixel6 << sh6)(12, 0)))
  val sg7  = RegNext(sg6)

  // ---------------- S8: apply sign ----------------
  val c8     = stage(c7)
  val magS7  = Cat(0.U(1.W), mag7).asSInt
  val term8  = RegNext(Mux(sg7, 0.S - magS7, magS7))

  // ---------------- S9: accumulate (+ BN ROM read in parallel) ----------------
  val acc     = RegInit(0.S(24.W))
  val accNext = Mux(c8.first, 0.S, acc) + term8
  when(c8.v) { acc := accNext }

  val c9w = Wire(new Ctl)
  c9w   := c8
  c9w.v := c8.v && c8.last                       // one token per finished conv pixel
  val c9   = stage(c9w)
  val acc9 = RegNext(accNext)
  val m9   = RegNext(mRom(c8.bn))
  val bq9  = RegNext(bqRom(c8.bn))

  // ---------------- S10/S11: multiply (maps to DSP with input/mult/P regs) ----------------
  val c10     = stage(c9)
  val prodA10 = RegNext(acc9 * m9)
  val bq10    = RegNext(bq9)
  val c11     = stage(c10)
  val prodB11 = RegNext(prodA10)
  val bq11    = RegNext(bq10)

  // ---------------- S12: + Bq ----------------
  val c12   = stage(c11)
  val sum12 = RegNext(prodB11 +& bq11)

  // ---------------- S13: arithmetic shift ----------------
  val c13       = stage(c12)
  val shifted13 = RegNext(sum12 >> shR)

  // ---------------- S14: ReLU + clamp[0,63] ----------------
  val c14 = stage(c13)
  val q14 = RegNext(
    Mux(shifted13 < 0.S, 0.U(6.W), Mux(shifted13 > 63.S, 63.U(6.W), shifted13(5, 0)))
  )

  // ---------------- S15: 2x2 max pool + registered write ----------------
  val poolMax = RegInit(0.U(6.W))
  val newMax  = Mux(c14.firstPool || q14 > poolMax, q14, poolMax)
  when(c14.v) { poolMax := newMax }
  val wrEn15   = RegNext(c14.v && c14.lastPool, false.B)
  val wrData15 = RegNext(newMax)
  valids += wrEn15

  when(wrEn15) { wrPtr := wrPtr + 1.U }

  // registered image-load port
  val ldEn   = RegNext(io.loadEn && ready, false.B)
  val ldAddr = RegNext(io.loadAddr)
  val ldData = RegNext(io.loadData)

  val wenA = ldEn || (wrEn15 && sel)
  when(wenA) {
    actA.write(Mux(ldEn, ldAddr, wrPtr)(AW - 1, 0), Mux(ldEn, ldData, wrData15))
  }
  when(wrEn15 && !sel) { actB.write(wrPtr, wrData15) }

  val pipeBusy = valids.reduce(_ || _)

  // ---------------- layer sequencing ----------------
  when(ready && io.start) {
    layer   := 0.U
    sel     := false.B
    wCoBase := 0.U
    bnPtr   := 0.U
    state   := St.cfg
  }

  when(state === St.cfg) {
    poolR   := poolV(layer)
    hinR    := hInV(layer)
    lgHinR  := lgHinV(layer)
    lgHinwR := lgHinwV(layer)
    shR     := shV(layer)
    cin9R   := cin9V(layer)
    kx.init(2.U); ky.init(2.U)
    ci.init(cinM1V(layer))
    px.init(pxMaxV(layer)); py.init(pxMaxV(layer))
    ocol.init(hOutM1V(layer)); orow.init(hOutM1V(layer))
    co.init(coutM1V(layer))
    k     := 0.U
    wrPtr := 0.U
    state := St.conv
  }

  when(state === St.drain && !pipeBusy) {
    when(layer === (nLayers - 1).U) {
      state  := St.gap
      gapIdx := 0.U
    }.otherwise {
      layer := layer + 1.U
      sel   := !sel
      state := St.cfg
    }
  }

  // ---------------- GAP + FC (also pipelined) ----------------
  val accFc = RegInit(VecInit(Seq.fill(2)(0.S(32.W))))
  when(ready && io.start) { accFc.foreach(_ := 0.S) }

  when(inGap) {
    gapIdx := gapIdx + 1.U
    when(gapIdx === ((nFcIn << nPixLog2) - 1).U) {
      gapIdx := 0.U
      state  := St.gapDrain
    }
  }

  // G1: BRAM data valid
  val gv1     = RegNext(inGap, false.B)
  val gFirst1 = RegNext(gapIdx(nPixLog2 - 1, 0) === 0.U)
  val gLast1  = RegNext(gapIdx(nPixLog2 - 1, 0).andR)
  val gCh1    = RegNext(gapIdx >> nPixLog2)
  val gapData = if (finalInB) rdB else rdA

  // G2: per-channel sum
  val gv2     = RegNext(gv1, false.B)
  val gFirst2 = RegNext(gFirst1)
  val gLast2  = RegNext(gLast1)
  val gCh2    = RegNext(gCh1)
  val gData2  = RegNext(gapData)
  val sAcc    = RegInit(0.U(16.W))
  val sNext   = Mux(gFirst2, 0.U, sAcc) + gData2
  when(gv2) { sAcc := sNext }

  // G3: latch finished sum + FC weight codes
  val gv3    = RegNext(gv2 && gLast2, false.B)
  // đặt sau khai báo gv3 / sFin3
  val sFin3  = RegNext(sNext)
  val gCh3 = RegNext(gCh2)
  when(gv3) { printf("S[%d]=%d\n", gCh3, sFin3) }
  when(state === St.fin) { printf("acc0=%d acc1=%d\n", accFc(0), accFc(1)) }
 
  val code3 = Seq.tabulate(2)(cl => RegNext(fcRom(gCh2 +& (cl * nFcIn).U)))

  // G4: shift, G5: sign, G6: accumulate
  val gv4  = RegNext(gv3, false.B)
  val gv5  = RegNext(gv4, false.B)
  for (cl <- 0 until 2) {
    val e3   = code3(cl)(2, 0)
    val mag4 = RegNext(Mux(e3 === 0.U, 0.U(20.W), (sFin3 << (7.U(3.W) - e3))(19, 0)))
    val sg4  = RegNext(code3(cl)(3))
    val m4S  = Cat(0.U(1.W), mag4).asSInt
    val term5 = RegNext(Mux(sg4, 0.S - m4S, m4S))
    when(gv5) { accFc(cl) := accFc(cl) + term5 }
  }
  val gapBusy = gv1 || gv2 || gv3 || gv4 || gv5

  when(state === St.gapDrain && !gapBusy) { state := St.fin }
  when(state === St.fin) { state := St.done }

  // ---------------- registered outputs ----------------
  val dR    = RegNext(accFc(1) - accFc(0))
  val predR = RegNext(dR > threshold.S)
  io.dOut := dR
  io.pred := predR
  io.done := state === St.done
  io.busy := !ready
}

/** Entry point to elaborate and emit Verilog in one command. */
object GeneratePersonCnn extends App {
  val hexDir    = if (args.length > 0) args(0) else "golden_out"
  val targetDir = if (args.length > 1) args(1) else "generated"

  val cfg = CnnConfig(hexDir = hexDir)
  emitVerilog(
    new PersonCnn(cfg),
    Array("--target-dir", targetDir)
  )

  val outFile = s"$targetDir/PersonCnn.v"
  val src     = Source.fromFile(outFile)
  val lines   = try src.getLines().size finally src.close()
  println(s"[OK] Da sinh thanh cong: $outFile ($lines dong)")
}
