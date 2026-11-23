module PersonCnn(
  input         clock,
  input         reset,
  input         io_loadEn, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  input  [11:0] io_loadAddr, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  input  [3:0]  io_loadData, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  input         io_start, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  output        io_busy, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  output        io_done, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  output        io_pred, // @[home/void-dreamers/commit_folder/test.scala 85:14]
  output [31:0] io_dOut // @[home/void-dreamers/commit_folder/test.scala 85:14]
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [63:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [63:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [63:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [63:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] wRom [0:19043]; // @[home/void-dreamers/commit_folder/test.scala 106:25]
  wire  wRom_wcode2_en; // @[home/void-dreamers/commit_folder/test.scala 106:25]
  wire [14:0] wRom_wcode2_addr; // @[home/void-dreamers/commit_folder/test.scala 106:25]
  wire [3:0] wRom_wcode2_data; // @[home/void-dreamers/commit_folder/test.scala 106:25]
  reg  wRom_wcode2_en_pipe_0;
  reg [14:0] wRom_wcode2_addr_pipe_0;
  reg [5:0] actA [0:8191]; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire  actA_rdA_en; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire [12:0] actA_rdA_addr; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire [5:0] actA_rdA_data; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire [5:0] actA_MPORT_data; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire [12:0] actA_MPORT_addr; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire  actA_MPORT_mask; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  wire  actA_MPORT_en; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  reg  actA_rdA_en_pipe_0;
  reg [12:0] actA_rdA_addr_pipe_0;
  reg [5:0] actB [0:8191]; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire  actB_rdB_en; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire [12:0] actB_rdB_addr; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire [5:0] actB_rdB_data; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire [5:0] actB_MPORT_1_data; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire [12:0] actB_MPORT_1_addr; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire  actB_MPORT_1_mask; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  wire  actB_MPORT_1_en; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  reg  actB_rdB_en_pipe_0;
  reg [12:0] actB_rdB_addr_pipe_0;
  reg  poolR; // @[home/void-dreamers/commit_folder/test.scala 129:24]
  reg [6:0] hinR; // @[home/void-dreamers/commit_folder/test.scala 130:24]
  reg [2:0] lgHinR; // @[home/void-dreamers/commit_folder/test.scala 131:24]
  reg [3:0] lgHinwR; // @[home/void-dreamers/commit_folder/test.scala 132:24]
  reg [4:0] shR; // @[home/void-dreamers/commit_folder/test.scala 133:24]
  reg [8:0] cin9R; // @[home/void-dreamers/commit_folder/test.scala 134:24]
  reg [2:0] state; // @[home/void-dreamers/commit_folder/test.scala 141:22]
  wire  ready = state == 3'h0 | state == 3'h7; // @[home/void-dreamers/commit_folder/test.scala 142:33]
  reg [2:0] layer; // @[home/void-dreamers/commit_folder/test.scala 143:22]
  reg  sel; // @[home/void-dreamers/commit_folder/test.scala 144:22]
  reg [1:0] cnt; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg [1:0] max; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg [1:0] cnt_1; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_1; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg [1:0] max_1; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg [5:0] cnt_2; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_2; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg [5:0] max_2; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg  cnt_3; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_3; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg  max_3; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg  cnt_4; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_4; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg  max_4; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg [5:0] cnt_5; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_5; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg [5:0] max_5; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg [5:0] cnt_6; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_6; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg [5:0] max_6; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg [5:0] cnt_7; // @[home/void-dreamers/commit_folder/test.scala 60:21]
  reg  last_7; // @[home/void-dreamers/commit_folder/test.scala 61:21]
  reg [5:0] max_7; // @[home/void-dreamers/commit_folder/test.scala 62:21]
  reg [8:0] k; // @[home/void-dreamers/commit_folder/test.scala 154:24]
  reg [14:0] wCoBase; // @[home/void-dreamers/commit_folder/test.scala 155:24]
  reg [6:0] bnPtr; // @[home/void-dreamers/commit_folder/test.scala 156:24]
  reg [12:0] wrPtr; // @[home/void-dreamers/commit_folder/test.scala 157:24]
  wire  run = state == 3'h2; // @[home/void-dreamers/commit_folder/test.scala 159:21]
  wire  enKy = run & last; // @[home/void-dreamers/commit_folder/test.scala 160:19]
  wire  enCi = enKy & last_1; // @[home/void-dreamers/commit_folder/test.scala 161:20]
  wire  enPx = enCi & last_2; // @[home/void-dreamers/commit_folder/test.scala 162:20]
  wire  enPy = enPx & last_3; // @[home/void-dreamers/commit_folder/test.scala 163:20]
  wire  enCol = enPy & last_4; // @[home/void-dreamers/commit_folder/test.scala 164:20]
  wire  enRow = enCol & last_5; // @[home/void-dreamers/commit_folder/test.scala 165:21]
  wire  enCo = enRow & last_6; // @[home/void-dreamers/commit_folder/test.scala 166:21]
  wire [1:0] _cnt_T_1 = cnt + 2'h1; // @[home/void-dreamers/commit_folder/test.scala 66:31]
  wire [1:0] _cnt_T_3 = cnt_1 + 2'h1; // @[home/void-dreamers/commit_folder/test.scala 66:31]
  wire [5:0] _cnt_T_5 = cnt_2 + 6'h1; // @[home/void-dreamers/commit_folder/test.scala 66:31]
  wire [5:0] _cnt_T_11 = cnt_5 + 6'h1; // @[home/void-dreamers/commit_folder/test.scala 66:31]
  wire [5:0] _cnt_T_13 = cnt_6 + 6'h1; // @[home/void-dreamers/commit_folder/test.scala 66:31]
  wire [5:0] _cnt_T_15 = cnt_7 + 6'h1; // @[home/void-dreamers/commit_folder/test.scala 66:31]
  wire  lastTap = last & last_1 & last_2; // @[home/void-dreamers/commit_folder/test.scala 170:37]
  wire  firstTap = k == 9'h0; // @[home/void-dreamers/commit_folder/test.scala 171:20]
  wire [8:0] _k_T_1 = k + 9'h1; // @[home/void-dreamers/commit_folder/test.scala 172:40]
  wire [14:0] _GEN_509 = {{6'd0}, cin9R}; // @[home/void-dreamers/commit_folder/test.scala 174:24]
  wire [14:0] _wCoBase_T_1 = wCoBase + _GEN_509; // @[home/void-dreamers/commit_folder/test.scala 174:24]
  wire [6:0] _bnPtr_T_1 = bnPtr + 7'h1; // @[home/void-dreamers/commit_folder/test.scala 175:22]
  wire [2:0] _GEN_33 = last_7 ? 3'h3 : state; // @[home/void-dreamers/commit_folder/test.scala 176:19 141:22 176:27]
  wire [2:0] _GEN_36 = enCo ? _GEN_33 : state; // @[home/void-dreamers/commit_folder/test.scala 173:14 141:22]
  wire  c0_firstPool = ~cnt_3 & ~cnt_4; // @[home/void-dreamers/commit_folder/test.scala 201:34]
  wire  c0_lastPool = lastTap & last_3 & last_4; // @[home/void-dreamers/commit_folder/test.scala 202:38]
  wire [6:0] _rU_T = {cnt_6,cnt_4}; // @[home/void-dreamers/commit_folder/test.scala 205:27]
  wire [6:0] rU = poolR ? _rU_T : {{1'd0}, cnt_6}; // @[home/void-dreamers/commit_folder/test.scala 205:16]
  wire [6:0] _cU_T = {cnt_5,cnt_3}; // @[home/void-dreamers/commit_folder/test.scala 206:27]
  wire [6:0] cU = poolR ? _cU_T : {{1'd0}, cnt_5}; // @[home/void-dreamers/commit_folder/test.scala 206:16]
  wire [7:0] _iy0_T_1 = {1'h0,rU}; // @[home/void-dreamers/commit_folder/test.scala 194:43]
  wire [2:0] _iy0_T_3 = {1'h0,cnt_1}; // @[home/void-dreamers/commit_folder/test.scala 194:43]
  wire [7:0] _GEN_510 = {{5{_iy0_T_3[2]}},_iy0_T_3}; // @[home/void-dreamers/commit_folder/test.scala 207:19]
  wire [7:0] _iy0_T_6 = $signed(_iy0_T_1) + $signed(_GEN_510); // @[home/void-dreamers/commit_folder/test.scala 207:19]
  wire [7:0] _ix0_T_1 = {1'h0,cU}; // @[home/void-dreamers/commit_folder/test.scala 194:43]
  wire [2:0] _ix0_T_3 = {1'h0,cnt}; // @[home/void-dreamers/commit_folder/test.scala 194:43]
  wire [7:0] _GEN_511 = {{5{_ix0_T_3[2]}},_ix0_T_3}; // @[home/void-dreamers/commit_folder/test.scala 208:19]
  wire [7:0] _ix0_T_6 = $signed(_ix0_T_1) + $signed(_GEN_511); // @[home/void-dreamers/commit_folder/test.scala 208:19]
  reg  c1_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c1_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c1_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c1_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c1_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c1_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [7:0] iy1; // @[home/void-dreamers/commit_folder/test.scala 212:22]
  reg [7:0] ix1; // @[home/void-dreamers/commit_folder/test.scala 213:22]
  reg [5:0] ci1; // @[home/void-dreamers/commit_folder/test.scala 214:22]
  wire [14:0] _GEN_512 = {{6'd0}, k}; // @[home/void-dreamers/commit_folder/test.scala 215:31]
  reg [14:0] wIdx1; // @[home/void-dreamers/commit_folder/test.scala 215:22]
  reg  c2_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c2_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c2_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c2_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c2_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c2_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  wire [7:0] _pad1_T_2 = {1'h0,hinR}; // @[home/void-dreamers/commit_folder/test.scala 194:43]
  reg  pad2; // @[home/void-dreamers/commit_folder/test.scala 221:23]
  wire [20:0] _GEN_37 = {{15'd0}, ci1}; // @[home/void-dreamers/commit_folder/test.scala 222:29]
  wire [20:0] _ciSh2_T = _GEN_37 << lgHinwR; // @[home/void-dreamers/commit_folder/test.scala 222:29]
  reg [12:0] ciSh2; // @[home/void-dreamers/commit_folder/test.scala 222:23]
  wire [7:0] _iySh2_T = iy1; // @[home/void-dreamers/commit_folder/test.scala 223:29]
  wire [14:0] _GEN_38 = {{7'd0}, _iySh2_T}; // @[home/void-dreamers/commit_folder/test.scala 223:36]
  wire [14:0] _iySh2_T_1 = _GEN_38 << lgHinR; // @[home/void-dreamers/commit_folder/test.scala 223:36]
  reg [12:0] iySh2; // @[home/void-dreamers/commit_folder/test.scala 223:23]
  wire [7:0] _ix2_T = ix1; // @[home/void-dreamers/commit_folder/test.scala 224:28]
  reg [12:0] ix2; // @[home/void-dreamers/commit_folder/test.scala 224:23]
  reg  c3_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c3_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c3_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c3_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c3_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c3_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  pad3; // @[home/void-dreamers/commit_folder/test.scala 228:23]
  reg [12:0] part3; // @[home/void-dreamers/commit_folder/test.scala 229:23]
  reg [12:0] ix3; // @[home/void-dreamers/commit_folder/test.scala 230:23]
  reg [3:0] wcode3; // @[home/void-dreamers/commit_folder/test.scala 231:23]
  reg  c4_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c4_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c4_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c4_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c4_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c4_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  pad4; // @[home/void-dreamers/commit_folder/test.scala 235:23]
  reg [12:0] addr4; // @[home/void-dreamers/commit_folder/test.scala 236:23]
  reg [3:0] wcode4; // @[home/void-dreamers/commit_folder/test.scala 237:23]
  wire  inGap = state == 3'h4; // @[home/void-dreamers/commit_folder/test.scala 240:24]
  reg [10:0] gapIdx; // @[home/void-dreamers/commit_folder/test.scala 242:25]
  wire  _rdEnA_T = ~sel; // @[home/void-dreamers/commit_folder/test.scala 246:25]
  wire  _rdEnB_T = c4_v & sel; // @[home/void-dreamers/commit_folder/test.scala 247:22]
  reg  c5_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c5_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c5_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c5_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c5_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c5_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  pad5; // @[home/void-dreamers/commit_folder/test.scala 253:23]
  reg [3:0] wcode5; // @[home/void-dreamers/commit_folder/test.scala 254:23]
  reg  c6_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c6_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c6_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c6_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c6_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c6_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [5:0] pixel6; // @[home/void-dreamers/commit_folder/test.scala 259:23]
  reg [2:0] sh6; // @[home/void-dreamers/commit_folder/test.scala 260:23]
  reg  zero6; // @[home/void-dreamers/commit_folder/test.scala 261:23]
  reg  sg6; // @[home/void-dreamers/commit_folder/test.scala 262:23]
  reg  c7_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c7_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c7_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c7_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c7_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c7_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  wire [12:0] _GEN_39 = {{7'd0}, pixel6}; // @[home/void-dreamers/commit_folder/test.scala 266:52]
  wire [12:0] _mag7_T = _GEN_39 << sh6; // @[home/void-dreamers/commit_folder/test.scala 266:52]
  reg [12:0] mag7; // @[home/void-dreamers/commit_folder/test.scala 266:21]
  reg  sg7; // @[home/void-dreamers/commit_folder/test.scala 267:21]
  reg  c8_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c8_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c8_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c8_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c8_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [6:0] c8_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  wire [13:0] magS7 = {1'h0,mag7}; // @[home/void-dreamers/commit_folder/test.scala 271:36]
  wire [13:0] _term8_T_2 = 14'sh0 - $signed(magS7); // @[home/void-dreamers/commit_folder/test.scala 272:37]
  reg [13:0] term8; // @[home/void-dreamers/commit_folder/test.scala 272:23]
  reg [23:0] acc; // @[home/void-dreamers/commit_folder/test.scala 275:24]
  wire [23:0] _accNext_T = c8_first ? $signed(24'sh0) : $signed(acc); // @[home/void-dreamers/commit_folder/test.scala 276:20]
  wire [23:0] _GEN_513 = {{10{term8[13]}},term8}; // @[home/void-dreamers/commit_folder/test.scala 276:41]
  wire [23:0] accNext = $signed(_accNext_T) + $signed(_GEN_513); // @[home/void-dreamers/commit_folder/test.scala 276:41]
  wire  c9w_v = c8_v & c8_last; // @[home/void-dreamers/commit_folder/test.scala 281:17]
  reg  c9_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c9_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c9_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [23:0] acc9; // @[home/void-dreamers/commit_folder/test.scala 283:21]
  reg [15:0] m9; // @[home/void-dreamers/commit_folder/test.scala 284:21]
  wire [15:0] _GEN_51 = 7'h1 == c8_bn ? $signed(16'sh66c3) : $signed(16'sh4596); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_52 = 7'h2 == c8_bn ? $signed(16'sh4566) : $signed(_GEN_51); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_53 = 7'h3 == c8_bn ? $signed(16'sh22c3) : $signed(_GEN_52); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_54 = 7'h4 == c8_bn ? $signed(16'sh5f00) : $signed(_GEN_53); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_55 = 7'h5 == c8_bn ? $signed(16'sh3811) : $signed(_GEN_54); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_56 = 7'h6 == c8_bn ? $signed(16'sh3716) : $signed(_GEN_55); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_57 = 7'h7 == c8_bn ? $signed(16'sh3996) : $signed(_GEN_56); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_58 = 7'h8 == c8_bn ? $signed(16'sh2e8b) : $signed(_GEN_57); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_59 = 7'h9 == c8_bn ? $signed(16'sh5f1d) : $signed(_GEN_58); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_60 = 7'ha == c8_bn ? $signed(16'sh45b1) : $signed(_GEN_59); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_61 = 7'hb == c8_bn ? $signed(16'sh2791) : $signed(_GEN_60); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_62 = 7'hc == c8_bn ? $signed(16'sh374f) : $signed(_GEN_61); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_63 = 7'hd == c8_bn ? $signed(16'sh43e4) : $signed(_GEN_62); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_64 = 7'he == c8_bn ? $signed(16'sh5087) : $signed(_GEN_63); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_65 = 7'hf == c8_bn ? $signed(16'sh4612) : $signed(_GEN_64); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_66 = 7'h10 == c8_bn ? $signed(16'sh5ab5) : $signed(_GEN_65); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_67 = 7'h11 == c8_bn ? $signed(16'sh4f2f) : $signed(_GEN_66); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_68 = 7'h12 == c8_bn ? $signed(16'sh68df) : $signed(_GEN_67); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_69 = 7'h13 == c8_bn ? $signed(16'sh2af8) : $signed(_GEN_68); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_70 = 7'h14 == c8_bn ? $signed(16'sh4ac5) : $signed(_GEN_69); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_71 = 7'h15 == c8_bn ? $signed(16'sh32ab) : $signed(_GEN_70); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_72 = 7'h16 == c8_bn ? $signed(16'sh4eb8) : $signed(_GEN_71); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_73 = 7'h17 == c8_bn ? $signed(16'sh472a) : $signed(_GEN_72); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_74 = 7'h18 == c8_bn ? $signed(16'sh2d07) : $signed(_GEN_73); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_75 = 7'h19 == c8_bn ? $signed(16'sh4205) : $signed(_GEN_74); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_76 = 7'h1a == c8_bn ? $signed(16'sh2a43) : $signed(_GEN_75); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_77 = 7'h1b == c8_bn ? $signed(16'sh25bb) : $signed(_GEN_76); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_78 = 7'h1c == c8_bn ? $signed(16'sh3ad5) : $signed(_GEN_77); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_79 = 7'h1d == c8_bn ? $signed(16'sh3004) : $signed(_GEN_78); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_80 = 7'h1e == c8_bn ? $signed(16'sh3569) : $signed(_GEN_79); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_81 = 7'h1f == c8_bn ? $signed(16'sh2d3b) : $signed(_GEN_80); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_82 = 7'h20 == c8_bn ? $signed(16'sh2adf) : $signed(_GEN_81); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_83 = 7'h21 == c8_bn ? $signed(16'sh3069) : $signed(_GEN_82); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_84 = 7'h22 == c8_bn ? $signed(16'sh2b13) : $signed(_GEN_83); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_85 = 7'h23 == c8_bn ? $signed(16'sh2c54) : $signed(_GEN_84); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_86 = 7'h24 == c8_bn ? $signed(16'sh3297) : $signed(_GEN_85); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_87 = 7'h25 == c8_bn ? $signed(16'sh2f37) : $signed(_GEN_86); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_88 = 7'h26 == c8_bn ? $signed(16'sh28d3) : $signed(_GEN_87); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_89 = 7'h27 == c8_bn ? $signed(16'sh28d2) : $signed(_GEN_88); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_90 = 7'h28 == c8_bn ? $signed(16'sh20c3) : $signed(_GEN_89); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_91 = 7'h29 == c8_bn ? $signed(16'sh31bb) : $signed(_GEN_90); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_92 = 7'h2a == c8_bn ? $signed(16'sh34ca) : $signed(_GEN_91); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_93 = 7'h2b == c8_bn ? $signed(16'sh2d2b) : $signed(_GEN_92); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_94 = 7'h2c == c8_bn ? $signed(16'sh2a7b) : $signed(_GEN_93); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_95 = 7'h2d == c8_bn ? $signed(16'sh3bbf) : $signed(_GEN_94); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_96 = 7'h2e == c8_bn ? $signed(16'sh2bd7) : $signed(_GEN_95); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_97 = 7'h2f == c8_bn ? $signed(16'sh595d) : $signed(_GEN_96); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_98 = 7'h30 == c8_bn ? $signed(16'sh4d87) : $signed(_GEN_97); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_99 = 7'h31 == c8_bn ? $signed(16'sh4de9) : $signed(_GEN_98); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_100 = 7'h32 == c8_bn ? $signed(16'sh75fb) : $signed(_GEN_99); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_101 = 7'h33 == c8_bn ? $signed(16'sh4db9) : $signed(_GEN_100); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_102 = 7'h34 == c8_bn ? $signed(16'sh504f) : $signed(_GEN_101); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_103 = 7'h35 == c8_bn ? $signed(16'sh4763) : $signed(_GEN_102); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_104 = 7'h36 == c8_bn ? $signed(16'sh39c9) : $signed(_GEN_103); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_105 = 7'h37 == c8_bn ? $signed(16'sh5d6d) : $signed(_GEN_104); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_106 = 7'h38 == c8_bn ? $signed(16'sh5a0e) : $signed(_GEN_105); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_107 = 7'h39 == c8_bn ? $signed(16'sh51b5) : $signed(_GEN_106); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_108 = 7'h3a == c8_bn ? $signed(16'sh4052) : $signed(_GEN_107); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_109 = 7'h3b == c8_bn ? $signed(16'sh6fc6) : $signed(_GEN_108); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_110 = 7'h3c == c8_bn ? $signed(16'sh54be) : $signed(_GEN_109); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_111 = 7'h3d == c8_bn ? $signed(16'sh5123) : $signed(_GEN_110); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_112 = 7'h3e == c8_bn ? $signed(16'sh47a3) : $signed(_GEN_111); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_113 = 7'h3f == c8_bn ? $signed(16'sh550c) : $signed(_GEN_112); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_114 = 7'h40 == c8_bn ? $signed(16'sh590b) : $signed(_GEN_113); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_115 = 7'h41 == c8_bn ? $signed(16'sh487c) : $signed(_GEN_114); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_116 = 7'h42 == c8_bn ? $signed(16'sh4bda) : $signed(_GEN_115); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_117 = 7'h43 == c8_bn ? $signed(16'sh6773) : $signed(_GEN_116); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_118 = 7'h44 == c8_bn ? $signed(16'sh5409) : $signed(_GEN_117); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_119 = 7'h45 == c8_bn ? $signed(16'sh5202) : $signed(_GEN_118); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_120 = 7'h46 == c8_bn ? $signed(16'sh3ebd) : $signed(_GEN_119); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_121 = 7'h47 == c8_bn ? $signed(16'sh63d6) : $signed(_GEN_120); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_122 = 7'h48 == c8_bn ? $signed(16'sh50e5) : $signed(_GEN_121); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_123 = 7'h49 == c8_bn ? $signed(16'sh613f) : $signed(_GEN_122); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_124 = 7'h4a == c8_bn ? $signed(16'sh57ff) : $signed(_GEN_123); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_125 = 7'h4b == c8_bn ? $signed(16'sh51a3) : $signed(_GEN_124); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_126 = 7'h4c == c8_bn ? $signed(16'sh42d8) : $signed(_GEN_125); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_127 = 7'h4d == c8_bn ? $signed(16'sh367d) : $signed(_GEN_126); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_128 = 7'h4e == c8_bn ? $signed(16'sh4090) : $signed(_GEN_127); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_129 = 7'h4f == c8_bn ? $signed(16'sh48c7) : $signed(_GEN_128); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_130 = 7'h50 == c8_bn ? $signed(16'sh3981) : $signed(_GEN_129); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_131 = 7'h51 == c8_bn ? $signed(16'sh420f) : $signed(_GEN_130); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_132 = 7'h52 == c8_bn ? $signed(16'sh3ac0) : $signed(_GEN_131); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_133 = 7'h53 == c8_bn ? $signed(16'sh473a) : $signed(_GEN_132); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_134 = 7'h54 == c8_bn ? $signed(16'sh42f5) : $signed(_GEN_133); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_135 = 7'h55 == c8_bn ? $signed(16'sh35b0) : $signed(_GEN_134); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_136 = 7'h56 == c8_bn ? $signed(16'sh3f4c) : $signed(_GEN_135); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_137 = 7'h57 == c8_bn ? $signed(16'sh447f) : $signed(_GEN_136); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_138 = 7'h58 == c8_bn ? $signed(16'sh4410) : $signed(_GEN_137); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_139 = 7'h59 == c8_bn ? $signed(16'sh34c2) : $signed(_GEN_138); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_140 = 7'h5a == c8_bn ? $signed(16'sh4c04) : $signed(_GEN_139); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_141 = 7'h5b == c8_bn ? $signed(16'sh3dc6) : $signed(_GEN_140); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_142 = 7'h5c == c8_bn ? $signed(16'sh4c21) : $signed(_GEN_141); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_143 = 7'h5d == c8_bn ? $signed(16'sh3a96) : $signed(_GEN_142); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_144 = 7'h5e == c8_bn ? $signed(16'sh40d8) : $signed(_GEN_143); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_145 = 7'h5f == c8_bn ? $signed(16'sh3f46) : $signed(_GEN_144); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_146 = 7'h60 == c8_bn ? $signed(16'sh4678) : $signed(_GEN_145); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_147 = 7'h61 == c8_bn ? $signed(16'sh4ed8) : $signed(_GEN_146); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_148 = 7'h62 == c8_bn ? $signed(16'sh49a7) : $signed(_GEN_147); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_149 = 7'h63 == c8_bn ? $signed(16'sh455e) : $signed(_GEN_148); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_150 = 7'h64 == c8_bn ? $signed(16'sh40f5) : $signed(_GEN_149); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_151 = 7'h65 == c8_bn ? $signed(16'sh3e3e) : $signed(_GEN_150); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  wire [15:0] _GEN_152 = 7'h66 == c8_bn ? $signed(16'sh39b4) : $signed(_GEN_151); // @[home/void-dreamers/commit_folder/test.scala 284:{21,21}]
  reg [29:0] bq9; // @[home/void-dreamers/commit_folder/test.scala 285:21]
  wire [29:0] _GEN_158 = 7'h1 == c8_bn ? $signed(30'shda574) : $signed(-30'sh6160); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_159 = 7'h2 == c8_bn ? $signed(-30'sh1780ec) : $signed(_GEN_158); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_160 = 7'h3 == c8_bn ? $signed(30'sh3d349b) : $signed(_GEN_159); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_161 = 7'h4 == c8_bn ? $signed(-30'sh2a0a0d) : $signed(_GEN_160); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_162 = 7'h5 == c8_bn ? $signed(30'sh464382) : $signed(_GEN_161); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_163 = 7'h6 == c8_bn ? $signed(-30'sh228b16) : $signed(_GEN_162); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_164 = 7'h7 == c8_bn ? $signed(-30'sh2c883e) : $signed(_GEN_163); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_165 = 7'h8 == c8_bn ? $signed(30'sh256a23a) : $signed(_GEN_164); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_166 = 7'h9 == c8_bn ? $signed(30'sh1151a1e) : $signed(_GEN_165); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_167 = 7'ha == c8_bn ? $signed(30'sh26c4004) : $signed(_GEN_166); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_168 = 7'hb == c8_bn ? $signed(-30'shd00f09) : $signed(_GEN_167); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_169 = 7'hc == c8_bn ? $signed(30'sh2be8f8) : $signed(_GEN_168); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_170 = 7'hd == c8_bn ? $signed(30'sh96b065) : $signed(_GEN_169); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_171 = 7'he == c8_bn ? $signed(-30'sha333f) : $signed(_GEN_170); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_172 = 7'hf == c8_bn ? $signed(30'sh4a1513) : $signed(_GEN_171); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_173 = 7'h10 == c8_bn ? $signed(-30'sh4d30ee) : $signed(_GEN_172); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_174 = 7'h11 == c8_bn ? $signed(30'sh22dda7) : $signed(_GEN_173); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_175 = 7'h12 == c8_bn ? $signed(-30'sh28793c) : $signed(_GEN_174); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_176 = 7'h13 == c8_bn ? $signed(-30'sh35d09c) : $signed(_GEN_175); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_177 = 7'h14 == c8_bn ? $signed(30'sh2395f49) : $signed(_GEN_176); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_178 = 7'h15 == c8_bn ? $signed(30'shdbb6b0) : $signed(_GEN_177); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_179 = 7'h16 == c8_bn ? $signed(30'sh2853fe) : $signed(_GEN_178); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_180 = 7'h17 == c8_bn ? $signed(-30'sh52ba3) : $signed(_GEN_179); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_181 = 7'h18 == c8_bn ? $signed(30'sh6b5517e) : $signed(_GEN_180); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_182 = 7'h19 == c8_bn ? $signed(30'sh13011a1) : $signed(_GEN_181); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_183 = 7'h1a == c8_bn ? $signed(30'sh3220a03) : $signed(_GEN_182); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_184 = 7'h1b == c8_bn ? $signed(30'sh336043f) : $signed(_GEN_183); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_185 = 7'h1c == c8_bn ? $signed(30'sh1179d41) : $signed(_GEN_184); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_186 = 7'h1d == c8_bn ? $signed(30'sh3b047c9) : $signed(_GEN_185); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_187 = 7'h1e == c8_bn ? $signed(30'sh2a06fcf) : $signed(_GEN_186); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_188 = 7'h1f == c8_bn ? $signed(30'sh499c40) : $signed(_GEN_187); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_189 = 7'h20 == c8_bn ? $signed(-30'sh19e0e38) : $signed(_GEN_188); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_190 = 7'h21 == c8_bn ? $signed(-30'sh1ec9fcb) : $signed(_GEN_189); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_191 = 7'h22 == c8_bn ? $signed(-30'sh28d0092) : $signed(_GEN_190); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_192 = 7'h23 == c8_bn ? $signed(30'sh321b0cc) : $signed(_GEN_191); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_193 = 7'h24 == c8_bn ? $signed(30'sh3c8174b) : $signed(_GEN_192); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_194 = 7'h25 == c8_bn ? $signed(30'sh5030301) : $signed(_GEN_193); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_195 = 7'h26 == c8_bn ? $signed(30'sh5cd73c4) : $signed(_GEN_194); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_196 = 7'h27 == c8_bn ? $signed(30'sh18250a1) : $signed(_GEN_195); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_197 = 7'h28 == c8_bn ? $signed(30'sh361821a) : $signed(_GEN_196); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_198 = 7'h29 == c8_bn ? $signed(30'sh35db12b) : $signed(_GEN_197); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_199 = 7'h2a == c8_bn ? $signed(30'sh4f038d2) : $signed(_GEN_198); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_200 = 7'h2b == c8_bn ? $signed(30'sh8788ab7) : $signed(_GEN_199); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_201 = 7'h2c == c8_bn ? $signed(30'sh962de3f) : $signed(_GEN_200); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_202 = 7'h2d == c8_bn ? $signed(30'sh2a01efe) : $signed(_GEN_201); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_203 = 7'h2e == c8_bn ? $signed(30'sh79700fa) : $signed(_GEN_202); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_204 = 7'h2f == c8_bn ? $signed(30'sh100bc362) : $signed(_GEN_203); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_205 = 7'h30 == c8_bn ? $signed(-30'shafd3ec) : $signed(_GEN_204); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_206 = 7'h31 == c8_bn ? $signed(30'sha981c0c) : $signed(_GEN_205); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_207 = 7'h32 == c8_bn ? $signed(-30'sh90ce47d) : $signed(_GEN_206); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_208 = 7'h33 == c8_bn ? $signed(30'sh6cd5bfa) : $signed(_GEN_207); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_209 = 7'h34 == c8_bn ? $signed(30'sh21c1e7a) : $signed(_GEN_208); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_210 = 7'h35 == c8_bn ? $signed(30'sh1d4c748) : $signed(_GEN_209); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_211 = 7'h36 == c8_bn ? $signed(-30'sh5b17082) : $signed(_GEN_210); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_212 = 7'h37 == c8_bn ? $signed(30'sh5176481) : $signed(_GEN_211); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_213 = 7'h38 == c8_bn ? $signed(30'sh9404513) : $signed(_GEN_212); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_214 = 7'h39 == c8_bn ? $signed(30'sh8d6d75c) : $signed(_GEN_213); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_215 = 7'h3a == c8_bn ? $signed(30'sh6a8d0b4) : $signed(_GEN_214); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_216 = 7'h3b == c8_bn ? $signed(30'shf00623) : $signed(_GEN_215); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_217 = 7'h3c == c8_bn ? $signed(30'sha20997d) : $signed(_GEN_216); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_218 = 7'h3d == c8_bn ? $signed(-30'sh7a95cbf) : $signed(_GEN_217); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_219 = 7'h3e == c8_bn ? $signed(-30'sh7109cc1) : $signed(_GEN_218); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_220 = 7'h3f == c8_bn ? $signed(30'sh3cdfd86) : $signed(_GEN_219); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_221 = 7'h40 == c8_bn ? $signed(30'sh575b9b2) : $signed(_GEN_220); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_222 = 7'h41 == c8_bn ? $signed(-30'sh207a58e) : $signed(_GEN_221); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_223 = 7'h42 == c8_bn ? $signed(30'sh2095f4f) : $signed(_GEN_222); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_224 = 7'h43 == c8_bn ? $signed(-30'sh4d610fb) : $signed(_GEN_223); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_225 = 7'h44 == c8_bn ? $signed(30'sh1b8f2bf) : $signed(_GEN_224); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_226 = 7'h45 == c8_bn ? $signed(30'sh201aa7a) : $signed(_GEN_225); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_227 = 7'h46 == c8_bn ? $signed(30'sh5676eb7) : $signed(_GEN_226); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_228 = 7'h47 == c8_bn ? $signed(30'sh20bdd78) : $signed(_GEN_227); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_229 = 7'h48 == c8_bn ? $signed(30'sh24b38f3) : $signed(_GEN_228); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_230 = 7'h49 == c8_bn ? $signed(30'sh7409f0f) : $signed(_GEN_229); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_231 = 7'h4a == c8_bn ? $signed(30'sh2fe7365) : $signed(_GEN_230); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_232 = 7'h4b == c8_bn ? $signed(30'sh21924d3) : $signed(_GEN_231); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_233 = 7'h4c == c8_bn ? $signed(30'sh18164c5) : $signed(_GEN_232); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_234 = 7'h4d == c8_bn ? $signed(30'sh3825c7c) : $signed(_GEN_233); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_235 = 7'h4e == c8_bn ? $signed(30'sh24bf9f8) : $signed(_GEN_234); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_236 = 7'h4f == c8_bn ? $signed(-30'shecf195a) : $signed(_GEN_235); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_237 = 7'h50 == c8_bn ? $signed(-30'sh14637370) : $signed(_GEN_236); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_238 = 7'h51 == c8_bn ? $signed(-30'sha1d8028) : $signed(_GEN_237); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_239 = 7'h52 == c8_bn ? $signed(-30'shade17e3) : $signed(_GEN_238); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_240 = 7'h53 == c8_bn ? $signed(-30'sh5fca731) : $signed(_GEN_239); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_241 = 7'h54 == c8_bn ? $signed(30'shc9b935f) : $signed(_GEN_240); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_242 = 7'h55 == c8_bn ? $signed(-30'sh175ee87) : $signed(_GEN_241); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_243 = 7'h56 == c8_bn ? $signed(30'sh61aff04) : $signed(_GEN_242); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_244 = 7'h57 == c8_bn ? $signed(-30'sh7975abb) : $signed(_GEN_243); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_245 = 7'h58 == c8_bn ? $signed(-30'sh5f31d46) : $signed(_GEN_244); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_246 = 7'h59 == c8_bn ? $signed(-30'sh15be7af) : $signed(_GEN_245); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_247 = 7'h5a == c8_bn ? $signed(30'sh39ea3dc) : $signed(_GEN_246); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_248 = 7'h5b == c8_bn ? $signed(-30'sh18c0b22) : $signed(_GEN_247); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_249 = 7'h5c == c8_bn ? $signed(-30'sh831737a) : $signed(_GEN_248); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_250 = 7'h5d == c8_bn ? $signed(-30'shf0bb40) : $signed(_GEN_249); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_251 = 7'h5e == c8_bn ? $signed(30'sha10ca0) : $signed(_GEN_250); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_252 = 7'h5f == c8_bn ? $signed(-30'sh5528095) : $signed(_GEN_251); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_253 = 7'h60 == c8_bn ? $signed(-30'sh782af57) : $signed(_GEN_252); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_254 = 7'h61 == c8_bn ? $signed(-30'sh4b8b482) : $signed(_GEN_253); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_255 = 7'h62 == c8_bn ? $signed(-30'sh72d31d3) : $signed(_GEN_254); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_256 = 7'h63 == c8_bn ? $signed(30'sh5394b26) : $signed(_GEN_255); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_257 = 7'h64 == c8_bn ? $signed(-30'shcbe8a86) : $signed(_GEN_256); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_258 = 7'h65 == c8_bn ? $signed(30'sh3debdb6) : $signed(_GEN_257); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  wire [29:0] _GEN_259 = 7'h66 == c8_bn ? $signed(30'sh245a137) : $signed(_GEN_258); // @[home/void-dreamers/commit_folder/test.scala 285:{21,21}]
  reg  c10_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c10_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c10_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [39:0] prodA10; // @[home/void-dreamers/commit_folder/test.scala 289:24]
  reg [29:0] bq10; // @[home/void-dreamers/commit_folder/test.scala 290:24]
  reg  c11_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c11_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c11_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [39:0] prodB11; // @[home/void-dreamers/commit_folder/test.scala 292:24]
  reg [29:0] bq11; // @[home/void-dreamers/commit_folder/test.scala 293:24]
  reg  c12_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c12_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c12_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  wire [39:0] _GEN_514 = {{10{bq11[29]}},bq11}; // @[home/void-dreamers/commit_folder/test.scala 297:31]
  reg [40:0] sum12; // @[home/void-dreamers/commit_folder/test.scala 297:22]
  reg  c13_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c13_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c13_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [40:0] shifted13; // @[home/void-dreamers/commit_folder/test.scala 301:26]
  reg  c14_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c14_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg  c14_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
  reg [5:0] q14; // @[home/void-dreamers/commit_folder/test.scala 305:20]
  reg [5:0] poolMax; // @[home/void-dreamers/commit_folder/test.scala 310:24]
  reg  wrEn15; // @[home/void-dreamers/commit_folder/test.scala 313:25]
  reg [5:0] wrData15; // @[home/void-dreamers/commit_folder/test.scala 314:25]
  wire [12:0] _wrPtr_T_1 = wrPtr + 13'h1; // @[home/void-dreamers/commit_folder/test.scala 317:33]
  reg  ldEn; // @[home/void-dreamers/commit_folder/test.scala 320:23]
  reg [11:0] ldAddr; // @[home/void-dreamers/commit_folder/test.scala 321:23]
  reg [3:0] ldData; // @[home/void-dreamers/commit_folder/test.scala 322:23]
  wire  _wenA_T = wrEn15 & sel; // @[home/void-dreamers/commit_folder/test.scala 324:30]
  wire  pipeBusy = c1_v | c2_v | c3_v | c4_v | c5_v | c6_v | c7_v | c8_v | c9_v | c10_v | c11_v | c12_v | c13_v | c14_v
     | wrEn15; // @[home/void-dreamers/commit_folder/test.scala 330:34]
  wire  _T_5 = ready & io_start; // @[home/void-dreamers/commit_folder/test.scala 333:14]
  wire [2:0] _GEN_276 = ready & io_start ? 3'h0 : layer; // @[home/void-dreamers/commit_folder/test.scala 333:27 334:13 143:22]
  wire  _GEN_277 = ready & io_start ? 1'h0 : sel; // @[home/void-dreamers/commit_folder/test.scala 333:27 335:13 144:22]
  wire [2:0] _GEN_280 = ready & io_start ? 3'h1 : _GEN_36; // @[home/void-dreamers/commit_folder/test.scala 333:27 338:13]
  wire  _GEN_283 = 3'h2 == layer ? 1'h0 : 1'h1; // @[home/void-dreamers/commit_folder/test.scala 342:{13,13}]
  wire  _GEN_285 = 3'h4 == layer ? 1'h0 : 3'h3 == layer | _GEN_283; // @[home/void-dreamers/commit_folder/test.scala 342:{13,13}]
  wire  _GEN_286 = 3'h5 == layer ? 1'h0 : _GEN_285; // @[home/void-dreamers/commit_folder/test.scala 342:{13,13}]
  wire [6:0] _GEN_288 = 3'h1 == layer ? 7'h20 : 7'h40; // @[home/void-dreamers/commit_folder/test.scala 343:{13,13}]
  wire [6:0] _GEN_289 = 3'h2 == layer ? 7'h10 : _GEN_288; // @[home/void-dreamers/commit_folder/test.scala 343:{13,13}]
  wire [6:0] _GEN_290 = 3'h3 == layer ? 7'h10 : _GEN_289; // @[home/void-dreamers/commit_folder/test.scala 343:{13,13}]
  wire [2:0] _GEN_294 = 3'h1 == layer ? 3'h5 : 3'h6; // @[home/void-dreamers/commit_folder/test.scala 344:{13,13}]
  wire [2:0] _GEN_295 = 3'h2 == layer ? 3'h4 : _GEN_294; // @[home/void-dreamers/commit_folder/test.scala 344:{13,13}]
  wire [2:0] _GEN_296 = 3'h3 == layer ? 3'h4 : _GEN_295; // @[home/void-dreamers/commit_folder/test.scala 344:{13,13}]
  wire [3:0] _GEN_300 = 3'h1 == layer ? 4'ha : 4'hc; // @[home/void-dreamers/commit_folder/test.scala 345:{13,13}]
  wire [3:0] _GEN_301 = 3'h2 == layer ? 4'h8 : _GEN_300; // @[home/void-dreamers/commit_folder/test.scala 345:{13,13}]
  wire [3:0] _GEN_302 = 3'h3 == layer ? 4'h8 : _GEN_301; // @[home/void-dreamers/commit_folder/test.scala 345:{13,13}]
  wire [4:0] _GEN_306 = 3'h1 == layer ? 5'h15 : 5'h13; // @[home/void-dreamers/commit_folder/test.scala 346:{13,13}]
  wire [4:0] _GEN_307 = 3'h2 == layer ? 5'h16 : _GEN_306; // @[home/void-dreamers/commit_folder/test.scala 346:{13,13}]
  wire [4:0] _GEN_308 = 3'h3 == layer ? 5'h16 : _GEN_307; // @[home/void-dreamers/commit_folder/test.scala 346:{13,13}]
  wire [8:0] _GEN_312 = 3'h1 == layer ? 9'h48 : 9'h9; // @[home/void-dreamers/commit_folder/test.scala 347:{13,13}]
  wire [8:0] _GEN_313 = 3'h2 == layer ? 9'h90 : _GEN_312; // @[home/void-dreamers/commit_folder/test.scala 347:{13,13}]
  wire [8:0] _GEN_314 = 3'h3 == layer ? 9'hcf : _GEN_313; // @[home/void-dreamers/commit_folder/test.scala 347:{13,13}]
  wire [5:0] _GEN_318 = 3'h1 == layer ? 6'h7 : 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_319 = 3'h2 == layer ? 6'hf : _GEN_318; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_320 = 3'h3 == layer ? 6'h16 : _GEN_319; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_321 = 3'h4 == layer ? 6'h1e : _GEN_320; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_322 = 3'h5 == layer ? 6'h1e : _GEN_321; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_330 = 3'h1 == layer ? 6'hf : 6'h1f; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_331 = 3'h2 == layer ? 6'hf : _GEN_330; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_332 = 3'h3 == layer ? 6'h7 : _GEN_331; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_333 = 3'h4 == layer ? 6'h7 : _GEN_332; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_334 = 3'h5 == layer ? 6'h7 : _GEN_333; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_336 = 3'h1 == layer ? 6'hf : 6'h7; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_337 = 3'h2 == layer ? 6'h16 : _GEN_336; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_338 = 3'h3 == layer ? 6'h1e : _GEN_337; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_339 = 3'h4 == layer ? 6'h1c : _GEN_338; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [5:0] _GEN_340 = 3'h5 == layer ? 6'h1c : _GEN_339; // @[home/void-dreamers/commit_folder/test.scala 63:{40,40}]
  wire [2:0] _GEN_373 = state == 3'h1 ? 3'h2 : _GEN_280; // @[home/void-dreamers/commit_folder/test.scala 341:26 355:11]
  wire [2:0] _layer_T_1 = layer + 3'h1; // @[home/void-dreamers/commit_folder/test.scala 363:22]
  wire [2:0] _GEN_374 = layer == 3'h4 ? 3'h4 : 3'h1; // @[home/void-dreamers/commit_folder/test.scala 359:37 360:14 365:13]
  wire [2:0] _GEN_378 = state == 3'h3 & ~pipeBusy ? _GEN_374 : _GEN_373; // @[home/void-dreamers/commit_folder/test.scala 358:41]
  reg [31:0] accFc_0; // @[home/void-dreamers/commit_folder/test.scala 370:22]
  reg [31:0] accFc_1; // @[home/void-dreamers/commit_folder/test.scala 370:22]
  wire [10:0] _gapIdx_T_1 = gapIdx + 11'h1; // @[home/void-dreamers/commit_folder/test.scala 374:22]
  wire [2:0] _GEN_385 = gapIdx == 11'h73f ? 3'h5 : _GEN_378; // @[home/void-dreamers/commit_folder/test.scala 375:50 377:14]
  reg  gv1; // @[home/void-dreamers/commit_folder/test.scala 382:24]
  reg  gFirst1; // @[home/void-dreamers/commit_folder/test.scala 383:24]
  reg  gLast1; // @[home/void-dreamers/commit_folder/test.scala 384:24]
  reg [4:0] gCh1; // @[home/void-dreamers/commit_folder/test.scala 385:24]
  reg  gv2; // @[home/void-dreamers/commit_folder/test.scala 389:24]
  reg  gFirst2; // @[home/void-dreamers/commit_folder/test.scala 390:24]
  reg  gLast2; // @[home/void-dreamers/commit_folder/test.scala 391:24]
  reg [4:0] gCh2; // @[home/void-dreamers/commit_folder/test.scala 392:24]
  reg [5:0] gData2; // @[home/void-dreamers/commit_folder/test.scala 393:24]
  reg [15:0] sAcc; // @[home/void-dreamers/commit_folder/test.scala 394:24]
  wire [15:0] _sNext_T = gFirst2 ? 16'h0 : sAcc; // @[home/void-dreamers/commit_folder/test.scala 395:20]
  wire [15:0] _GEN_517 = {{10'd0}, gData2}; // @[home/void-dreamers/commit_folder/test.scala 395:41]
  wire [15:0] sNext = _sNext_T + _GEN_517; // @[home/void-dreamers/commit_folder/test.scala 395:41]
  reg  gv3; // @[home/void-dreamers/commit_folder/test.scala 399:23]
  reg [15:0] sFin3; // @[home/void-dreamers/commit_folder/test.scala 401:23]
  reg [4:0] gCh3; // @[home/void-dreamers/commit_folder/test.scala 402:21]
  wire  _T_13 = ~reset; // @[home/void-dreamers/commit_folder/test.scala 403:21]
  wire  _T_14 = state == 3'h6; // @[home/void-dreamers/commit_folder/test.scala 404:14]
  wire [5:0] _code3_T = {{1'd0}, gCh2}; // @[home/void-dreamers/commit_folder/test.scala 406:56]
  reg [3:0] code3_0; // @[home/void-dreamers/commit_folder/test.scala 406:44]
  wire [3:0] _GEN_391 = 6'h2 == _code3_T ? 4'h1 : 4'h9; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_392 = 6'h3 == _code3_T ? 4'h9 : _GEN_391; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_393 = 6'h4 == _code3_T ? 4'h1 : _GEN_392; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_394 = 6'h5 == _code3_T ? 4'h1 : _GEN_393; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_395 = 6'h6 == _code3_T ? 4'h2 : _GEN_394; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_396 = 6'h7 == _code3_T ? 4'ha : _GEN_395; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_397 = 6'h8 == _code3_T ? 4'h2 : _GEN_396; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_398 = 6'h9 == _code3_T ? 4'h9 : _GEN_397; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_399 = 6'ha == _code3_T ? 4'h9 : _GEN_398; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_400 = 6'hb == _code3_T ? 4'h2 : _GEN_399; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_401 = 6'hc == _code3_T ? 4'h1 : _GEN_400; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_402 = 6'hd == _code3_T ? 4'h2 : _GEN_401; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_403 = 6'he == _code3_T ? 4'h9 : _GEN_402; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_404 = 6'hf == _code3_T ? 4'h9 : _GEN_403; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_405 = 6'h10 == _code3_T ? 4'h9 : _GEN_404; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_406 = 6'h11 == _code3_T ? 4'h2 : _GEN_405; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_407 = 6'h12 == _code3_T ? 4'h9 : _GEN_406; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_408 = 6'h13 == _code3_T ? 4'h1 : _GEN_407; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_409 = 6'h14 == _code3_T ? 4'h9 : _GEN_408; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_410 = 6'h15 == _code3_T ? 4'h9 : _GEN_409; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_411 = 6'h16 == _code3_T ? 4'h9 : _GEN_410; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_412 = 6'h17 == _code3_T ? 4'h2 : _GEN_411; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_413 = 6'h18 == _code3_T ? 4'h9 : _GEN_412; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_414 = 6'h19 == _code3_T ? 4'h1 : _GEN_413; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_415 = 6'h1a == _code3_T ? 4'h1 : _GEN_414; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_416 = 6'h1b == _code3_T ? 4'h9 : _GEN_415; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_417 = 6'h1c == _code3_T ? 4'ha : _GEN_416; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_418 = 6'h1d == _code3_T ? 4'h1 : _GEN_417; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_419 = 6'h1e == _code3_T ? 4'h1 : _GEN_418; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_420 = 6'h1f == _code3_T ? 4'ha : _GEN_419; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_421 = 6'h20 == _code3_T ? 4'h1 : _GEN_420; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_422 = 6'h21 == _code3_T ? 4'ha : _GEN_421; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_423 = 6'h22 == _code3_T ? 4'ha : _GEN_422; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_424 = 6'h23 == _code3_T ? 4'h9 : _GEN_423; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_425 = 6'h24 == _code3_T ? 4'h1 : _GEN_424; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_426 = 6'h25 == _code3_T ? 4'h9 : _GEN_425; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_427 = 6'h26 == _code3_T ? 4'h1 : _GEN_426; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_428 = 6'h27 == _code3_T ? 4'h2 : _GEN_427; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_429 = 6'h28 == _code3_T ? 4'h9 : _GEN_428; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_430 = 6'h29 == _code3_T ? 4'ha : _GEN_429; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_431 = 6'h2a == _code3_T ? 4'h9 : _GEN_430; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_432 = 6'h2b == _code3_T ? 4'h1 : _GEN_431; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_433 = 6'h2c == _code3_T ? 4'h1 : _GEN_432; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_434 = 6'h2d == _code3_T ? 4'h1 : _GEN_433; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_435 = 6'h2e == _code3_T ? 4'h9 : _GEN_434; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_436 = 6'h2f == _code3_T ? 4'h1 : _GEN_435; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_437 = 6'h30 == _code3_T ? 4'h9 : _GEN_436; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_438 = 6'h31 == _code3_T ? 4'h1 : _GEN_437; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_439 = 6'h32 == _code3_T ? 4'h1 : _GEN_438; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_440 = 6'h33 == _code3_T ? 4'h2 : _GEN_439; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_441 = 6'h34 == _code3_T ? 4'h9 : _GEN_440; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_442 = 6'h35 == _code3_T ? 4'h2 : _GEN_441; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [5:0] _code3_T_3 = gCh2 + 5'h1d; // @[home/void-dreamers/commit_folder/test.scala 406:56]
  reg [3:0] code3_1; // @[home/void-dreamers/commit_folder/test.scala 406:44]
  wire [3:0] _GEN_449 = 6'h2 == _code3_T_3 ? 4'h1 : 4'h9; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_450 = 6'h3 == _code3_T_3 ? 4'h9 : _GEN_449; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_451 = 6'h4 == _code3_T_3 ? 4'h1 : _GEN_450; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_452 = 6'h5 == _code3_T_3 ? 4'h1 : _GEN_451; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_453 = 6'h6 == _code3_T_3 ? 4'h2 : _GEN_452; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_454 = 6'h7 == _code3_T_3 ? 4'ha : _GEN_453; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_455 = 6'h8 == _code3_T_3 ? 4'h2 : _GEN_454; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_456 = 6'h9 == _code3_T_3 ? 4'h9 : _GEN_455; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_457 = 6'ha == _code3_T_3 ? 4'h9 : _GEN_456; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_458 = 6'hb == _code3_T_3 ? 4'h2 : _GEN_457; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_459 = 6'hc == _code3_T_3 ? 4'h1 : _GEN_458; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_460 = 6'hd == _code3_T_3 ? 4'h2 : _GEN_459; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_461 = 6'he == _code3_T_3 ? 4'h9 : _GEN_460; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_462 = 6'hf == _code3_T_3 ? 4'h9 : _GEN_461; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_463 = 6'h10 == _code3_T_3 ? 4'h9 : _GEN_462; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_464 = 6'h11 == _code3_T_3 ? 4'h2 : _GEN_463; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_465 = 6'h12 == _code3_T_3 ? 4'h9 : _GEN_464; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_466 = 6'h13 == _code3_T_3 ? 4'h1 : _GEN_465; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_467 = 6'h14 == _code3_T_3 ? 4'h9 : _GEN_466; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_468 = 6'h15 == _code3_T_3 ? 4'h9 : _GEN_467; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_469 = 6'h16 == _code3_T_3 ? 4'h9 : _GEN_468; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_470 = 6'h17 == _code3_T_3 ? 4'h2 : _GEN_469; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_471 = 6'h18 == _code3_T_3 ? 4'h9 : _GEN_470; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_472 = 6'h19 == _code3_T_3 ? 4'h1 : _GEN_471; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_473 = 6'h1a == _code3_T_3 ? 4'h1 : _GEN_472; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_474 = 6'h1b == _code3_T_3 ? 4'h9 : _GEN_473; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_475 = 6'h1c == _code3_T_3 ? 4'ha : _GEN_474; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_476 = 6'h1d == _code3_T_3 ? 4'h1 : _GEN_475; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_477 = 6'h1e == _code3_T_3 ? 4'h1 : _GEN_476; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_478 = 6'h1f == _code3_T_3 ? 4'ha : _GEN_477; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_479 = 6'h20 == _code3_T_3 ? 4'h1 : _GEN_478; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_480 = 6'h21 == _code3_T_3 ? 4'ha : _GEN_479; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_481 = 6'h22 == _code3_T_3 ? 4'ha : _GEN_480; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_482 = 6'h23 == _code3_T_3 ? 4'h9 : _GEN_481; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_483 = 6'h24 == _code3_T_3 ? 4'h1 : _GEN_482; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_484 = 6'h25 == _code3_T_3 ? 4'h9 : _GEN_483; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_485 = 6'h26 == _code3_T_3 ? 4'h1 : _GEN_484; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_486 = 6'h27 == _code3_T_3 ? 4'h2 : _GEN_485; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_487 = 6'h28 == _code3_T_3 ? 4'h9 : _GEN_486; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_488 = 6'h29 == _code3_T_3 ? 4'ha : _GEN_487; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_489 = 6'h2a == _code3_T_3 ? 4'h9 : _GEN_488; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_490 = 6'h2b == _code3_T_3 ? 4'h1 : _GEN_489; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_491 = 6'h2c == _code3_T_3 ? 4'h1 : _GEN_490; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_492 = 6'h2d == _code3_T_3 ? 4'h1 : _GEN_491; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_493 = 6'h2e == _code3_T_3 ? 4'h9 : _GEN_492; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_494 = 6'h2f == _code3_T_3 ? 4'h1 : _GEN_493; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_495 = 6'h30 == _code3_T_3 ? 4'h9 : _GEN_494; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_496 = 6'h31 == _code3_T_3 ? 4'h1 : _GEN_495; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_497 = 6'h32 == _code3_T_3 ? 4'h1 : _GEN_496; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_498 = 6'h33 == _code3_T_3 ? 4'h2 : _GEN_497; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_499 = 6'h34 == _code3_T_3 ? 4'h9 : _GEN_498; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  wire [3:0] _GEN_500 = 6'h35 == _code3_T_3 ? 4'h2 : _GEN_499; // @[home/void-dreamers/commit_folder/test.scala 406:{44,44}]
  reg  gv4; // @[home/void-dreamers/commit_folder/test.scala 409:21]
  reg  gv5; // @[home/void-dreamers/commit_folder/test.scala 410:21]
  wire [2:0] e3 = code3_0[2:0]; // @[home/void-dreamers/commit_folder/test.scala 412:25]
  wire [2:0] _mag4_T_2 = 3'h7 - e3; // @[home/void-dreamers/commit_folder/test.scala 413:71]
  wire [22:0] _GEN_40 = {{7'd0}, sFin3}; // @[home/void-dreamers/commit_folder/test.scala 413:58]
  wire [22:0] _mag4_T_3 = _GEN_40 << _mag4_T_2; // @[home/void-dreamers/commit_folder/test.scala 413:58]
  reg [19:0] mag4; // @[home/void-dreamers/commit_folder/test.scala 413:23]
  reg  sg4; // @[home/void-dreamers/commit_folder/test.scala 414:23]
  wire [20:0] m4S = {1'h0,mag4}; // @[home/void-dreamers/commit_folder/test.scala 415:36]
  wire [20:0] _term5_T_2 = 21'sh0 - $signed(m4S); // @[home/void-dreamers/commit_folder/test.scala 416:38]
  reg [20:0] term5; // @[home/void-dreamers/commit_folder/test.scala 416:24]
  wire [31:0] _GEN_518 = {{11{term5[20]}},term5}; // @[home/void-dreamers/commit_folder/test.scala 417:40]
  wire [31:0] _accFc_0_T_2 = $signed(accFc_0) + $signed(_GEN_518); // @[home/void-dreamers/commit_folder/test.scala 417:40]
  wire [2:0] e3_1 = code3_1[2:0]; // @[home/void-dreamers/commit_folder/test.scala 412:25]
  wire [2:0] _mag4_T_8 = 3'h7 - e3_1; // @[home/void-dreamers/commit_folder/test.scala 413:71]
  wire [22:0] _GEN_41 = {{7'd0}, sFin3}; // @[home/void-dreamers/commit_folder/test.scala 413:58]
  wire [22:0] _mag4_T_9 = _GEN_41 << _mag4_T_8; // @[home/void-dreamers/commit_folder/test.scala 413:58]
  reg [19:0] mag4_1; // @[home/void-dreamers/commit_folder/test.scala 413:23]
  reg  sg4_1; // @[home/void-dreamers/commit_folder/test.scala 414:23]
  wire [20:0] m4S_1 = {1'h0,mag4_1}; // @[home/void-dreamers/commit_folder/test.scala 415:36]
  wire [20:0] _term5_T_6 = 21'sh0 - $signed(m4S_1); // @[home/void-dreamers/commit_folder/test.scala 416:38]
  reg [20:0] term5_1; // @[home/void-dreamers/commit_folder/test.scala 416:24]
  wire [31:0] _GEN_519 = {{11{term5_1[20]}},term5_1}; // @[home/void-dreamers/commit_folder/test.scala 417:40]
  wire [31:0] _accFc_1_T_2 = $signed(accFc_1) + $signed(_GEN_519); // @[home/void-dreamers/commit_folder/test.scala 417:40]
  wire  gapBusy = gv1 | gv2 | gv3 | gv4 | gv5; // @[home/void-dreamers/commit_folder/test.scala 419:42]
  reg [31:0] dR; // @[home/void-dreamers/commit_folder/test.scala 425:22]
  reg  predR; // @[home/void-dreamers/commit_folder/test.scala 426:22]
  assign wRom_wcode2_en = wRom_wcode2_en_pipe_0;
  assign wRom_wcode2_addr = wRom_wcode2_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign wRom_wcode2_data = wRom[wRom_wcode2_addr]; // @[home/void-dreamers/commit_folder/test.scala 106:25]
  `else
  assign wRom_wcode2_data = wRom_wcode2_addr >= 15'h4a64 ? _RAND_0[3:0] : wRom[wRom_wcode2_addr]; // @[home/void-dreamers/commit_folder/test.scala 106:25]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign actA_rdA_en = actA_rdA_en_pipe_0;
  assign actA_rdA_addr = actA_rdA_addr_pipe_0;
  assign actA_rdA_data = actA[actA_rdA_addr]; // @[home/void-dreamers/commit_folder/test.scala 137:25]
  assign actA_MPORT_data = ldEn ? {{2'd0}, ldData} : wrData15;
  assign actA_MPORT_addr = ldEn ? {{1'd0}, ldAddr} : wrPtr;
  assign actA_MPORT_mask = 1'h1;
  assign actA_MPORT_en = ldEn | _wenA_T;
  assign actB_rdB_en = actB_rdB_en_pipe_0;
  assign actB_rdB_addr = actB_rdB_addr_pipe_0;
  assign actB_rdB_data = actB[actB_rdB_addr]; // @[home/void-dreamers/commit_folder/test.scala 138:25]
  assign actB_MPORT_1_data = wrData15;
  assign actB_MPORT_1_addr = wrPtr;
  assign actB_MPORT_1_mask = 1'h1;
  assign actB_MPORT_1_en = wrEn15 & _rdEnA_T;
  assign io_busy = ~ready; // @[home/void-dreamers/commit_folder/test.scala 430:14]
  assign io_done = state == 3'h7; // @[home/void-dreamers/commit_folder/test.scala 429:20]
  assign io_pred = predR; // @[home/void-dreamers/commit_folder/test.scala 428:11]
  assign io_dOut = dR; // @[home/void-dreamers/commit_folder/test.scala 427:11]
  always @(posedge clock) begin
    wRom_wcode2_en_pipe_0 <= c1_v;
    if (c1_v) begin
      wRom_wcode2_addr_pipe_0 <= wIdx1;
    end
    if (actA_MPORT_en & actA_MPORT_mask) begin
      actA[actA_MPORT_addr] <= actA_MPORT_data; // @[home/void-dreamers/commit_folder/test.scala 137:25]
    end
    actA_rdA_en_pipe_0 <= c4_v & _rdEnA_T;
    if (c4_v & _rdEnA_T) begin
      if (inGap) begin
        actA_rdA_addr_pipe_0 <= {{2'd0}, gapIdx};
      end else begin
        actA_rdA_addr_pipe_0 <= addr4;
      end
    end
    if (actB_MPORT_1_en & actB_MPORT_1_mask) begin
      actB[actB_MPORT_1_addr] <= actB_MPORT_1_data; // @[home/void-dreamers/commit_folder/test.scala 138:25]
    end
    actB_rdB_en_pipe_0 <= _rdEnB_T | inGap;
    if (_rdEnB_T | inGap) begin
      if (inGap) begin
        actB_rdB_addr_pipe_0 <= {{2'd0}, gapIdx};
      end else begin
        actB_rdB_addr_pipe_0 <= addr4;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 129:24]
      poolR <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 129:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 342:13]
        poolR <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 342:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 342:13]
        poolR <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 342:13]
      end else begin
        poolR <= 3'h3 == layer | _GEN_283;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 130:24]
      hinR <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 130:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 343:13]
        hinR <= 7'h8; // @[home/void-dreamers/commit_folder/test.scala 343:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 343:13]
        hinR <= 7'h8; // @[home/void-dreamers/commit_folder/test.scala 343:13]
      end else begin
        hinR <= _GEN_290;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 131:24]
      lgHinR <= 3'h0; // @[home/void-dreamers/commit_folder/test.scala 131:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 344:13]
        lgHinR <= 3'h3; // @[home/void-dreamers/commit_folder/test.scala 344:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 344:13]
        lgHinR <= 3'h3; // @[home/void-dreamers/commit_folder/test.scala 344:13]
      end else begin
        lgHinR <= _GEN_296;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 132:24]
      lgHinwR <= 4'h0; // @[home/void-dreamers/commit_folder/test.scala 132:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 345:13]
        lgHinwR <= 4'h6; // @[home/void-dreamers/commit_folder/test.scala 345:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 345:13]
        lgHinwR <= 4'h6; // @[home/void-dreamers/commit_folder/test.scala 345:13]
      end else begin
        lgHinwR <= _GEN_302;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 133:24]
      shR <= 5'h0; // @[home/void-dreamers/commit_folder/test.scala 133:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 346:13]
        shR <= 5'h17; // @[home/void-dreamers/commit_folder/test.scala 346:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 346:13]
        shR <= 5'h17; // @[home/void-dreamers/commit_folder/test.scala 346:13]
      end else begin
        shR <= _GEN_308;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 134:24]
      cin9R <= 9'h0; // @[home/void-dreamers/commit_folder/test.scala 134:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 347:13]
        cin9R <= 9'h117; // @[home/void-dreamers/commit_folder/test.scala 347:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 347:13]
        cin9R <= 9'h117; // @[home/void-dreamers/commit_folder/test.scala 347:13]
      end else begin
        cin9R <= _GEN_314;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 141:22]
      state <= 3'h0; // @[home/void-dreamers/commit_folder/test.scala 141:22]
    end else if (_T_14) begin // @[home/void-dreamers/commit_folder/test.scala 422:26]
      state <= 3'h7; // @[home/void-dreamers/commit_folder/test.scala 422:34]
    end else if (state == 3'h5 & ~gapBusy) begin // @[home/void-dreamers/commit_folder/test.scala 421:43]
      state <= 3'h6; // @[home/void-dreamers/commit_folder/test.scala 421:51]
    end else if (inGap) begin // @[home/void-dreamers/commit_folder/test.scala 373:15]
      state <= _GEN_385;
    end else begin
      state <= _GEN_378;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 143:22]
      layer <= 3'h0; // @[home/void-dreamers/commit_folder/test.scala 143:22]
    end else if (state == 3'h3 & ~pipeBusy) begin // @[home/void-dreamers/commit_folder/test.scala 358:41]
      if (layer == 3'h4) begin // @[home/void-dreamers/commit_folder/test.scala 359:37]
        layer <= _GEN_276;
      end else begin
        layer <= _layer_T_1; // @[home/void-dreamers/commit_folder/test.scala 363:13]
      end
    end else begin
      layer <= _GEN_276;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 144:22]
      sel <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 144:22]
    end else if (state == 3'h3 & ~pipeBusy) begin // @[home/void-dreamers/commit_folder/test.scala 358:41]
      if (layer == 3'h4) begin // @[home/void-dreamers/commit_folder/test.scala 359:37]
        sel <= _GEN_277;
      end else begin
        sel <= _rdEnA_T; // @[home/void-dreamers/commit_folder/test.scala 364:13]
      end
    end else begin
      sel <= _GEN_277;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (run) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt <= _cnt_T_1; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (run) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last <= max == 2'h0; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last <= _cnt_T_1 == max; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      max <= 2'h2; // @[home/void-dreamers/commit_folder/test.scala 63:40]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_1 <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_1 <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enKy) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_1) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_1 <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_1 <= _cnt_T_3; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_1 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_1 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enKy) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_1) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_1 <= max_1 == 2'h0; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_1 <= _cnt_T_3 == max_1; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_1 <= 2'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      max_1 <= 2'h2; // @[home/void-dreamers/commit_folder/test.scala 63:40]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_2 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_2 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enCi) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_2) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_2 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_2 <= _cnt_T_5; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_2 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_2 <= _GEN_322 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enCi) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_2) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_2 <= max_2 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_2 <= _cnt_T_5 == max_2; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_2 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_2 <= 6'h1e; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_2 <= 6'h1e; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else begin
        max_2 <= _GEN_320;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enPx) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_3) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_3 <= cnt_3 + 1'h1; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_3 <= ~_GEN_286; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enPx) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_3) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_3 <= ~max_3; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_3 <= cnt_3 + 1'h1 == max_3; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 342:13]
        max_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 342:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 342:13]
        max_3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 342:13]
      end else begin
        max_3 <= 3'h3 == layer | _GEN_283;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enPy) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_4) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_4 <= cnt_4 + 1'h1; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_4 <= ~_GEN_286; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enPy) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_4) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_4 <= ~max_4; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_4 <= cnt_4 + 1'h1 == max_4; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 342:13]
        max_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 342:13]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 342:13]
        max_4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 342:13]
      end else begin
        max_4 <= 3'h3 == layer | _GEN_283;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_5 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_5 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enCol) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_5) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_5 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_5 <= _cnt_T_11; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_5 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_5 <= _GEN_334 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enCol) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_5) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_5 <= max_5 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_5 <= _cnt_T_11 == max_5; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_5 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_5 <= 6'h7; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_5 <= 6'h7; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else begin
        max_5 <= _GEN_332;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_6 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_6 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enRow) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_6) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_6 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_6 <= _cnt_T_13; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_6 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_6 <= _GEN_334 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enRow) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_6) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_6 <= max_6 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_6 <= _cnt_T_13 == max_6; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_6 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_6 <= 6'h7; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_6 <= 6'h7; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else begin
        max_6 <= _GEN_332;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 60:21]
      cnt_7 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 60:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      cnt_7 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:55]
    end else if (enCo) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_7) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        cnt_7 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:22]
      end else begin
        cnt_7 <= _cnt_T_15; // @[home/void-dreamers/commit_folder/test.scala 66:24]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 61:21]
      last_7 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 61:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      last_7 <= _GEN_340 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 63:68]
    end else if (enCo) begin // @[home/void-dreamers/commit_folder/test.scala 64:39]
      if (last_7) begin // @[home/void-dreamers/commit_folder/test.scala 65:16]
        last_7 <= max_7 == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 65:35]
      end else begin
        last_7 <= _cnt_T_15 == max_7; // @[home/void-dreamers/commit_folder/test.scala 66:43]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 62:21]
      max_7 <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 62:21]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      if (3'h5 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_7 <= 6'h1c; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else if (3'h4 == layer) begin // @[home/void-dreamers/commit_folder/test.scala 63:40]
        max_7 <= 6'h1c; // @[home/void-dreamers/commit_folder/test.scala 63:40]
      end else begin
        max_7 <= _GEN_338;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 154:24]
      k <= 9'h0; // @[home/void-dreamers/commit_folder/test.scala 154:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      k <= 9'h0; // @[home/void-dreamers/commit_folder/test.scala 353:11]
    end else if (run) begin // @[home/void-dreamers/commit_folder/test.scala 172:13]
      if (lastTap) begin // @[home/void-dreamers/commit_folder/test.scala 172:23]
        k <= 9'h0;
      end else begin
        k <= _k_T_1;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 155:24]
      wCoBase <= 15'h0; // @[home/void-dreamers/commit_folder/test.scala 155:24]
    end else if (ready & io_start) begin // @[home/void-dreamers/commit_folder/test.scala 333:27]
      wCoBase <= 15'h0; // @[home/void-dreamers/commit_folder/test.scala 336:13]
    end else if (enCo) begin // @[home/void-dreamers/commit_folder/test.scala 173:14]
      wCoBase <= _wCoBase_T_1; // @[home/void-dreamers/commit_folder/test.scala 174:13]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 156:24]
      bnPtr <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 156:24]
    end else if (ready & io_start) begin // @[home/void-dreamers/commit_folder/test.scala 333:27]
      bnPtr <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 337:13]
    end else if (enCo) begin // @[home/void-dreamers/commit_folder/test.scala 173:14]
      bnPtr <= _bnPtr_T_1; // @[home/void-dreamers/commit_folder/test.scala 175:13]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 157:24]
      wrPtr <= 13'h0; // @[home/void-dreamers/commit_folder/test.scala 157:24]
    end else if (state == 3'h1) begin // @[home/void-dreamers/commit_folder/test.scala 341:26]
      wrPtr <= 13'h0; // @[home/void-dreamers/commit_folder/test.scala 354:11]
    end else if (wrEn15) begin // @[home/void-dreamers/commit_folder/test.scala 317:16]
      wrPtr <= _wrPtr_T_1; // @[home/void-dreamers/commit_folder/test.scala 317:24]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c1_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c1_v <= run; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c1_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c1_first <= firstTap; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c1_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c1_last <= lastTap; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c1_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c1_firstPool <= c0_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c1_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c1_lastPool <= c0_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c1_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c1_bn <= bnPtr; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    iy1 <= $signed(_iy0_T_6) - 8'sh1; // @[home/void-dreamers/commit_folder/test.scala 207:31]
    ix1 <= $signed(_ix0_T_6) - 8'sh1; // @[home/void-dreamers/commit_folder/test.scala 208:31]
    ci1 <= cnt_2; // @[home/void-dreamers/commit_folder/test.scala 214:22]
    wIdx1 <= wCoBase + _GEN_512; // @[home/void-dreamers/commit_folder/test.scala 215:31]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c2_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c2_v <= c1_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c2_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c2_first <= c1_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c2_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c2_last <= c1_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c2_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c2_firstPool <= c1_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c2_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c2_lastPool <= c1_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c2_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c2_bn <= c1_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    pad2 <= $signed(iy1) < 8'sh0 | $signed(iy1) >= $signed(_pad1_T_2) | $signed(ix1) < 8'sh0 | $signed(ix1) >= $signed(
      _pad1_T_2); // @[home/void-dreamers/commit_folder/test.scala 220:57]
    ciSh2 <= _ciSh2_T[12:0]; // @[home/void-dreamers/commit_folder/test.scala 222:40]
    iySh2 <= _iySh2_T_1[12:0]; // @[home/void-dreamers/commit_folder/test.scala 223:46]
    ix2 <= {{5'd0}, _ix2_T}; // @[home/void-dreamers/commit_folder/test.scala 224:38]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c3_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c3_v <= c2_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c3_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c3_first <= c2_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c3_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c3_last <= c2_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c3_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c3_firstPool <= c2_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c3_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c3_lastPool <= c2_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c3_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c3_bn <= c2_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    pad3 <= pad2; // @[home/void-dreamers/commit_folder/test.scala 228:23]
    part3 <= ciSh2 + iySh2; // @[home/void-dreamers/commit_folder/test.scala 229:30]
    ix3 <= ix2; // @[home/void-dreamers/commit_folder/test.scala 230:23]
    wcode3 <= wRom_wcode2_data; // @[home/void-dreamers/commit_folder/test.scala 231:23]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c4_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c4_v <= c3_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c4_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c4_first <= c3_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c4_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c4_last <= c3_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c4_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c4_firstPool <= c3_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c4_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c4_lastPool <= c3_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c4_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c4_bn <= c3_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    pad4 <= pad3; // @[home/void-dreamers/commit_folder/test.scala 235:23]
    addr4 <= part3 + ix3; // @[home/void-dreamers/commit_folder/test.scala 236:30]
    wcode4 <= wcode3; // @[home/void-dreamers/commit_folder/test.scala 237:23]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 242:25]
      gapIdx <= 11'h0; // @[home/void-dreamers/commit_folder/test.scala 242:25]
    end else if (inGap) begin // @[home/void-dreamers/commit_folder/test.scala 373:15]
      if (gapIdx == 11'h73f) begin // @[home/void-dreamers/commit_folder/test.scala 375:50]
        gapIdx <= 11'h0; // @[home/void-dreamers/commit_folder/test.scala 376:14]
      end else begin
        gapIdx <= _gapIdx_T_1; // @[home/void-dreamers/commit_folder/test.scala 374:12]
      end
    end else if (state == 3'h3 & ~pipeBusy) begin // @[home/void-dreamers/commit_folder/test.scala 358:41]
      if (layer == 3'h4) begin // @[home/void-dreamers/commit_folder/test.scala 359:37]
        gapIdx <= 11'h0; // @[home/void-dreamers/commit_folder/test.scala 361:14]
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c5_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c5_v <= c4_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c5_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c5_first <= c4_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c5_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c5_last <= c4_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c5_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c5_firstPool <= c4_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c5_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c5_lastPool <= c4_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c5_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c5_bn <= c4_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    pad5 <= pad4; // @[home/void-dreamers/commit_folder/test.scala 253:23]
    wcode5 <= wcode4; // @[home/void-dreamers/commit_folder/test.scala 254:23]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c6_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c6_v <= c5_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c6_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c6_first <= c5_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c6_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c6_last <= c5_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c6_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c6_firstPool <= c5_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c6_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c6_lastPool <= c5_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c6_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c6_bn <= c5_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (pad5) begin // @[home/void-dreamers/commit_folder/test.scala 259:27]
      pixel6 <= 6'h0;
    end else if (sel) begin // @[home/void-dreamers/commit_folder/test.scala 255:19]
      pixel6 <= actB_rdB_data;
    end else begin
      pixel6 <= actA_rdA_data;
    end
    sh6 <= 3'h7 - wcode5[2:0]; // @[home/void-dreamers/commit_folder/test.scala 260:33]
    zero6 <= wcode5[2:0] == 3'h0; // @[home/void-dreamers/commit_folder/test.scala 261:37]
    sg6 <= wcode5[3]; // @[home/void-dreamers/commit_folder/test.scala 262:30]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c7_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c7_v <= c6_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c7_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c7_first <= c6_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c7_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c7_last <= c6_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c7_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c7_firstPool <= c6_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c7_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c7_lastPool <= c6_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c7_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c7_bn <= c6_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (zero6) begin // @[home/void-dreamers/commit_folder/test.scala 266:25]
      mag7 <= 13'h0;
    end else begin
      mag7 <= _mag7_T;
    end
    sg7 <= sg6; // @[home/void-dreamers/commit_folder/test.scala 267:21]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c8_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c8_v <= c7_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c8_first <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c8_first <= c7_first; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c8_last <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c8_last <= c7_last; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c8_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c8_firstPool <= c7_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c8_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c8_lastPool <= c7_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c8_bn <= 7'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c8_bn <= c7_bn; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (sg7) begin // @[home/void-dreamers/commit_folder/test.scala 272:27]
      term8 <= _term8_T_2;
    end else begin
      term8 <= magS7;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 275:24]
      acc <= 24'sh0; // @[home/void-dreamers/commit_folder/test.scala 275:24]
    end else if (c8_v) begin // @[home/void-dreamers/commit_folder/test.scala 277:14]
      acc <= accNext; // @[home/void-dreamers/commit_folder/test.scala 277:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c9_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c9_v <= c9w_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c9_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c9_firstPool <= c8_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c9_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c9_lastPool <= c8_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    acc9 <= $signed(_accNext_T) + $signed(_GEN_513); // @[home/void-dreamers/commit_folder/test.scala 276:41]
    if (7'h6a == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 284:21]
      m9 <= 16'sh3ad9; // @[home/void-dreamers/commit_folder/test.scala 284:21]
    end else if (7'h69 == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 284:21]
      m9 <= 16'sh4403; // @[home/void-dreamers/commit_folder/test.scala 284:21]
    end else if (7'h68 == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 284:21]
      m9 <= 16'sh4af1; // @[home/void-dreamers/commit_folder/test.scala 284:21]
    end else if (7'h67 == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 284:21]
      m9 <= 16'sh3bef; // @[home/void-dreamers/commit_folder/test.scala 284:21]
    end else begin
      m9 <= _GEN_152;
    end
    if (7'h6a == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 285:21]
      bq9 <= -30'sh6f38eec; // @[home/void-dreamers/commit_folder/test.scala 285:21]
    end else if (7'h69 == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 285:21]
      bq9 <= -30'sh36687a3; // @[home/void-dreamers/commit_folder/test.scala 285:21]
    end else if (7'h68 == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 285:21]
      bq9 <= -30'sh9c1fde; // @[home/void-dreamers/commit_folder/test.scala 285:21]
    end else if (7'h67 == c8_bn) begin // @[home/void-dreamers/commit_folder/test.scala 285:21]
      bq9 <= 30'sh524af6c; // @[home/void-dreamers/commit_folder/test.scala 285:21]
    end else begin
      bq9 <= _GEN_259;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c10_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c10_v <= c9_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c10_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c10_firstPool <= c9_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c10_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c10_lastPool <= c9_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    prodA10 <= $signed(acc9) * $signed(m9); // @[home/void-dreamers/commit_folder/test.scala 289:30]
    bq10 <= bq9; // @[home/void-dreamers/commit_folder/test.scala 290:24]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c11_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c11_v <= c10_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c11_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c11_firstPool <= c10_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c11_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c11_lastPool <= c10_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    prodB11 <= prodA10; // @[home/void-dreamers/commit_folder/test.scala 292:24]
    bq11 <= bq10; // @[home/void-dreamers/commit_folder/test.scala 293:24]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c12_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c12_v <= c11_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c12_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c12_firstPool <= c11_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c12_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c12_lastPool <= c11_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    sum12 <= $signed(prodB11) + $signed(_GEN_514); // @[home/void-dreamers/commit_folder/test.scala 297:31]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c13_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c13_v <= c12_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c13_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c13_firstPool <= c12_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c13_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c13_lastPool <= c12_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    shifted13 <= $signed(sum12) >>> shR; // @[home/void-dreamers/commit_folder/test.scala 301:33]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c14_v <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c14_v <= c13_v; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c14_firstPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c14_firstPool <= c13_firstPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 190:20]
      c14_lastPool <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end else begin
      c14_lastPool <= c13_lastPool; // @[home/void-dreamers/commit_folder/test.scala 190:20]
    end
    if ($signed(shifted13) < 41'sh0) begin // @[home/void-dreamers/commit_folder/test.scala 306:8]
      q14 <= 6'h0;
    end else if ($signed(shifted13) > 41'sh3f) begin // @[home/void-dreamers/commit_folder/test.scala 306:39]
      q14 <= 6'h3f;
    end else begin
      q14 <= shifted13[5:0];
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 310:24]
      poolMax <= 6'h0; // @[home/void-dreamers/commit_folder/test.scala 310:24]
    end else if (c14_v) begin // @[home/void-dreamers/commit_folder/test.scala 312:15]
      if (c14_firstPool | q14 > poolMax) begin // @[home/void-dreamers/commit_folder/test.scala 311:20]
        poolMax <= q14;
      end
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 313:25]
      wrEn15 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 313:25]
    end else begin
      wrEn15 <= c14_v & c14_lastPool; // @[home/void-dreamers/commit_folder/test.scala 313:25]
    end
    if (c14_firstPool | q14 > poolMax) begin // @[home/void-dreamers/commit_folder/test.scala 311:20]
      wrData15 <= q14;
    end else begin
      wrData15 <= poolMax;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 320:23]
      ldEn <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 320:23]
    end else begin
      ldEn <= io_loadEn & ready; // @[home/void-dreamers/commit_folder/test.scala 320:23]
    end
    ldAddr <= io_loadAddr; // @[home/void-dreamers/commit_folder/test.scala 321:23]
    ldData <= io_loadData; // @[home/void-dreamers/commit_folder/test.scala 322:23]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 370:22]
      accFc_0 <= 32'sh0; // @[home/void-dreamers/commit_folder/test.scala 370:22]
    end else if (gv5) begin // @[home/void-dreamers/commit_folder/test.scala 417:15]
      accFc_0 <= _accFc_0_T_2; // @[home/void-dreamers/commit_folder/test.scala 417:27]
    end else if (_T_5) begin // @[home/void-dreamers/commit_folder/test.scala 371:27]
      accFc_0 <= 32'sh0; // @[home/void-dreamers/commit_folder/test.scala 371:45]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 370:22]
      accFc_1 <= 32'sh0; // @[home/void-dreamers/commit_folder/test.scala 370:22]
    end else if (gv5) begin // @[home/void-dreamers/commit_folder/test.scala 417:15]
      accFc_1 <= _accFc_1_T_2; // @[home/void-dreamers/commit_folder/test.scala 417:27]
    end else if (_T_5) begin // @[home/void-dreamers/commit_folder/test.scala 371:27]
      accFc_1 <= 32'sh0; // @[home/void-dreamers/commit_folder/test.scala 371:45]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 382:24]
      gv1 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 382:24]
    end else begin
      gv1 <= inGap; // @[home/void-dreamers/commit_folder/test.scala 382:24]
    end
    gFirst1 <= gapIdx[5:0] == 6'h0; // @[home/void-dreamers/commit_folder/test.scala 383:49]
    gLast1 <= &gapIdx[5:0]; // @[home/void-dreamers/commit_folder/test.scala 384:49]
    gCh1 <= gapIdx[10:6]; // @[home/void-dreamers/commit_folder/test.scala 385:32]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 389:24]
      gv2 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 389:24]
    end else begin
      gv2 <= gv1; // @[home/void-dreamers/commit_folder/test.scala 389:24]
    end
    gFirst2 <= gFirst1; // @[home/void-dreamers/commit_folder/test.scala 390:24]
    gLast2 <= gLast1; // @[home/void-dreamers/commit_folder/test.scala 391:24]
    gCh2 <= gCh1; // @[home/void-dreamers/commit_folder/test.scala 392:24]
    gData2 <= actB_rdB_data; // @[home/void-dreamers/commit_folder/test.scala 393:24]
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 394:24]
      sAcc <= 16'h0; // @[home/void-dreamers/commit_folder/test.scala 394:24]
    end else if (gv2) begin // @[home/void-dreamers/commit_folder/test.scala 396:13]
      sAcc <= sNext; // @[home/void-dreamers/commit_folder/test.scala 396:20]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 399:23]
      gv3 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 399:23]
    end else begin
      gv3 <= gv2 & gLast2; // @[home/void-dreamers/commit_folder/test.scala 399:23]
    end
    sFin3 <= _sNext_T + _GEN_517; // @[home/void-dreamers/commit_folder/test.scala 395:41]
    gCh3 <= gCh2; // @[home/void-dreamers/commit_folder/test.scala 402:21]
    if (6'h39 == _code3_T) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_0 <= 4'h1; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else if (6'h38 == _code3_T) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_0 <= 4'h1; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else if (6'h37 == _code3_T) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_0 <= 4'h9; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else if (6'h36 == _code3_T) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_0 <= 4'ha; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else begin
      code3_0 <= _GEN_442;
    end
    if (6'h39 == _code3_T_3) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_1 <= 4'h1; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else if (6'h38 == _code3_T_3) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_1 <= 4'h1; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else if (6'h37 == _code3_T_3) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_1 <= 4'h9; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else if (6'h36 == _code3_T_3) begin // @[home/void-dreamers/commit_folder/test.scala 406:44]
      code3_1 <= 4'ha; // @[home/void-dreamers/commit_folder/test.scala 406:44]
    end else begin
      code3_1 <= _GEN_500;
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 409:21]
      gv4 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 409:21]
    end else begin
      gv4 <= gv3; // @[home/void-dreamers/commit_folder/test.scala 409:21]
    end
    if (reset) begin // @[home/void-dreamers/commit_folder/test.scala 410:21]
      gv5 <= 1'h0; // @[home/void-dreamers/commit_folder/test.scala 410:21]
    end else begin
      gv5 <= gv4; // @[home/void-dreamers/commit_folder/test.scala 410:21]
    end
    if (e3 == 3'h0) begin // @[home/void-dreamers/commit_folder/test.scala 413:27]
      mag4 <= 20'h0;
    end else begin
      mag4 <= _mag4_T_3[19:0];
    end
    sg4 <= code3_0[3]; // @[home/void-dreamers/commit_folder/test.scala 414:33]
    if (sg4) begin // @[home/void-dreamers/commit_folder/test.scala 416:28]
      term5 <= _term5_T_2;
    end else begin
      term5 <= m4S;
    end
    if (e3_1 == 3'h0) begin // @[home/void-dreamers/commit_folder/test.scala 413:27]
      mag4_1 <= 20'h0;
    end else begin
      mag4_1 <= _mag4_T_9[19:0];
    end
    sg4_1 <= code3_1[3]; // @[home/void-dreamers/commit_folder/test.scala 414:33]
    if (sg4_1) begin // @[home/void-dreamers/commit_folder/test.scala 416:28]
      term5_1 <= _term5_T_6;
    end else begin
      term5_1 <= m4S_1;
    end
    dR <= $signed(accFc_1) - $signed(accFc_0); // @[home/void-dreamers/commit_folder/test.scala 425:32]
    predR <= $signed(dR) > 32'sha80; // @[home/void-dreamers/commit_folder/test.scala 426:26]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (gv3 & ~reset) begin
          $fwrite(32'h80000002,"S[%d]=%d\n",gCh3,sFin3); // @[home/void-dreamers/commit_folder/test.scala 403:21]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (state == 3'h6 & _T_13) begin
          $fwrite(32'h80000002,"acc0=%d acc1=%d\n",accFc_0,accFc_1); // @[home/void-dreamers/commit_folder/test.scala 404:34]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
  integer initvar;
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_0 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    actA[initvar] = _RAND_3[5:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    actB[initvar] = _RAND_6[5:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  wRom_wcode2_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  wRom_wcode2_addr_pipe_0 = _RAND_2[14:0];
  _RAND_4 = {1{`RANDOM}};
  actA_rdA_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  actA_rdA_addr_pipe_0 = _RAND_5[12:0];
  _RAND_7 = {1{`RANDOM}};
  actB_rdB_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  actB_rdB_addr_pipe_0 = _RAND_8[12:0];
  _RAND_9 = {1{`RANDOM}};
  poolR = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  hinR = _RAND_10[6:0];
  _RAND_11 = {1{`RANDOM}};
  lgHinR = _RAND_11[2:0];
  _RAND_12 = {1{`RANDOM}};
  lgHinwR = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  shR = _RAND_13[4:0];
  _RAND_14 = {1{`RANDOM}};
  cin9R = _RAND_14[8:0];
  _RAND_15 = {1{`RANDOM}};
  state = _RAND_15[2:0];
  _RAND_16 = {1{`RANDOM}};
  layer = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  sel = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  cnt = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  last = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  max = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  cnt_1 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  last_1 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  max_1 = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  cnt_2 = _RAND_24[5:0];
  _RAND_25 = {1{`RANDOM}};
  last_2 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  max_2 = _RAND_26[5:0];
  _RAND_27 = {1{`RANDOM}};
  cnt_3 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  last_3 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  max_3 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  cnt_4 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  last_4 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  max_4 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  cnt_5 = _RAND_33[5:0];
  _RAND_34 = {1{`RANDOM}};
  last_5 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  max_5 = _RAND_35[5:0];
  _RAND_36 = {1{`RANDOM}};
  cnt_6 = _RAND_36[5:0];
  _RAND_37 = {1{`RANDOM}};
  last_6 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  max_6 = _RAND_38[5:0];
  _RAND_39 = {1{`RANDOM}};
  cnt_7 = _RAND_39[5:0];
  _RAND_40 = {1{`RANDOM}};
  last_7 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  max_7 = _RAND_41[5:0];
  _RAND_42 = {1{`RANDOM}};
  k = _RAND_42[8:0];
  _RAND_43 = {1{`RANDOM}};
  wCoBase = _RAND_43[14:0];
  _RAND_44 = {1{`RANDOM}};
  bnPtr = _RAND_44[6:0];
  _RAND_45 = {1{`RANDOM}};
  wrPtr = _RAND_45[12:0];
  _RAND_46 = {1{`RANDOM}};
  c1_v = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  c1_first = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  c1_last = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  c1_firstPool = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  c1_lastPool = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  c1_bn = _RAND_51[6:0];
  _RAND_52 = {1{`RANDOM}};
  iy1 = _RAND_52[7:0];
  _RAND_53 = {1{`RANDOM}};
  ix1 = _RAND_53[7:0];
  _RAND_54 = {1{`RANDOM}};
  ci1 = _RAND_54[5:0];
  _RAND_55 = {1{`RANDOM}};
  wIdx1 = _RAND_55[14:0];
  _RAND_56 = {1{`RANDOM}};
  c2_v = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  c2_first = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  c2_last = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  c2_firstPool = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  c2_lastPool = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  c2_bn = _RAND_61[6:0];
  _RAND_62 = {1{`RANDOM}};
  pad2 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  ciSh2 = _RAND_63[12:0];
  _RAND_64 = {1{`RANDOM}};
  iySh2 = _RAND_64[12:0];
  _RAND_65 = {1{`RANDOM}};
  ix2 = _RAND_65[12:0];
  _RAND_66 = {1{`RANDOM}};
  c3_v = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  c3_first = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  c3_last = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  c3_firstPool = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  c3_lastPool = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  c3_bn = _RAND_71[6:0];
  _RAND_72 = {1{`RANDOM}};
  pad3 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  part3 = _RAND_73[12:0];
  _RAND_74 = {1{`RANDOM}};
  ix3 = _RAND_74[12:0];
  _RAND_75 = {1{`RANDOM}};
  wcode3 = _RAND_75[3:0];
  _RAND_76 = {1{`RANDOM}};
  c4_v = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  c4_first = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  c4_last = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  c4_firstPool = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  c4_lastPool = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  c4_bn = _RAND_81[6:0];
  _RAND_82 = {1{`RANDOM}};
  pad4 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  addr4 = _RAND_83[12:0];
  _RAND_84 = {1{`RANDOM}};
  wcode4 = _RAND_84[3:0];
  _RAND_85 = {1{`RANDOM}};
  gapIdx = _RAND_85[10:0];
  _RAND_86 = {1{`RANDOM}};
  c5_v = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  c5_first = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  c5_last = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  c5_firstPool = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  c5_lastPool = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  c5_bn = _RAND_91[6:0];
  _RAND_92 = {1{`RANDOM}};
  pad5 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  wcode5 = _RAND_93[3:0];
  _RAND_94 = {1{`RANDOM}};
  c6_v = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  c6_first = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  c6_last = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  c6_firstPool = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  c6_lastPool = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  c6_bn = _RAND_99[6:0];
  _RAND_100 = {1{`RANDOM}};
  pixel6 = _RAND_100[5:0];
  _RAND_101 = {1{`RANDOM}};
  sh6 = _RAND_101[2:0];
  _RAND_102 = {1{`RANDOM}};
  zero6 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  sg6 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  c7_v = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  c7_first = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  c7_last = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  c7_firstPool = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  c7_lastPool = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  c7_bn = _RAND_109[6:0];
  _RAND_110 = {1{`RANDOM}};
  mag7 = _RAND_110[12:0];
  _RAND_111 = {1{`RANDOM}};
  sg7 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  c8_v = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  c8_first = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  c8_last = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  c8_firstPool = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  c8_lastPool = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  c8_bn = _RAND_117[6:0];
  _RAND_118 = {1{`RANDOM}};
  term8 = _RAND_118[13:0];
  _RAND_119 = {1{`RANDOM}};
  acc = _RAND_119[23:0];
  _RAND_120 = {1{`RANDOM}};
  c9_v = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  c9_firstPool = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  c9_lastPool = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  acc9 = _RAND_123[23:0];
  _RAND_124 = {1{`RANDOM}};
  m9 = _RAND_124[15:0];
  _RAND_125 = {1{`RANDOM}};
  bq9 = _RAND_125[29:0];
  _RAND_126 = {1{`RANDOM}};
  c10_v = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  c10_firstPool = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  c10_lastPool = _RAND_128[0:0];
  _RAND_129 = {2{`RANDOM}};
  prodA10 = _RAND_129[39:0];
  _RAND_130 = {1{`RANDOM}};
  bq10 = _RAND_130[29:0];
  _RAND_131 = {1{`RANDOM}};
  c11_v = _RAND_131[0:0];
  _RAND_132 = {1{`RANDOM}};
  c11_firstPool = _RAND_132[0:0];
  _RAND_133 = {1{`RANDOM}};
  c11_lastPool = _RAND_133[0:0];
  _RAND_134 = {2{`RANDOM}};
  prodB11 = _RAND_134[39:0];
  _RAND_135 = {1{`RANDOM}};
  bq11 = _RAND_135[29:0];
  _RAND_136 = {1{`RANDOM}};
  c12_v = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  c12_firstPool = _RAND_137[0:0];
  _RAND_138 = {1{`RANDOM}};
  c12_lastPool = _RAND_138[0:0];
  _RAND_139 = {2{`RANDOM}};
  sum12 = _RAND_139[40:0];
  _RAND_140 = {1{`RANDOM}};
  c13_v = _RAND_140[0:0];
  _RAND_141 = {1{`RANDOM}};
  c13_firstPool = _RAND_141[0:0];
  _RAND_142 = {1{`RANDOM}};
  c13_lastPool = _RAND_142[0:0];
  _RAND_143 = {2{`RANDOM}};
  shifted13 = _RAND_143[40:0];
  _RAND_144 = {1{`RANDOM}};
  c14_v = _RAND_144[0:0];
  _RAND_145 = {1{`RANDOM}};
  c14_firstPool = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  c14_lastPool = _RAND_146[0:0];
  _RAND_147 = {1{`RANDOM}};
  q14 = _RAND_147[5:0];
  _RAND_148 = {1{`RANDOM}};
  poolMax = _RAND_148[5:0];
  _RAND_149 = {1{`RANDOM}};
  wrEn15 = _RAND_149[0:0];
  _RAND_150 = {1{`RANDOM}};
  wrData15 = _RAND_150[5:0];
  _RAND_151 = {1{`RANDOM}};
  ldEn = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  ldAddr = _RAND_152[11:0];
  _RAND_153 = {1{`RANDOM}};
  ldData = _RAND_153[3:0];
  _RAND_154 = {1{`RANDOM}};
  accFc_0 = _RAND_154[31:0];
  _RAND_155 = {1{`RANDOM}};
  accFc_1 = _RAND_155[31:0];
  _RAND_156 = {1{`RANDOM}};
  gv1 = _RAND_156[0:0];
  _RAND_157 = {1{`RANDOM}};
  gFirst1 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  gLast1 = _RAND_158[0:0];
  _RAND_159 = {1{`RANDOM}};
  gCh1 = _RAND_159[4:0];
  _RAND_160 = {1{`RANDOM}};
  gv2 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  gFirst2 = _RAND_161[0:0];
  _RAND_162 = {1{`RANDOM}};
  gLast2 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  gCh2 = _RAND_163[4:0];
  _RAND_164 = {1{`RANDOM}};
  gData2 = _RAND_164[5:0];
  _RAND_165 = {1{`RANDOM}};
  sAcc = _RAND_165[15:0];
  _RAND_166 = {1{`RANDOM}};
  gv3 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  sFin3 = _RAND_167[15:0];
  _RAND_168 = {1{`RANDOM}};
  gCh3 = _RAND_168[4:0];
  _RAND_169 = {1{`RANDOM}};
  code3_0 = _RAND_169[3:0];
  _RAND_170 = {1{`RANDOM}};
  code3_1 = _RAND_170[3:0];
  _RAND_171 = {1{`RANDOM}};
  gv4 = _RAND_171[0:0];
  _RAND_172 = {1{`RANDOM}};
  gv5 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  mag4 = _RAND_173[19:0];
  _RAND_174 = {1{`RANDOM}};
  sg4 = _RAND_174[0:0];
  _RAND_175 = {1{`RANDOM}};
  term5 = _RAND_175[20:0];
  _RAND_176 = {1{`RANDOM}};
  mag4_1 = _RAND_176[19:0];
  _RAND_177 = {1{`RANDOM}};
  sg4_1 = _RAND_177[0:0];
  _RAND_178 = {1{`RANDOM}};
  term5_1 = _RAND_178[20:0];
  _RAND_179 = {1{`RANDOM}};
  dR = _RAND_179[31:0];
  _RAND_180 = {1{`RANDOM}};
  predR = _RAND_180[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
  $readmemh("golden_out/w_all_merged.hex", wRom);
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
