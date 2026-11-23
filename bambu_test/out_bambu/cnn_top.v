// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 2024.10 - Revision c2ba6936ca2ed63137095fea0b630a1c66e20e63-main - Date 2026-11-22T17:40:46
// Bambu executed with: /tmp/.mount_bambuODihZk/usr/bin/bambu --top-fname=cnn_top -O2 --clock-period=20 cnn.c 
// 
// Send any bug to: panda-info@polimi.it
// ************************************************************************
// The following text holds for all the components tagged with PANDA_LGPLv3.
// They are all part of the BAMBU/PANDA IP LIBRARY.
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public
// License along with the PandA framework; see the files COPYING.LIB
// If not, see <http://www.gnu.org/licenses/>.
// ************************************************************************


`ifdef __ICARUS__
  `define _SIM_HAVE_CLOG2
`endif
`ifdef VERILATOR
  `define _SIM_HAVE_CLOG2
`endif
`ifdef MODEL_TECH
  `define _SIM_HAVE_CLOG2
`endif
`ifdef VCS
  `define _SIM_HAVE_CLOG2
`endif
`ifdef NCVERILOG
  `define _SIM_HAVE_CLOG2
`endif
`ifdef XILINX_SIMULATOR
  `define _SIM_HAVE_CLOG2
`endif
`ifdef XILINX_ISIM
  `define _SIM_HAVE_CLOG2
`endif

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module constant_value(out1);
  parameter BITSIZE_out1=1,
    value=1'b0;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = value;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module register_SE(clock,
  reset,
  in1,
  wenable,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input wenable;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  
  reg [BITSIZE_out1-1:0] reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock)
    if (wenable)
      reg_out1 <= in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module register_STD(clock,
  reset,
  in1,
  wenable,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input wenable;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  reg [BITSIZE_out1-1:0] reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock)
    reg_out1 <= in1;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2020-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module STD_SP_BRAM(clock,
  write_enable,
  data_in,
  address_inr,
  address_inw,
  data_out);
  parameter BITSIZE_data_in=1,
    BITSIZE_address_inr=1,
    BITSIZE_address_inw=1,
    BITSIZE_data_out=1,
    MEMORY_INIT_file="array_a.mem",
    n_elements=32,
    READ_ONLY_MEMORY=0,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input write_enable;
  input [BITSIZE_data_in-1:0] data_in;
  input [BITSIZE_address_inr-1:0] address_inr;
  input [BITSIZE_address_inw-1:0] address_inw;
  // OUT
  output [BITSIZE_data_out-1:0] data_out;
  
  wire [BITSIZE_address_inr-1:0] address_inr_mem;
  reg [BITSIZE_address_inr-1:0] address_inr1;
  wire [BITSIZE_address_inw-1:0] address_inw_mem;
  reg [BITSIZE_address_inw-1:0] address_inw1;
  
  wire write_enable_mem;
  reg write_enable1;
  
  reg [BITSIZE_data_out-1:0] data_out_mem;
  reg [BITSIZE_data_out-1:0] data_out1;
  
  wire [BITSIZE_data_in-1:0] data_in_mem;
  reg [BITSIZE_data_in-1:0] data_in1;
  integer index;
  
  reg [BITSIZE_data_out-1:0] memory [0:n_elements-1]/* synthesis syn_ramstyle =  "no_rw_check" */;
  
  initial
  begin
    if (MEMORY_INIT_file != "")
      $readmemb(MEMORY_INIT_file, memory, 0, n_elements-1);
    else
    begin
      for(index=0; index<n_elements; index=index+1)
      begin
        memory[index] = 0;
      end
    end
  end
  
  always @(posedge clock)
  begin
    if(READ_ONLY_MEMORY==0)
    begin
      if (write_enable_mem)
        memory[address_inw_mem] <= data_in_mem;
    end
    data_out_mem <= memory[address_inr_mem];
  end
  
  assign data_out = HIGH_LATENCY==0 ? data_out_mem : data_out1;
  always @(posedge clock)
    data_out1 <= data_out_mem;
  
  
  generate
    if(HIGH_LATENCY==2)
    begin
      always @ (posedge clock)
      begin
         address_inr1 <= address_inr;
         address_inw1 <= address_inw;
         write_enable1 <= write_enable;
         data_in1 <= data_in;
      end
      assign address_inr_mem = address_inr1;
      assign address_inw_mem = address_inw1;
      assign write_enable_mem = write_enable1;
      assign data_in_mem = data_in1;
    end
    else
    begin
      assign address_inr_mem = address_inr;
      assign address_inw_mem = address_inw;
      assign write_enable_mem = write_enable;
      assign data_in_mem = data_in;
    end
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2020-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module STD_SP_BRAMFW(clock,
  write_enable,
  data_in,
  address_inr,
  address_inw,
  data_out);
  parameter BITSIZE_data_in=1,
    BITSIZE_address_inr=1,
    BITSIZE_address_inw=1,
    BITSIZE_data_out=1,
    MEMORY_INIT_file="array_a.mem",
    n_elements=32,
    READ_ONLY_MEMORY=0,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input write_enable;
  input [BITSIZE_data_in-1:0] data_in;
  input [BITSIZE_address_inr-1:0] address_inr;
  input [BITSIZE_address_inw-1:0] address_inw;
  // OUT
  output [BITSIZE_data_out-1:0] data_out;
  
  wire [BITSIZE_address_inr-1:0] address_inr_mem;
  reg [BITSIZE_address_inr-1:0] address_inr1;
  reg [BITSIZE_address_inr-1:0] address_inr_mem1;
  wire [BITSIZE_address_inw-1:0] address_inw_mem;
  reg [BITSIZE_address_inw-1:0] address_inw1;
  reg [BITSIZE_address_inw-1:0] address_inw_mem1;
  
  wire write_enable_mem;
  reg write_enable1;
  reg write_enable_mem1;
  
  reg [BITSIZE_data_out-1:0] data_out_mem_temp;
  reg [BITSIZE_data_out-1:0] data_out1;
  wire [BITSIZE_data_out-1:0] data_out_mem;
  
  wire [BITSIZE_data_in-1:0] data_in_mem;
  reg [BITSIZE_data_in-1:0] data_in1;
  reg [BITSIZE_data_in-1:0] data_in_mem1;
  
  integer index;
  
  reg [BITSIZE_data_out-1:0] memory [0:n_elements-1]/* synthesis syn_ramstyle =  "no_rw_check" */;
  
  initial
  begin
    if (MEMORY_INIT_file != "")
      $readmemb(MEMORY_INIT_file, memory, 0, n_elements-1);
    else
    begin
      for(index=0; index<n_elements; index=index+1)
      begin
        memory[index] = 0;
      end
    end
  end
  
  always @(posedge clock)
  begin
    if(READ_ONLY_MEMORY==0)
    begin
      if (write_enable_mem)
        memory[address_inw_mem] <= data_in_mem;
    end
    data_out_mem_temp <= memory[address_inr_mem];
  end
  
  assign data_out_mem = write_enable_mem1 && (address_inr_mem1 == address_inw_mem1) ? data_in_mem1 : data_out_mem_temp;
  
  assign data_out = HIGH_LATENCY==0 ? data_out_mem : data_out1;
  always @(posedge clock)
    data_out1 <= data_out_mem;
  
  always @ (posedge clock)
  begin
    address_inr_mem1 <= address_inr_mem;
    address_inw_mem1 <= address_inw_mem;
    write_enable_mem1 <= write_enable_mem;
    data_in_mem1 <= data_in_mem;
  end
  
  generate
    if(HIGH_LATENCY==2)
    begin
      always @ (posedge clock)
      begin
         address_inr1 <= address_inr;
         address_inw1 <= address_inw;
         write_enable1 <= write_enable;
         data_in1 <= data_in;
      end
      assign address_inr_mem = address_inr1;
      assign address_inw_mem = address_inw1;
      assign write_enable_mem = write_enable1;
      assign data_in_mem = data_in1;
    end
    else
    begin
      assign address_inr_mem = address_inr;
      assign address_inw_mem = address_inw;
      assign write_enable_mem = write_enable;
      assign data_in_mem = data_in;
    end
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2013-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module STD_NR_BRAM(clock,
  write_enable,
  address_inr,
  address_inw,
  data_in,
  data_out);
  parameter BITSIZE_address_inr=1, PORTSIZE_address_inr=2,
    BITSIZE_address_inw=1,
    BITSIZE_data_in=1,
    BITSIZE_data_out=1, PORTSIZE_data_out=2,
    MEMORY_INIT_file="array_a.mem",
    n_elements=32,
    forwarding=0,
    READ_ONLY_MEMORY=0,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input write_enable;
  input [(PORTSIZE_address_inr*BITSIZE_address_inr)+(-1):0] address_inr;
  input [BITSIZE_address_inw-1:0] address_inw;
  input [BITSIZE_data_in-1:0] data_in;
  // OUT
  output [(PORTSIZE_data_out*BITSIZE_data_out)+(-1):0] data_out;
  
  generate
  genvar i1;
    for (i1=0; i1<PORTSIZE_address_inr; i1=i1+1)
    begin : L1
      if(forwarding)
      begin
        STD_SP_BRAMFW #(
          .BITSIZE_address_inr(BITSIZE_address_inr),
          .BITSIZE_address_inw(BITSIZE_address_inw),
          .BITSIZE_data_in(BITSIZE_data_in),
          .BITSIZE_data_out(BITSIZE_data_out),
          .MEMORY_INIT_file(MEMORY_INIT_file),
          .n_elements(n_elements),
          .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
          .HIGH_LATENCY(HIGH_LATENCY)
          )
        STD_SP_BRAMFW_instance (
          .clock(clock),
          .write_enable(write_enable),
          .address_inr(address_inr[(i1+1)*BITSIZE_address_inr-1:i1*BITSIZE_address_inr]),
          .address_inw(address_inw),
          .data_in(data_in),
          .data_out(data_out[(i1+1)*BITSIZE_data_out-1:i1*BITSIZE_data_out]));
      end
      else
      begin
        STD_SP_BRAM #(
          .BITSIZE_address_inr(BITSIZE_address_inr),
          .BITSIZE_address_inw(BITSIZE_address_inw),
          .BITSIZE_data_in(BITSIZE_data_in),
          .BITSIZE_data_out(BITSIZE_data_out),
          .MEMORY_INIT_file(MEMORY_INIT_file),
          .n_elements(n_elements),
          .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
          .HIGH_LATENCY(HIGH_LATENCY)
          )
        STD_SP_BRAM_instance (
          .clock(clock),
          .write_enable(write_enable),
          .address_inr(address_inr[(i1+1)*BITSIZE_address_inr-1:i1*BITSIZE_address_inr]),
          .address_inw(address_inw),
          .data_in(data_in),
          .data_out(data_out[(i1+1)*BITSIZE_data_out-1:i1*BITSIZE_data_out]));
      end
    end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2023-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module STD_NRNW_BRAM_XOR(clock,
  write_enable,
  address_inr,
  address_inw,
  data_in,
  dout_value);
  parameter BITSIZE_write_enable=1, PORTSIZE_write_enable=2,
    BITSIZE_address_inr=1, PORTSIZE_address_inr=2,
    BITSIZE_address_inw=1, PORTSIZE_address_inw=2,
    BITSIZE_data_in=1, PORTSIZE_data_in=2,
    BITSIZE_dout_value=1, PORTSIZE_dout_value=2,
    MEMORY_INIT_file="array_a.mem",
    n_elements=32,
    READ_ONLY_MEMORY=0,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input [PORTSIZE_write_enable-1:0] write_enable;
  input [(PORTSIZE_address_inr*BITSIZE_address_inr)+(-1):0] address_inr;
  input [(PORTSIZE_address_inw*BITSIZE_address_inw)+(-1):0] address_inw;
  input [(PORTSIZE_data_in*BITSIZE_data_in)+(-1):0] data_in;
  // OUT
  output [(PORTSIZE_dout_value*BITSIZE_dout_value)+(-1):0] dout_value;
  
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    localparam nbit_write = PORTSIZE_address_inw == 1 ? 1 : $clog2(PORTSIZE_address_inw);
  `else
    localparam nbit_write = PORTSIZE_address_inw == 1 ? 1 : log2(PORTSIZE_address_inw);
  `endif
  
  reg [PORTSIZE_data_in*BITSIZE_data_in-1:0] WriteFeedBackData;
  wire [BITSIZE_dout_value*(PORTSIZE_address_inw*(PORTSIZE_address_inw-1))-1:0] ReadFeedBackData;
  reg [BITSIZE_address_inw*(PORTSIZE_address_inw*(PORTSIZE_address_inw-1))-1:0] ReadFeedBackAddr;
  reg [BITSIZE_dout_value*PORTSIZE_dout_value-1:0] ReadData;
  wire [BITSIZE_dout_value*PORTSIZE_dout_value*PORTSIZE_address_inw-1:0] ReadDataOut;
  
  wire [PORTSIZE_write_enable-1:0] write_enable_mem;
  wire [PORTSIZE_address_inw*BITSIZE_address_inw-1:0] address_inw_mem;
  wire [PORTSIZE_address_inr*BITSIZE_address_inr-1:0] address_inr_mem;
  wire [PORTSIZE_data_in*BITSIZE_data_in-1:0] data_in_mem;
  wire [PORTSIZE_dout_value*BITSIZE_dout_value-1:0] dout_value_mem;
  reg [PORTSIZE_dout_value*BITSIZE_dout_value-1:0] dout_value_mem1;
  
  reg [PORTSIZE_write_enable-1:0] write_enable_mem1;
  reg [PORTSIZE_address_inw*BITSIZE_address_inw-1:0] address_inw_mem1;
  reg [PORTSIZE_data_in*BITSIZE_data_in-1:0] data_in_mem1;
  
  reg [PORTSIZE_write_enable-1:0] write_enable1;
  reg [PORTSIZE_address_inw*BITSIZE_address_inw-1:0] address_inw1;
  reg [PORTSIZE_address_inr*BITSIZE_address_inr-1:0] address_inr1;
  reg [PORTSIZE_data_in*BITSIZE_data_in-1:0] data_in1;
  
  assign dout_value = HIGH_LATENCY==0 ? dout_value_mem : dout_value_mem1;
  always @(posedge clock)
    dout_value_mem1 <= dout_value_mem;
  
  
  generate
    if(HIGH_LATENCY==2)
    begin
      always @ (posedge clock)
      begin
         address_inr1 <= address_inr;
         address_inw1 <= address_inw;
         write_enable1 <= write_enable;
         data_in1 <= data_in;
      end
      assign address_inr_mem = address_inr1;
      assign address_inw_mem = address_inw1;
      assign write_enable_mem = write_enable1;
      assign data_in_mem = data_in1;
    end
    else
    begin
      assign address_inr_mem = address_inr;
      assign address_inw_mem = address_inw;
      assign write_enable_mem = write_enable;
      assign data_in_mem = data_in;
    end
  endgenerate
  
  always @(posedge clock)
  begin
    write_enable_mem1 <= write_enable_mem;
    address_inw_mem1 <= address_inw_mem;
    data_in_mem1 <= data_in_mem;
  end
  
  assign dout_value_mem = ReadData;
  
  generate
  genvar ii1;
    for (ii1=0; ii1<PORTSIZE_address_inw; ii1=ii1+1)
    begin : L1
      STD_NR_BRAM #(
        .PORTSIZE_address_inr(PORTSIZE_address_inw-1),
        .BITSIZE_address_inr(BITSIZE_address_inr),
        .BITSIZE_address_inw(BITSIZE_address_inw),
        .BITSIZE_data_in(BITSIZE_data_in),
        .BITSIZE_data_out(BITSIZE_dout_value),
        .PORTSIZE_data_out(PORTSIZE_address_inw-1),
        .MEMORY_INIT_file(ii1 == 0 ? MEMORY_INIT_file : ""),
        .n_elements(n_elements),
        .forwarding(1),
        .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
        .HIGH_LATENCY(0)
      )
      STD_NR_BRAM_FB_instance (
        .clock(clock),
        .write_enable(write_enable_mem1[ii1]),
        .address_inr(ReadFeedBackAddr[ii1*(BITSIZE_address_inw*(PORTSIZE_address_inw-1))+:(BITSIZE_address_inw*(PORTSIZE_address_inw-1))]),
        .address_inw(address_inw_mem1[ii1*BITSIZE_address_inw+:BITSIZE_address_inw]),
        .data_in(WriteFeedBackData[ii1*BITSIZE_data_in+:BITSIZE_data_in]),
        .data_out(ReadFeedBackData[ii1*BITSIZE_dout_value*(PORTSIZE_address_inw-1)+:BITSIZE_dout_value*(PORTSIZE_address_inw-1)]));
  
      STD_NR_BRAM #(
        .PORTSIZE_address_inr(PORTSIZE_address_inr),
        .BITSIZE_address_inr(BITSIZE_address_inr),
        .BITSIZE_address_inw(BITSIZE_address_inw),
        .BITSIZE_data_in(BITSIZE_data_in),
        .BITSIZE_data_out(BITSIZE_dout_value),
        .PORTSIZE_data_out(PORTSIZE_address_inr),
        .MEMORY_INIT_file(ii1 == 0 ? MEMORY_INIT_file : ""),
        .n_elements(n_elements),
        .forwarding(1),
        .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
        .HIGH_LATENCY(0)
      )
      STD_NR_BRAM_instance (
        .clock(clock),
        .write_enable(write_enable_mem1[ii1]),
        .address_inr(address_inr_mem),
        .address_inw(address_inw_mem1[ii1*BITSIZE_address_inw+:BITSIZE_address_inw]),
        .data_in(WriteFeedBackData[ii1*BITSIZE_data_in+:BITSIZE_data_in]),
        .data_out(ReadDataOut[ii1*BITSIZE_dout_value*(PORTSIZE_address_inr)+:BITSIZE_dout_value*(PORTSIZE_address_inr)]));
    end
  endgenerate
  integer i1,i2,i3;
  always @(*)
  begin
    for(i1=0;i1<PORTSIZE_address_inr;i1=i1+1)
    begin
      ReadData[i1*BITSIZE_dout_value+:BITSIZE_dout_value] = ReadDataOut[i1*BITSIZE_dout_value+:BITSIZE_dout_value];
      for(i2=1;i2<PORTSIZE_address_inw;i2=i2+1)
      begin
        ReadData[i1*BITSIZE_dout_value+:BITSIZE_dout_value] = ReadData[i1*BITSIZE_dout_value+:BITSIZE_dout_value]^ReadDataOut[(i2*PORTSIZE_address_inw+i1)*BITSIZE_dout_value+:BITSIZE_dout_value];
      end
    end
    for(i1=0;i1<PORTSIZE_address_inw;i1=i1+1)
      WriteFeedBackData[i1*BITSIZE_data_in+:BITSIZE_data_in] = data_in_mem1[i1*BITSIZE_data_in+:BITSIZE_data_in];
    for(i1=0;i1<PORTSIZE_address_inw;i1=i1+1)
    begin
      i3 = 0;
      for(i2=0;i2<PORTSIZE_address_inw-1;i2=i2+1)
      begin
        i3=i3+(i2==i1);
        ReadFeedBackAddr[(i1*(PORTSIZE_address_inw-1)+i2)*BITSIZE_address_inw+:BITSIZE_address_inw] = address_inw_mem[i3*BITSIZE_address_inw+:BITSIZE_address_inw];
        WriteFeedBackData[i3*BITSIZE_data_in+:BITSIZE_data_in] = WriteFeedBackData[i3*BITSIZE_data_in+:BITSIZE_data_in]^ReadFeedBackData[(i1*(PORTSIZE_address_inw-1)+i2)*BITSIZE_data_in+:BITSIZE_data_in];
        i3=i3+1;
      end
    end
  end

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2023-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module STD_DP_BRAM(clock,
  write_enable,
  data_in,
  address_in,
  data_out);
  parameter BITSIZE_write_enable=1, PORTSIZE_write_enable=2,
    BITSIZE_data_in=1, PORTSIZE_data_in=2,
    BITSIZE_address_in=1, PORTSIZE_address_in=2,
    BITSIZE_data_out=1, PORTSIZE_data_out=2,
    MEMORY_INIT_file="array_a.mem",
    n_elements=32,
    READ_ONLY_MEMORY=0,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input [PORTSIZE_write_enable-1:0] write_enable;
  input [(PORTSIZE_data_in*BITSIZE_data_in)+(-1):0] data_in;
  input [(PORTSIZE_address_in*BITSIZE_address_in)+(-1):0] address_in;
  // OUT
  output [(PORTSIZE_data_out*BITSIZE_data_out)+(-1):0] data_out;
  
  wire [2*BITSIZE_address_in-1:0] address_in_mem;
  reg [2*BITSIZE_address_in-1:0] address_in1;
  
  wire [1:0] write_enable_mem;
  reg [1:0] write_enable1;
  
  reg [2*BITSIZE_data_out-1:0] data_out_mem;
  reg [2*BITSIZE_data_out-1:0] data_out1;
  
  wire [2*BITSIZE_data_in-1:0] data_in_mem;
  reg [2*BITSIZE_data_in-1:0] data_in1;
  
  reg [BITSIZE_data_out-1:0] memory [0:n_elements-1] /* synthesis syn_ramstyle = "no_rw_check" */;
  
  initial
  begin
    if (MEMORY_INIT_file != "")
      $readmemb(MEMORY_INIT_file, memory, 0, n_elements-1);
  end
  
  assign data_out = HIGH_LATENCY==0 ? data_out_mem : data_out1;
  always @(posedge clock)
    data_out1 <= data_out_mem;
  
  generate
    if(HIGH_LATENCY==2)
    begin
      always @ (posedge clock)
      begin
         address_in1 <= address_in;
         write_enable1 <= write_enable;
         data_in1 <= data_in;
      end
      assign address_in_mem = address_in1;
      assign write_enable_mem = write_enable1;
      assign data_in_mem = data_in1;
    end
    else
    begin
      assign address_in_mem = address_in;
      assign write_enable_mem = write_enable;
      assign data_in_mem = data_in;
    end
  endgenerate
  
  
  always @(posedge clock)
  begin
    if(READ_ONLY_MEMORY==0)
    begin
      if(write_enable_mem[0])
        memory[address_in_mem[BITSIZE_address_in*0+:BITSIZE_address_in]] <= data_in_mem[BITSIZE_data_in*0+:BITSIZE_data_in];
    end
    data_out_mem[BITSIZE_data_out*0+:BITSIZE_data_out] <= memory[address_in_mem[BITSIZE_address_in*0+:BITSIZE_address_in]];
  end
  always @(posedge clock)
  begin
      if(READ_ONLY_MEMORY==0)
      begin
        if(write_enable_mem[1])
          memory[address_in_mem[BITSIZE_address_in*1+:BITSIZE_address_in]] <= data_in_mem[BITSIZE_data_in*1+:BITSIZE_data_in];
      end
      data_out_mem[BITSIZE_data_out*1+:BITSIZE_data_out] <= memory[address_in_mem[BITSIZE_address_in*1+:BITSIZE_address_in]];
  end

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2023-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module STD_NRNW_BRAM_GEN(clock,
  write_enable,
  address_inr,
  address_inw,
  data_in,
  dout_value);
  parameter BITSIZE_write_enable=1, PORTSIZE_write_enable=2,
    BITSIZE_address_inr=1, PORTSIZE_address_inr=2,
    BITSIZE_address_inw=1, PORTSIZE_address_inw=2,
    BITSIZE_data_in=1, PORTSIZE_data_in=2,
    BITSIZE_dout_value=1, PORTSIZE_dout_value=2,
    MEMORY_INIT_file="array_a.mem",
    n_elements=32,
    READ_ONLY_MEMORY=0,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input [PORTSIZE_write_enable-1:0] write_enable;
  input [(PORTSIZE_address_inr*BITSIZE_address_inr)+(-1):0] address_inr;
  input [(PORTSIZE_address_inw*BITSIZE_address_inw)+(-1):0] address_inw;
  input [(PORTSIZE_data_in*BITSIZE_data_in)+(-1):0] data_in;
  // OUT
  output [(PORTSIZE_dout_value*BITSIZE_dout_value)+(-1):0] dout_value;
  
  parameter nbit_addr = BITSIZE_address_inr > BITSIZE_address_inw ? BITSIZE_address_inr : BITSIZE_address_inw;
  wire [2*nbit_addr-1:0] address_in;
  generate
  if(PORTSIZE_address_inw == 1)
  begin
    STD_NR_BRAM #(
        .PORTSIZE_address_inr(PORTSIZE_address_inr),
        .BITSIZE_address_inr(BITSIZE_address_inr),
        .BITSIZE_address_inw(BITSIZE_address_inw),
        .BITSIZE_data_in(BITSIZE_data_in),
        .BITSIZE_data_out(BITSIZE_dout_value),
        .PORTSIZE_data_out(PORTSIZE_dout_value),
        .MEMORY_INIT_file(MEMORY_INIT_file),
        .n_elements(n_elements),
        .forwarding(0),
        .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
        .HIGH_LATENCY(HIGH_LATENCY)
      )
      STD_NR_BRAM_FB_instance (
        .clock(clock),
        .write_enable(write_enable[0]),
        .address_inr(address_inr),
        .address_inw(address_inw[0+:BITSIZE_address_inw]),
        .data_in(data_in[0+:BITSIZE_data_in]),
        .data_out(dout_value));
  end
  else if(PORTSIZE_address_inr == 2 && PORTSIZE_address_inw == 2)
  begin
    assign address_in[0+:nbit_addr] = write_enable[0] ? address_inw[0+:BITSIZE_address_inw] : address_inr[0+:BITSIZE_address_inr];
    assign address_in[nbit_addr+:nbit_addr] = write_enable[1] ? address_inw[BITSIZE_address_inw+:BITSIZE_address_inw] : address_inr[BITSIZE_address_inr+:BITSIZE_address_inr];
    STD_DP_BRAM #(
      .PORTSIZE_write_enable(PORTSIZE_write_enable),
      .BITSIZE_write_enable(1),
      .PORTSIZE_data_in(PORTSIZE_data_in),
      .BITSIZE_data_in(BITSIZE_data_in),
      .PORTSIZE_data_out(PORTSIZE_dout_value),
      .BITSIZE_data_out(BITSIZE_dout_value),
      .PORTSIZE_address_in(2),
      .BITSIZE_address_in(nbit_addr),
      .n_elements(n_elements),
      .MEMORY_INIT_file(MEMORY_INIT_file),
      .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
      .HIGH_LATENCY(HIGH_LATENCY)
    ) STD_DP_BRAM_instance (
      .clock(clock),
      .write_enable(write_enable),
      .data_in(data_in),
      .address_in(address_in),
      .data_out(dout_value)
    );
  end
  else
  begin
    STD_NRNW_BRAM_XOR #(
      .PORTSIZE_write_enable(PORTSIZE_write_enable),
      .BITSIZE_write_enable(BITSIZE_write_enable),
      .PORTSIZE_address_inr(PORTSIZE_address_inr),
      .BITSIZE_address_inr(BITSIZE_address_inr),
      .PORTSIZE_address_inw(PORTSIZE_address_inw),
      .BITSIZE_address_inw(BITSIZE_address_inw),
      .PORTSIZE_data_in(PORTSIZE_data_in),
      .BITSIZE_data_in(BITSIZE_data_in),
      .PORTSIZE_dout_value(PORTSIZE_dout_value),
      .BITSIZE_dout_value(BITSIZE_dout_value),
      .MEMORY_INIT_file(MEMORY_INIT_file),
      .n_elements(n_elements),
      .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
      .HIGH_LATENCY(HIGH_LATENCY)
    ) STD_NRNW_BRAM_inst (
      .clock(clock),
      .write_enable(write_enable),
      .data_in(data_in),
      .address_inr(address_inr),
      .address_inw(address_inw),
      .dout_value(dout_value)
    );
  end
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_BRAM_NN_SDS_BASE(clock,
  reset,
  in1,
  in2r,
  in2w,
  in3r,
  in3w,
  in4r,
  in4w,
  out1,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  Sout_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2r,
  proxy_in2w,
  proxy_in3r,
  proxy_in3w,
  proxy_in4r,
  proxy_in4w,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2r=1, PORTSIZE_in2r=2,
    BITSIZE_in2w=1, PORTSIZE_in2w=2,
    BITSIZE_in3r=1, PORTSIZE_in3r=2,
    BITSIZE_in3w=1, PORTSIZE_in3w=2,
    BITSIZE_in4r=1, PORTSIZE_in4r=2,
    BITSIZE_in4w=1, PORTSIZE_in4w=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_S_oe_ram=1, PORTSIZE_S_oe_ram=2,
    BITSIZE_S_we_ram=1, PORTSIZE_S_we_ram=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_S_addr_ram=1, PORTSIZE_S_addr_ram=2,
    BITSIZE_S_Wdata_ram=8, PORTSIZE_S_Wdata_ram=2,
    BITSIZE_Sin_Rdata_ram=8, PORTSIZE_Sin_Rdata_ram=2,
    BITSIZE_Sout_Rdata_ram=8, PORTSIZE_Sout_Rdata_ram=2,
    BITSIZE_S_data_ram_size=1, PORTSIZE_S_data_ram_size=2,
    BITSIZE_Sin_DataRdy=1, PORTSIZE_Sin_DataRdy=2,
    BITSIZE_Sout_DataRdy=1, PORTSIZE_Sout_DataRdy=2,
    MEMORY_INIT_file="array.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    PRIVATE_MEMORY=0,
    READ_ONLY_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    HIGH_LATENCY=0,
    ALIGNMENT=32,
    BITSIZE_proxy_in1=1, PORTSIZE_proxy_in1=2,
    BITSIZE_proxy_in2r=1, PORTSIZE_proxy_in2r=2,
    BITSIZE_proxy_in2w=1, PORTSIZE_proxy_in2w=2,
    BITSIZE_proxy_in3r=1, PORTSIZE_proxy_in3r=2,
    BITSIZE_proxy_in3w=1, PORTSIZE_proxy_in3w=2,
    BITSIZE_proxy_in4r=1, PORTSIZE_proxy_in4r=2,
    BITSIZE_proxy_in4w=1, PORTSIZE_proxy_in4w=2,
    BITSIZE_proxy_sel_LOAD=1, PORTSIZE_proxy_sel_LOAD=2,
    BITSIZE_proxy_sel_STORE=1, PORTSIZE_proxy_sel_STORE=2,
    BITSIZE_proxy_out1=1, PORTSIZE_proxy_out1=2;
  // IN
  input clock;
  input reset;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2r*BITSIZE_in2r)+(-1):0] in2r;
  input [(PORTSIZE_in2w*BITSIZE_in2w)+(-1):0] in2w;
  input [(PORTSIZE_in3r*BITSIZE_in3r)+(-1):0] in3r;
  input [(PORTSIZE_in3w*BITSIZE_in3w)+(-1):0] in3w;
  input [PORTSIZE_in4r-1:0] in4r;
  input [PORTSIZE_in4w-1:0] in4w;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [PORTSIZE_S_oe_ram-1:0] S_oe_ram;
  input [PORTSIZE_S_we_ram-1:0] S_we_ram;
  input [(PORTSIZE_S_addr_ram*BITSIZE_S_addr_ram)+(-1):0] S_addr_ram;
  input [(PORTSIZE_S_Wdata_ram*BITSIZE_S_Wdata_ram)+(-1):0] S_Wdata_ram;
  input [(PORTSIZE_Sin_Rdata_ram*BITSIZE_Sin_Rdata_ram)+(-1):0] Sin_Rdata_ram;
  input [(PORTSIZE_S_data_ram_size*BITSIZE_S_data_ram_size)+(-1):0] S_data_ram_size;
  input [PORTSIZE_Sin_DataRdy-1:0] Sin_DataRdy;
  input [(PORTSIZE_proxy_in1*BITSIZE_proxy_in1)+(-1):0] proxy_in1;
  input [(PORTSIZE_proxy_in2r*BITSIZE_proxy_in2r)+(-1):0] proxy_in2r;
  input [(PORTSIZE_proxy_in2w*BITSIZE_proxy_in2w)+(-1):0] proxy_in2w;
  input [(PORTSIZE_proxy_in3r*BITSIZE_proxy_in3r)+(-1):0] proxy_in3r;
  input [(PORTSIZE_proxy_in3w*BITSIZE_proxy_in3w)+(-1):0] proxy_in3w;
  input [(PORTSIZE_proxy_in4r*BITSIZE_proxy_in4r)+(-1):0] proxy_in4r;
  input [(PORTSIZE_proxy_in4w*BITSIZE_proxy_in4w)+(-1):0] proxy_in4w;
  input [PORTSIZE_proxy_sel_LOAD-1:0] proxy_sel_LOAD;
  input [PORTSIZE_proxy_sel_STORE-1:0] proxy_sel_STORE;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [(PORTSIZE_Sout_Rdata_ram*BITSIZE_Sout_Rdata_ram)+(-1):0] Sout_Rdata_ram;
  output [PORTSIZE_Sout_DataRdy-1:0] Sout_DataRdy;
  output [(PORTSIZE_proxy_out1*BITSIZE_proxy_out1)+(-1):0] proxy_out1;
  
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  parameter n_byte_on_databus = ALIGNMENT/8;
  parameter nbit_addr_r = BITSIZE_in2r > BITSIZE_proxy_in2r ? BITSIZE_in2r : BITSIZE_proxy_in2r;
  parameter nbit_addr_w = BITSIZE_in2w > BITSIZE_proxy_in2w ? BITSIZE_in2w : BITSIZE_proxy_in2w;
  `ifdef _SIM_HAVE_CLOG2
    localparam nbit_read_addr = n_elements == 1 ? 1 : $clog2(n_elements);
    localparam nbits_byte_offset = n_byte_on_databus<=1 ? 0 : $clog2(n_byte_on_databus);
  `else
    localparam nbit_read_addr = n_elements == 1 ? 1 : log2(n_elements);
    localparam nbits_byte_offset = n_byte_on_databus<=1 ? 0 : log2(n_byte_on_databus);
  `endif
  parameter max_n_writes = READ_ONLY_MEMORY ? 1 : PORTSIZE_sel_STORE;
  parameter max_n_reads = PORTSIZE_sel_LOAD;
  
  wire [nbit_read_addr*max_n_reads-1:0] memory_addr_a_r;
  wire [nbit_read_addr*max_n_writes-1:0] memory_addr_a_w;
  
  wire [max_n_writes-1:0] bram_write;
  
  wire [data_size*max_n_reads-1:0] dout_a;
  wire [nbit_addr_r*max_n_reads-1:0] relative_addr_r;
  wire [nbit_addr_w*max_n_writes-1:0] relative_addr_w;
  wire [nbit_addr_r*max_n_reads-1:0] tmp_addr_r;
  wire [nbit_addr_w*max_n_writes-1:0] tmp_addr_w;
  wire [data_size*max_n_writes-1:0] din_a;
  wire [data_size*max_n_writes-1:0] din_a_mem;
  reg [data_size*max_n_writes-1:0] din_a1;
  
  STD_NRNW_BRAM_GEN #(
    .PORTSIZE_write_enable(max_n_writes),
    .BITSIZE_write_enable(1),
    .PORTSIZE_data_in(max_n_writes),
    .BITSIZE_data_in(data_size),
    .PORTSIZE_dout_value(max_n_reads),
    .BITSIZE_dout_value(data_size),
    .PORTSIZE_address_inr(max_n_reads),
    .BITSIZE_address_inr(nbit_read_addr),
    .PORTSIZE_address_inw(max_n_writes),
    .BITSIZE_address_inw(nbit_read_addr),
    .n_elements(n_elements),
    .MEMORY_INIT_file(MEMORY_INIT_file),
    .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
    .HIGH_LATENCY(HIGH_LATENCY)
  ) STD_NRNW_BRAM_GEN_instance (
    .clock(clock),
    .write_enable(bram_write),
    .data_in(din_a),
    .address_inr(memory_addr_a_r),
    .address_inw(memory_addr_a_w),
    .dout_value(dout_a)
  );
  
  generate
  genvar i14;
    for (i14=0; i14<max_n_writes; i14=i14+1)
    begin : L14
      assign din_a[(i14+1)*data_size-1:i14*data_size] = (proxy_sel_STORE[i14] && proxy_in4w[i14]) ? proxy_in1[(i14+1)*BITSIZE_proxy_in1-1:i14*BITSIZE_proxy_in1] : in1[(i14+1)*BITSIZE_in1-1:i14*BITSIZE_in1];
    end
  endgenerate
  
  generate
  genvar i21;
    for (i21=0; i21<max_n_writes; i21=i21+1)
    begin : L21
        assign bram_write[i21] = (sel_STORE[i21] && in4w[i21]) || (proxy_sel_STORE[i21] && proxy_in4w[i21]);
    end
  endgenerate
  
  generate
  genvar ind2r;
  for (ind2r=0; ind2r<max_n_reads; ind2r=ind2r+1)
    begin : Lind2r
      assign tmp_addr_r[(ind2r+1)*nbit_addr_r-1:ind2r*nbit_addr_r] = (proxy_sel_LOAD[ind2r] && proxy_in4r[ind2r]) ? proxy_in2r[(ind2r+1)*BITSIZE_proxy_in2r-1:ind2r*BITSIZE_proxy_in2r] : in2r[(ind2r+1)*BITSIZE_in2r-1:ind2r*BITSIZE_in2r];
    end
  endgenerate
  
  generate
  genvar ind2w;
  for (ind2w=0; ind2w<max_n_writes; ind2w=ind2w+1)
    begin : Lind2w
      assign tmp_addr_w[(ind2w+1)*nbit_addr_w-1:ind2w*nbit_addr_w] = (proxy_sel_STORE[ind2w] && proxy_in4w[ind2w]) ? proxy_in2w[(ind2w+1)*BITSIZE_proxy_in2w-1:ind2w*BITSIZE_proxy_in2w] : in2w[(ind2w+1)*BITSIZE_in2w-1:ind2w*BITSIZE_in2w];
    end
  endgenerate
  
  generate
  genvar i6r;
    for (i6r=0; i6r<max_n_reads; i6r=i6r+1)
    begin : L6r
      if(USE_SPARSE_MEMORY==1)
        assign relative_addr_r[(i6r+1)*nbit_addr_r-1:i6r*nbit_addr_r] = tmp_addr_r[(i6r+1)*nbit_addr_r-1:i6r*nbit_addr_r];
      else
        assign relative_addr_r[(i6r+1)*nbit_addr_r-1:i6r*nbit_addr_r] = tmp_addr_r[(i6r+1)*nbit_addr_r-1:i6r*nbit_addr_r]-address_space_begin;
    end
  endgenerate
  
  generate
  genvar i6w;
    for (i6w=0; i6w<max_n_writes; i6w=i6w+1)
    begin : L6w
      if(USE_SPARSE_MEMORY==1)
        assign relative_addr_w[(i6w+1)*nbit_addr_w-1:i6w*nbit_addr_w] = tmp_addr_w[(i6w+1)*nbit_addr_w-1:i6w*nbit_addr_w];
      else
        assign relative_addr_w[(i6w+1)*nbit_addr_w-1:i6w*nbit_addr_w] = tmp_addr_w[(i6w+1)*nbit_addr_w-1:i6w*nbit_addr_w]-address_space_begin;
    end
  endgenerate
  
  generate
  genvar i7r;
    for (i7r=0; i7r<max_n_reads; i7r=i7r+1)
    begin : L7_Ar
      if (n_elements==1)
        assign memory_addr_a_r[(i7r+1)*nbit_read_addr-1:i7r*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_a_r[(i7r+1)*nbit_read_addr-1:i7r*nbit_read_addr] = relative_addr_r[nbit_read_addr+nbits_byte_offset-1+i7r*nbit_addr_r:nbits_byte_offset+i7r*nbit_addr_r];
    end
  endgenerate
  
  generate
  genvar i7w;
    for (i7w=0; i7w<max_n_writes; i7w=i7w+1)
    begin : L7_Aw
      if (n_elements==1)
        assign memory_addr_a_w[(i7w+1)*nbit_read_addr-1:i7w*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_a_w[(i7w+1)*nbit_read_addr-1:i7w*nbit_read_addr] = relative_addr_w[nbit_read_addr+nbits_byte_offset-1+i7w*nbit_addr_w:nbits_byte_offset+i7w*nbit_addr_w];
    end
  endgenerate
  
  assign out1 = dout_a;
  assign proxy_out1 = dout_a;
  assign Sout_Rdata_ram =Sin_Rdata_ram;
  assign Sout_DataRdy = Sin_DataRdy;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_BRAM_NN_SDS(clock,
  reset,
  in1,
  in2r,
  in2w,
  in3r,
  in3w,
  in4r,
  in4w,
  out1,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  Sout_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2r,
  proxy_in2w,
  proxy_in3r,
  proxy_in3w,
  proxy_in4r,
  proxy_in4w,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2r=1, PORTSIZE_in2r=2,
    BITSIZE_in2w=1, PORTSIZE_in2w=2,
    BITSIZE_in3r=1, PORTSIZE_in3r=2,
    BITSIZE_in3w=1, PORTSIZE_in3w=2,
    BITSIZE_in4r=1, PORTSIZE_in4r=2,
    BITSIZE_in4w=1, PORTSIZE_in4w=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_S_oe_ram=1, PORTSIZE_S_oe_ram=2,
    BITSIZE_S_we_ram=1, PORTSIZE_S_we_ram=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_S_addr_ram=1, PORTSIZE_S_addr_ram=2,
    BITSIZE_S_Wdata_ram=8, PORTSIZE_S_Wdata_ram=2,
    BITSIZE_Sin_Rdata_ram=8, PORTSIZE_Sin_Rdata_ram=2,
    BITSIZE_Sout_Rdata_ram=8, PORTSIZE_Sout_Rdata_ram=2,
    BITSIZE_S_data_ram_size=1, PORTSIZE_S_data_ram_size=2,
    BITSIZE_Sin_DataRdy=1, PORTSIZE_Sin_DataRdy=2,
    BITSIZE_Sout_DataRdy=1, PORTSIZE_Sout_DataRdy=2,
    MEMORY_INIT_file="array.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    PRIVATE_MEMORY=0,
    READ_ONLY_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    ALIGNMENT=32,
    BITSIZE_proxy_in1=1, PORTSIZE_proxy_in1=2,
    BITSIZE_proxy_in2r=1, PORTSIZE_proxy_in2r=2,
    BITSIZE_proxy_in2w=1, PORTSIZE_proxy_in2w=2,
    BITSIZE_proxy_in3r=1, PORTSIZE_proxy_in3r=2,
    BITSIZE_proxy_in3w=1, PORTSIZE_proxy_in3w=2,
    BITSIZE_proxy_in4r=1, PORTSIZE_proxy_in4r=2,
    BITSIZE_proxy_in4w=1, PORTSIZE_proxy_in4w=2,
    BITSIZE_proxy_sel_LOAD=1, PORTSIZE_proxy_sel_LOAD=2,
    BITSIZE_proxy_sel_STORE=1, PORTSIZE_proxy_sel_STORE=2,
    BITSIZE_proxy_out1=1, PORTSIZE_proxy_out1=2;
  // IN
  input clock;
  input reset;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2r*BITSIZE_in2r)+(-1):0] in2r;
  input [(PORTSIZE_in2w*BITSIZE_in2w)+(-1):0] in2w;
  input [(PORTSIZE_in3r*BITSIZE_in3r)+(-1):0] in3r;
  input [(PORTSIZE_in3w*BITSIZE_in3w)+(-1):0] in3w;
  input [PORTSIZE_in4r-1:0] in4r;
  input [PORTSIZE_in4w-1:0] in4w;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [PORTSIZE_S_oe_ram-1:0] S_oe_ram;
  input [PORTSIZE_S_we_ram-1:0] S_we_ram;
  input [(PORTSIZE_S_addr_ram*BITSIZE_S_addr_ram)+(-1):0] S_addr_ram;
  input [(PORTSIZE_S_Wdata_ram*BITSIZE_S_Wdata_ram)+(-1):0] S_Wdata_ram;
  input [(PORTSIZE_Sin_Rdata_ram*BITSIZE_Sin_Rdata_ram)+(-1):0] Sin_Rdata_ram;
  input [(PORTSIZE_S_data_ram_size*BITSIZE_S_data_ram_size)+(-1):0] S_data_ram_size;
  input [PORTSIZE_Sin_DataRdy-1:0] Sin_DataRdy;
  input [(PORTSIZE_proxy_in1*BITSIZE_proxy_in1)+(-1):0] proxy_in1;
  input [(PORTSIZE_proxy_in2r*BITSIZE_proxy_in2r)+(-1):0] proxy_in2r;
  input [(PORTSIZE_proxy_in2w*BITSIZE_proxy_in2w)+(-1):0] proxy_in2w;
  input [(PORTSIZE_proxy_in3r*BITSIZE_proxy_in3r)+(-1):0] proxy_in3r;
  input [(PORTSIZE_proxy_in3w*BITSIZE_proxy_in3w)+(-1):0] proxy_in3w;
  input [PORTSIZE_proxy_in4r-1:0] proxy_in4r;
  input [PORTSIZE_proxy_in4w-1:0] proxy_in4w;
  input [PORTSIZE_proxy_sel_LOAD-1:0] proxy_sel_LOAD;
  input [PORTSIZE_proxy_sel_STORE-1:0] proxy_sel_STORE;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [(PORTSIZE_Sout_Rdata_ram*BITSIZE_Sout_Rdata_ram)+(-1):0] Sout_Rdata_ram;
  output [PORTSIZE_Sout_DataRdy-1:0] Sout_DataRdy;
  output [(PORTSIZE_proxy_out1*BITSIZE_proxy_out1)+(-1):0] proxy_out1;
  
  ARRAY_1D_STD_BRAM_NN_SDS_BASE #(
    .BITSIZE_in1(BITSIZE_in1),
    .PORTSIZE_in1(PORTSIZE_in1),
    .BITSIZE_in2r(BITSIZE_in2r),
    .PORTSIZE_in2r(PORTSIZE_in2r),
    .BITSIZE_in2w(BITSIZE_in2w),
    .PORTSIZE_in2w(PORTSIZE_in2w),
    .BITSIZE_in3r(BITSIZE_in3r),
    .PORTSIZE_in3r(PORTSIZE_in3r),
    .BITSIZE_in3w(BITSIZE_in3w),
    .PORTSIZE_in3w(PORTSIZE_in3w),
    .BITSIZE_in4r(BITSIZE_in4r),
    .PORTSIZE_in4r(PORTSIZE_in4r),
    .BITSIZE_in4w(BITSIZE_in4w),
    .PORTSIZE_in4w(PORTSIZE_in4w),
    .BITSIZE_sel_LOAD(BITSIZE_sel_LOAD),
    .PORTSIZE_sel_LOAD(PORTSIZE_sel_LOAD),
    .BITSIZE_sel_STORE(BITSIZE_sel_STORE),
    .PORTSIZE_sel_STORE(PORTSIZE_sel_STORE),
    .BITSIZE_S_oe_ram(BITSIZE_S_oe_ram),
    .PORTSIZE_S_oe_ram(PORTSIZE_S_oe_ram),
    .BITSIZE_S_we_ram(BITSIZE_S_we_ram),
    .PORTSIZE_S_we_ram(PORTSIZE_S_we_ram),
    .BITSIZE_out1(BITSIZE_out1),
    .PORTSIZE_out1(PORTSIZE_out1),
    .BITSIZE_S_addr_ram(BITSIZE_S_addr_ram),
    .PORTSIZE_S_addr_ram(PORTSIZE_S_addr_ram),
    .BITSIZE_S_Wdata_ram(BITSIZE_S_Wdata_ram),
    .PORTSIZE_S_Wdata_ram(PORTSIZE_S_Wdata_ram),
    .BITSIZE_Sin_Rdata_ram(BITSIZE_Sin_Rdata_ram),
    .PORTSIZE_Sin_Rdata_ram(PORTSIZE_Sin_Rdata_ram),
    .BITSIZE_Sout_Rdata_ram(BITSIZE_Sout_Rdata_ram),
    .PORTSIZE_Sout_Rdata_ram(PORTSIZE_Sout_Rdata_ram),
    .BITSIZE_S_data_ram_size(BITSIZE_S_data_ram_size),
    .PORTSIZE_S_data_ram_size(PORTSIZE_S_data_ram_size),
    .BITSIZE_Sin_DataRdy(BITSIZE_Sin_DataRdy),
    .PORTSIZE_Sin_DataRdy(PORTSIZE_Sin_DataRdy),
    .BITSIZE_Sout_DataRdy(BITSIZE_Sout_DataRdy),
    .PORTSIZE_Sout_DataRdy(PORTSIZE_Sout_DataRdy),
    .MEMORY_INIT_file(MEMORY_INIT_file),
    .n_elements(n_elements),
    .data_size(data_size),
    .address_space_begin(address_space_begin),
    .address_space_rangesize(address_space_rangesize),
    .BUS_PIPELINED(BUS_PIPELINED),
    .PRIVATE_MEMORY(PRIVATE_MEMORY),
    .READ_ONLY_MEMORY(READ_ONLY_MEMORY),
    .USE_SPARSE_MEMORY(USE_SPARSE_MEMORY),
    .HIGH_LATENCY(0),
    .ALIGNMENT(ALIGNMENT),
    .BITSIZE_proxy_in1(BITSIZE_proxy_in1),
    .PORTSIZE_proxy_in1(PORTSIZE_proxy_in1),
    .BITSIZE_proxy_in2r(BITSIZE_proxy_in2r),
    .PORTSIZE_proxy_in2r(PORTSIZE_proxy_in2r),
    .BITSIZE_proxy_in2w(BITSIZE_proxy_in2w),
    .PORTSIZE_proxy_in2w(PORTSIZE_proxy_in2w),
    .BITSIZE_proxy_in3r(BITSIZE_proxy_in3r),
    .PORTSIZE_proxy_in3r(PORTSIZE_proxy_in3r),
    .BITSIZE_proxy_in3w(BITSIZE_proxy_in3w),
    .PORTSIZE_proxy_in3w(PORTSIZE_proxy_in3w),
    .BITSIZE_proxy_in4r(BITSIZE_proxy_in4r),
    .PORTSIZE_proxy_in4r(PORTSIZE_proxy_in4r),
    .BITSIZE_proxy_in4w(BITSIZE_proxy_in4w),
    .PORTSIZE_proxy_in4w(PORTSIZE_proxy_in4w),
    .BITSIZE_proxy_sel_LOAD(BITSIZE_proxy_sel_LOAD),
    .PORTSIZE_proxy_sel_LOAD(PORTSIZE_proxy_sel_LOAD),
    .BITSIZE_proxy_sel_STORE(BITSIZE_proxy_sel_STORE),
    .PORTSIZE_proxy_sel_STORE(PORTSIZE_proxy_sel_STORE),
    .BITSIZE_proxy_out1(BITSIZE_proxy_out1),
    .PORTSIZE_proxy_out1(PORTSIZE_proxy_out1)) ARRAY_1D_STD_BRAM_NN_instance (.out1(out1),
    .Sout_Rdata_ram(Sout_Rdata_ram),
    .Sout_DataRdy(Sout_DataRdy),
    .proxy_out1(proxy_out1),
    .clock(clock),
    .reset(reset),
    .in1(in1),
    .in2r(in2r),
    .in2w(in2w),
    .in3r(in3r),
    .in3w(in3w),
    .in4r(in4r),
    .in4w(in4w),
    .sel_LOAD(sel_LOAD),
    .sel_STORE(sel_STORE),
    .S_oe_ram(S_oe_ram),
    .S_we_ram(S_we_ram),
    .S_addr_ram(S_addr_ram),
    .S_Wdata_ram(S_Wdata_ram),
    .Sin_Rdata_ram(Sin_Rdata_ram),
    .S_data_ram_size(S_data_ram_size ),
    .Sin_DataRdy(Sin_DataRdy),
    .proxy_in1(proxy_in1),
    .proxy_in2r(proxy_in2r),
    .proxy_in2w(proxy_in2w),
    .proxy_in3r(proxy_in3r),
    .proxy_in3w(proxy_in3w),
    .proxy_in4r(proxy_in4r),
    .proxy_in4w(proxy_in4w),
    .proxy_sel_LOAD(proxy_sel_LOAD),
    .proxy_sel_STORE(proxy_sel_STORE));
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module addr_expr_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module UUdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){1'b0}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module read_cond_FU(in1,
  out1);
  parameter BITSIZE_in1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output out1;
  assign out1 = in1 != {BITSIZE_in1{1'b0}};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2020-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_extract_bit_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output out1;
  assign out1 = (in1 >> in2)&1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module lut_expr_FU(in1,
  in2,
  in3,
  in4,
  in5,
  in6,
  in7,
  in8,
  in9,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input in2;
  input in3;
  input in4;
  input in5;
  input in6;
  input in7;
  input in8;
  input in9;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  reg[7:0] cleaned_in0;
  wire [7:0] in0;
  wire[BITSIZE_in1-1:0] shifted_s;
  assign in0 = {in9, in8, in7, in6, in5, in4, in3, in2};
  generate
    genvar i0;
    for (i0=0; i0<8; i0=i0+1)
    begin : L0
          always @(*)
          begin
             if (in0[i0] == 1'b1)
                cleaned_in0[i0] = 1'b1;
             else
                cleaned_in0[i0] = 1'b0;
          end
    end
  endgenerate
  assign shifted_s = in1 >> cleaned_in0;
  assign out1[0] = shifted_s[0];
  generate
     if(BITSIZE_out1 > 1)
       assign out1[BITSIZE_out1-1:1] = 0;
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module BMEMORY_CTRLN(clock,
  in1,
  in2,
  in3,
  in4,
  sel_LOAD,
  sel_STORE,
  out1,
  Min_oe_ram,
  Mout_oe_ram,
  Min_we_ram,
  Mout_we_ram,
  Min_addr_ram,
  Mout_addr_ram,
  M_Rdata_ram,
  Min_Wdata_ram,
  Mout_Wdata_ram,
  Min_data_ram_size,
  Mout_data_ram_size,
  M_DataRdy);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2=1, PORTSIZE_in2=2,
    BITSIZE_in3=1, PORTSIZE_in3=2,
    BITSIZE_in4=1, PORTSIZE_in4=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_Min_oe_ram=1, PORTSIZE_Min_oe_ram=2,
    BITSIZE_Min_we_ram=1, PORTSIZE_Min_we_ram=2,
    BITSIZE_Mout_oe_ram=1, PORTSIZE_Mout_oe_ram=2,
    BITSIZE_Mout_we_ram=1, PORTSIZE_Mout_we_ram=2,
    BITSIZE_M_DataRdy=1, PORTSIZE_M_DataRdy=2,
    BITSIZE_Min_addr_ram=1, PORTSIZE_Min_addr_ram=2,
    BITSIZE_Mout_addr_ram=1, PORTSIZE_Mout_addr_ram=2,
    BITSIZE_M_Rdata_ram=8, PORTSIZE_M_Rdata_ram=2,
    BITSIZE_Min_Wdata_ram=8, PORTSIZE_Min_Wdata_ram=2,
    BITSIZE_Mout_Wdata_ram=8, PORTSIZE_Mout_Wdata_ram=2,
    BITSIZE_Min_data_ram_size=1, PORTSIZE_Min_data_ram_size=2,
    BITSIZE_Mout_data_ram_size=1, PORTSIZE_Mout_data_ram_size=2;
  // IN
  input clock;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2*BITSIZE_in2)+(-1):0] in2;
  input [(PORTSIZE_in3*BITSIZE_in3)+(-1):0] in3;
  input [PORTSIZE_in4-1:0] in4;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [PORTSIZE_Min_oe_ram-1:0] Min_oe_ram;
  input [PORTSIZE_Min_we_ram-1:0] Min_we_ram;
  input [(PORTSIZE_Min_addr_ram*BITSIZE_Min_addr_ram)+(-1):0] Min_addr_ram;
  input [(PORTSIZE_M_Rdata_ram*BITSIZE_M_Rdata_ram)+(-1):0] M_Rdata_ram;
  input [(PORTSIZE_Min_Wdata_ram*BITSIZE_Min_Wdata_ram)+(-1):0] Min_Wdata_ram;
  input [(PORTSIZE_Min_data_ram_size*BITSIZE_Min_data_ram_size)+(-1):0] Min_data_ram_size;
  input [PORTSIZE_M_DataRdy-1:0] M_DataRdy;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [PORTSIZE_Mout_oe_ram-1:0] Mout_oe_ram;
  output [PORTSIZE_Mout_we_ram-1:0] Mout_we_ram;
  output [(PORTSIZE_Mout_addr_ram*BITSIZE_Mout_addr_ram)+(-1):0] Mout_addr_ram;
  output [(PORTSIZE_Mout_Wdata_ram*BITSIZE_Mout_Wdata_ram)+(-1):0] Mout_Wdata_ram;
  output [(PORTSIZE_Mout_data_ram_size*BITSIZE_Mout_data_ram_size)+(-1):0] Mout_data_ram_size;
  
  parameter max_n_writes = PORTSIZE_sel_STORE > PORTSIZE_Mout_we_ram ? PORTSIZE_sel_STORE : PORTSIZE_Mout_we_ram;
  parameter max_n_reads = PORTSIZE_sel_LOAD > PORTSIZE_Mout_oe_ram ? PORTSIZE_sel_STORE : PORTSIZE_Mout_oe_ram;
  parameter max_n_rw = max_n_writes > max_n_reads ? max_n_writes : max_n_reads;
  wire  [(PORTSIZE_in2*BITSIZE_in2)-1:0] tmp_addr;
  wire [PORTSIZE_sel_LOAD-1:0] int_sel_LOAD;
  wire [PORTSIZE_sel_STORE-1:0] int_sel_STORE;
  assign int_sel_LOAD = sel_LOAD & in4;
  assign int_sel_STORE = sel_STORE & in4;
  assign tmp_addr = in2;
  generate
  genvar i;
    for (i=0; i<max_n_rw; i=i+1)
    begin : L0
      assign Mout_addr_ram[(i+1)*BITSIZE_Mout_addr_ram-1:i*BITSIZE_Mout_addr_ram] = ((i < PORTSIZE_sel_LOAD && int_sel_LOAD[i]) || (i < PORTSIZE_sel_STORE && int_sel_STORE[i])) ? (tmp_addr[(i+1)*BITSIZE_in2-1:i*BITSIZE_in2]) : Min_addr_ram[(i+1)*BITSIZE_Min_addr_ram-1:i*BITSIZE_Min_addr_ram];
    end
    endgenerate
  assign Mout_oe_ram = int_sel_LOAD | Min_oe_ram;
  assign Mout_we_ram = int_sel_STORE | Min_we_ram;
  generate
    for (i=0; i<max_n_reads; i=i+1)
    begin : L1
      assign out1[(i+1)*BITSIZE_out1-1:i*BITSIZE_out1] = M_Rdata_ram[i*BITSIZE_M_Rdata_ram+BITSIZE_out1-1:i*BITSIZE_M_Rdata_ram];
  end
  endgenerate
  generate
    for (i=0; i<max_n_rw; i=i+1)
    begin : L2
      assign Mout_Wdata_ram[(i+1)*BITSIZE_Mout_Wdata_ram-1:i*BITSIZE_Mout_Wdata_ram] = int_sel_STORE[i] ? in1[(i+1)*BITSIZE_in1-1:i*BITSIZE_in1] : Min_Wdata_ram[(i+1)*BITSIZE_Min_Wdata_ram-1:i*BITSIZE_Min_Wdata_ram];
  end
  endgenerate
  generate
    for (i=0; i<max_n_rw; i=i+1)
    begin : L3
      assign Mout_data_ram_size[(i+1)*BITSIZE_Mout_data_ram_size-1:i*BITSIZE_Mout_data_ram_size] = ((i < PORTSIZE_sel_LOAD && int_sel_LOAD[i]) || (i < PORTSIZE_sel_STORE && int_sel_STORE[i])) ? (in3[(i+1)*BITSIZE_in3-1:i*BITSIZE_in3]) : Min_data_ram_size[(i+1)*BITSIZE_Min_data_ram_size-1:i*BITSIZE_Min_data_ram_size];
    end
    endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_bit_and_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 & in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_bit_ior_concat_expr_FU(in1,
  in2,
  in3,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    OFFSET_PARAMETER=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  localparam nbit_out = BITSIZE_out1 > OFFSET_PARAMETER ? BITSIZE_out1 : 1+OFFSET_PARAMETER;
  wire [nbit_out-1:0] tmp_in1;
  wire [OFFSET_PARAMETER-1:0] tmp_in2;
  generate
    if(BITSIZE_in1 >= nbit_out)
      assign tmp_in1=in1[nbit_out-1:0];
    else
      assign tmp_in1={{(nbit_out-BITSIZE_in1){1'b0}},in1};
  endgenerate
  generate
    if(BITSIZE_in2 >= OFFSET_PARAMETER)
      assign tmp_in2=in2[OFFSET_PARAMETER-1:0];
    else
      assign tmp_in2={{(OFFSET_PARAMETER-BITSIZE_in2){1'b0}},in2};
  endgenerate
  assign out1 = {tmp_in1[nbit_out-1:OFFSET_PARAMETER] , tmp_in2};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_bit_ior_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 | in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_bit_xor_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 ^ in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_cond_expr_FU(in1,
  in2,
  in3,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 != 0 ? in2 : in3;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_eq_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 == in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_lshift_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    PRECISION=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    localparam arg2_bitsize = $clog2(PRECISION);
  `else
    localparam arg2_bitsize = log2(PRECISION);
  `endif
  generate
    if(BITSIZE_in2 > arg2_bitsize)
      assign out1 = in1 << in2[arg2_bitsize-1:0];
    else
      assign out1 = in1 << in2;
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_minus_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 - in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_negate_expr_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = -in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_plus_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 + in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_pointer_plus_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    LSB_PARAMETER=-1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  wire [BITSIZE_out1-1:0] in1_tmp;
  wire [BITSIZE_out1-1:0] in2_tmp;
  assign in1_tmp = in1;
  assign in2_tmp = in2;generate if (BITSIZE_out1 > LSB_PARAMETER) assign out1[BITSIZE_out1-1:LSB_PARAMETER] = (in1_tmp[BITSIZE_out1-1:LSB_PARAMETER] + in2_tmp[BITSIZE_out1-1:LSB_PARAMETER]); else assign out1 = 0; endgenerate
  generate if (LSB_PARAMETER != 0 && BITSIZE_out1 > LSB_PARAMETER) assign out1[LSB_PARAMETER-1:0] = 0; endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_rshift_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    PRECISION=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    localparam arg2_bitsize = $clog2(PRECISION);
  `else
    localparam arg2_bitsize = log2(PRECISION);
  `endif
  generate
    if(BITSIZE_in2 > arg2_bitsize)
      assign out1 = in1 >> (in2[arg2_bitsize-1:0]);
    else
      assign out1 = in1 >> in2;
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_ternary_plus_expr_FU(in1,
  in2,
  in3,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 + in2 + in3;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_DISTRAM_NN_SDS(clock,
  reset,
  in1,
  in2r,
  in2w,
  in3r,
  in3w,
  in4r,
  in4w,
  out1,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  Sout_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2r,
  proxy_in2w,
  proxy_in3r,
  proxy_in3w,
  proxy_in4r,
  proxy_in4w,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2r=1, PORTSIZE_in2r=2,
    BITSIZE_in2w=1, PORTSIZE_in2w=2,
    BITSIZE_in3r=1, PORTSIZE_in3r=2,
    BITSIZE_in3w=1, PORTSIZE_in3w=2,
    BITSIZE_in4r=1, PORTSIZE_in4r=2,
    BITSIZE_in4w=1, PORTSIZE_in4w=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_S_oe_ram=1, PORTSIZE_S_oe_ram=2,
    BITSIZE_S_we_ram=1, PORTSIZE_S_we_ram=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_S_addr_ram=1, PORTSIZE_S_addr_ram=2,
    BITSIZE_S_Wdata_ram=8, PORTSIZE_S_Wdata_ram=2,
    BITSIZE_Sin_Rdata_ram=8, PORTSIZE_Sin_Rdata_ram=2,
    BITSIZE_Sout_Rdata_ram=8, PORTSIZE_Sout_Rdata_ram=2,
    BITSIZE_S_data_ram_size=1, PORTSIZE_S_data_ram_size=2,
    BITSIZE_Sin_DataRdy=1, PORTSIZE_Sin_DataRdy=2,
    BITSIZE_Sout_DataRdy=1, PORTSIZE_Sout_DataRdy=2,
    MEMORY_INIT_file="array.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    PRIVATE_MEMORY=0,
    READ_ONLY_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    ALIGNMENT=32,
    BITSIZE_proxy_in1=1, PORTSIZE_proxy_in1=2,
    BITSIZE_proxy_in2r=1, PORTSIZE_proxy_in2r=2,
    BITSIZE_proxy_in2w=1, PORTSIZE_proxy_in2w=2,
    BITSIZE_proxy_in3r=1, PORTSIZE_proxy_in3r=2,
    BITSIZE_proxy_in3w=1, PORTSIZE_proxy_in3w=2,
    BITSIZE_proxy_in4r=1, PORTSIZE_proxy_in4r=2,
    BITSIZE_proxy_in4w=1, PORTSIZE_proxy_in4w=2,
    BITSIZE_proxy_sel_LOAD=1, PORTSIZE_proxy_sel_LOAD=2,
    BITSIZE_proxy_sel_STORE=1, PORTSIZE_proxy_sel_STORE=2,
    BITSIZE_proxy_out1=1, PORTSIZE_proxy_out1=2;
  // IN
  input clock;
  input reset;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2r*BITSIZE_in2r)+(-1):0] in2r;
  input [(PORTSIZE_in2w*BITSIZE_in2w)+(-1):0] in2w;
  input [(PORTSIZE_in3r*BITSIZE_in3r)+(-1):0] in3r;
  input [(PORTSIZE_in3w*BITSIZE_in3w)+(-1):0] in3w;
  input [PORTSIZE_in4r-1:0] in4r;
  input [PORTSIZE_in4w-1:0] in4w;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [PORTSIZE_S_oe_ram-1:0] S_oe_ram;
  input [PORTSIZE_S_we_ram-1:0] S_we_ram;
  input [(PORTSIZE_S_addr_ram*BITSIZE_S_addr_ram)+(-1):0] S_addr_ram;
  input [(PORTSIZE_S_Wdata_ram*BITSIZE_S_Wdata_ram)+(-1):0] S_Wdata_ram;
  input [(PORTSIZE_Sin_Rdata_ram*BITSIZE_Sin_Rdata_ram)+(-1):0] Sin_Rdata_ram;
  input [(PORTSIZE_S_data_ram_size*BITSIZE_S_data_ram_size)+(-1):0] S_data_ram_size;
  input [PORTSIZE_Sin_DataRdy-1:0] Sin_DataRdy;
  input [(PORTSIZE_proxy_in1*BITSIZE_proxy_in1)+(-1):0] proxy_in1;
  input [(PORTSIZE_proxy_in2r*BITSIZE_proxy_in2r)+(-1):0] proxy_in2r;
  input [(PORTSIZE_proxy_in2w*BITSIZE_proxy_in2w)+(-1):0] proxy_in2w;
  input [(PORTSIZE_proxy_in3r*BITSIZE_proxy_in3r)+(-1):0] proxy_in3r;
  input [(PORTSIZE_proxy_in3w*BITSIZE_proxy_in3w)+(-1):0] proxy_in3w;
  input [(PORTSIZE_proxy_in4r*BITSIZE_proxy_in4r)+(-1):0] proxy_in4r;
  input [(PORTSIZE_proxy_in4w*BITSIZE_proxy_in4w)+(-1):0] proxy_in4w;
  input [PORTSIZE_proxy_sel_LOAD-1:0] proxy_sel_LOAD;
  input [PORTSIZE_proxy_sel_STORE-1:0] proxy_sel_STORE;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [(PORTSIZE_Sout_Rdata_ram*BITSIZE_Sout_Rdata_ram)+(-1):0] Sout_Rdata_ram;
  output [PORTSIZE_Sout_DataRdy-1:0] Sout_DataRdy;
  output [(PORTSIZE_proxy_out1*BITSIZE_proxy_out1)+(-1):0] proxy_out1;
  
  `ifndef _SIM_HAVE_CLOG2
      function integer log2;
        input integer value;
        integer temp_value;
        begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
        end
      endfunction
  `endif
  parameter n_byte_on_databus = ALIGNMENT/8;
  parameter nbit_addr_r = BITSIZE_in2r > BITSIZE_proxy_in2r ? BITSIZE_in2r : BITSIZE_proxy_in2r;
  parameter nbit_addr_w = BITSIZE_in2w > BITSIZE_proxy_in2w ? BITSIZE_in2w : BITSIZE_proxy_in2w;
  `ifdef _SIM_HAVE_CLOG2
    localparam nbit_read_addr = n_elements == 1 ? 1 : $clog2(n_elements);
    localparam nbits_byte_offset = n_byte_on_databus<=1 ? 0 : $clog2(n_byte_on_databus);
  `else
    localparam nbit_read_addr = n_elements == 1 ? 1 : log2(n_elements);
    localparam nbits_byte_offset = n_byte_on_databus<=1 ? 0 : log2(n_byte_on_databus);
  `endif
  parameter max_n_writes = PORTSIZE_sel_STORE;
  parameter max_n_reads = PORTSIZE_sel_LOAD;
  
  wire [max_n_writes-1:0] bram_write;
  
  wire [nbit_read_addr*max_n_reads-1:0] memory_addr_a_r;
  wire [nbit_read_addr*max_n_writes-1:0] memory_addr_a_w;
  
  wire [data_size*max_n_writes-1:0] din_value_aggregated;
  wire [data_size*max_n_reads-1:0] dout_a;
  wire [nbit_addr_r*max_n_reads-1:0] tmp_addr_r;
  wire [nbit_addr_w*max_n_writes-1:0] tmp_addr_w;
  wire [nbit_addr_r*max_n_reads-1:0] relative_addr_r;
  wire [nbit_addr_w*max_n_writes-1:0] relative_addr_w;
  integer index2;
  
  reg [data_size-1:0] memory [0:n_elements-1] /* synthesis syn_ramstyle = "no_rw_check" */;
  
  initial
  begin
    $readmemb(MEMORY_INIT_file,memory,0,n_elements-1);
  end
  
  generate
  genvar ind2_r;
  for (ind2_r=0; ind2_r<max_n_reads; ind2_r=ind2_r+1)
    begin : Lind2_r
      assign tmp_addr_r[(ind2_r+1)*nbit_addr_r-1:ind2_r*nbit_addr_r] = (proxy_sel_LOAD[ind2_r] && proxy_in4r[ind2_r]) ? proxy_in2r[(ind2_r+1)*BITSIZE_proxy_in2r-1:ind2_r*BITSIZE_proxy_in2r] : in2r[(ind2_r+1)*BITSIZE_in2r-1:ind2_r*BITSIZE_in2r];
    end
  endgenerate
  
  generate
  genvar ind2_w;
  for (ind2_w=0; ind2_w<max_n_writes; ind2_w=ind2_w+1)
    begin : Lind2_w
      assign tmp_addr_w[(ind2_w+1)*nbit_addr_w-1:ind2_w*nbit_addr_w] = (proxy_sel_STORE[ind2_w] && proxy_in4w[ind2_w]) ? proxy_in2w[(ind2_w+1)*BITSIZE_proxy_in2w-1:ind2_w*BITSIZE_proxy_in2w] : in2w[(ind2_w+1)*BITSIZE_in2w-1:ind2_w*BITSIZE_in2w];
    end
  endgenerate
  
  generate
  genvar i6_r;
    for (i6_r=0; i6_r<max_n_reads; i6_r=i6_r+1)
    begin : L6_r
      if(USE_SPARSE_MEMORY==1)
        assign relative_addr_r[(i6_r+1)*nbit_addr_r-1:i6_r*nbit_addr_r] = tmp_addr_r[(i6_r+1)*nbit_addr_r-1:i6_r*nbit_addr_r];
      else
        assign relative_addr_r[(i6_r+1)*nbit_addr_r-1:i6_r*nbit_addr_r] = tmp_addr_r[(i6_r+1)*nbit_addr_r-1:i6_r*nbit_addr_r]-address_space_begin;
    end
  endgenerate
  
  generate
  genvar i6_w;
    for (i6_w=0; i6_w<max_n_writes; i6_w=i6_w+1)
    begin : L6_w
      if(USE_SPARSE_MEMORY==1)
        assign relative_addr_w[(i6_w+1)*nbit_addr_w-1:i6_w*nbit_addr_w] = tmp_addr_w[(i6_w+1)*nbit_addr_w-1:i6_w*nbit_addr_w];
      else
        assign relative_addr_w[(i6_w+1)*nbit_addr_w-1:i6_w*nbit_addr_w] = tmp_addr_w[(i6_w+1)*nbit_addr_w-1:i6_w*nbit_addr_w]-address_space_begin;
    end
  endgenerate
  
  generate
  genvar i7_r;
    for (i7_r=0; i7_r<max_n_reads; i7_r=i7_r+1)
    begin : L7_A_r
      if (n_elements==1)
        assign memory_addr_a_r[(i7_r+1)*nbit_read_addr-1:i7_r*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_a_r[(i7_r+1)*nbit_read_addr-1:i7_r*nbit_read_addr] = relative_addr_r[nbit_read_addr+nbits_byte_offset-1+i7_r*nbit_addr_r:nbits_byte_offset+i7_r*nbit_addr_r];
    end
  endgenerate
  
  generate
  genvar i7_w;
    for (i7_w=0; i7_w<max_n_writes; i7_w=i7_w+1)
    begin : L7_A_w
      if (n_elements==1)
        assign memory_addr_a_w[(i7_w+1)*nbit_read_addr-1:i7_w*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_a_w[(i7_w+1)*nbit_read_addr-1:i7_w*nbit_read_addr] = relative_addr_w[nbit_read_addr+nbits_byte_offset-1+i7_w*nbit_addr_w:nbits_byte_offset+i7_w*nbit_addr_w];
    end
  endgenerate
  
  generate
  genvar i14;
    for (i14=0; i14<max_n_writes; i14=i14+1)
    begin : L14
      assign din_value_aggregated[(i14+1)*data_size-1:i14*data_size] = (proxy_sel_STORE[i14] && proxy_in4w[i14]) ? proxy_in1[(i14+1)*BITSIZE_proxy_in1-1:i14*BITSIZE_proxy_in1] : in1[(i14+1)*BITSIZE_in1-1:i14*BITSIZE_in1];
    end
  endgenerate
  
  generate
  genvar i11;
    for (i11=0; i11<max_n_reads; i11=i11+1)
    begin : asynchronous_read
      assign dout_a[data_size*i11+:data_size] = memory[memory_addr_a_r[nbit_read_addr*i11+:nbit_read_addr]];
    end
  endgenerate
  
  generate if(READ_ONLY_MEMORY==0)
    always @(posedge clock)
    begin
      for (index2=0; index2<max_n_writes; index2=index2+1)
      begin
        if(bram_write[index2])
          memory[memory_addr_a_w[nbit_read_addr*index2+:nbit_read_addr]] <= din_value_aggregated[data_size*index2+:data_size];
      end
    end
  endgenerate
  
  generate
  genvar i21;
    for (i21=0; i21<max_n_writes; i21=i21+1)
    begin : L21
        assign bram_write[i21] = (sel_STORE[i21] && in4w[i21]) || (proxy_sel_STORE[i21] && proxy_in4w[i21]);
    end
  endgenerate
  
  generate
  genvar i20;
    for (i20=0; i20<max_n_reads; i20=i20+1)
    begin : L20
      assign out1[(i20+1)*BITSIZE_out1-1:i20*BITSIZE_out1] = dout_a[(i20+1)*data_size-1:i20*data_size];
      assign proxy_out1[(i20+1)*BITSIZE_proxy_out1-1:i20*BITSIZE_proxy_out1] = dout_a[(i20+1)*data_size-1:i20*data_size];
    end
  endgenerate
  assign Sout_Rdata_ram =Sin_Rdata_ram;
  assign Sout_DataRdy = Sin_DataRdy;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2013-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module SPROXY_CTRLN(in1,
  in2r,
  in2w,
  in3r,
  in3w,
  in4r,
  in4w,
  sel_LOAD,
  sel_STORE,
  out1,
  proxy_in1,
  proxy_in2r,
  proxy_in2w,
  proxy_in3r,
  proxy_in3w,
  proxy_in4r,
  proxy_in4w,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2r=1, PORTSIZE_in2r=2,
    BITSIZE_in2w=1, PORTSIZE_in2w=2,
    BITSIZE_in3r=1, PORTSIZE_in3r=2,
    BITSIZE_in3w=1, PORTSIZE_in3w=2,
    BITSIZE_in4r=1, PORTSIZE_in4r=2,
    BITSIZE_in4w=1, PORTSIZE_in4w=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_proxy_in1=1, PORTSIZE_proxy_in1=2,
    BITSIZE_proxy_in2r=1, PORTSIZE_proxy_in2r=2,
    BITSIZE_proxy_in2w=1, PORTSIZE_proxy_in2w=2,
    BITSIZE_proxy_in3r=1, PORTSIZE_proxy_in3r=2,
    BITSIZE_proxy_in3w=1, PORTSIZE_proxy_in3w=2,
    BITSIZE_proxy_in4r=1, PORTSIZE_proxy_in4r=2,
    BITSIZE_proxy_in4w=1, PORTSIZE_proxy_in4w=2,
    BITSIZE_proxy_sel_LOAD=1, PORTSIZE_proxy_sel_LOAD=2,
    BITSIZE_proxy_sel_STORE=1, PORTSIZE_proxy_sel_STORE=2,
    BITSIZE_proxy_out1=1, PORTSIZE_proxy_out1=2;
  // IN
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2r*BITSIZE_in2r)+(-1):0] in2r;
  input [(PORTSIZE_in2w*BITSIZE_in2w)+(-1):0] in2w;
  input [(PORTSIZE_in3r*BITSIZE_in3r)+(-1):0] in3r;
  input [(PORTSIZE_in3w*BITSIZE_in3w)+(-1):0] in3w;
  input [PORTSIZE_in4r-1:0] in4r;
  input [PORTSIZE_in4w-1:0] in4w;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [(PORTSIZE_proxy_out1*BITSIZE_proxy_out1)+(-1):0] proxy_out1;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [(PORTSIZE_proxy_in1*BITSIZE_proxy_in1)+(-1):0] proxy_in1;
  output [(PORTSIZE_proxy_in2r*BITSIZE_proxy_in2r)+(-1):0] proxy_in2r;
  output [(PORTSIZE_proxy_in2w*BITSIZE_proxy_in2w)+(-1):0] proxy_in2w;
  output [(PORTSIZE_proxy_in3r*BITSIZE_proxy_in3r)+(-1):0] proxy_in3r;
  output [(PORTSIZE_proxy_in3w*BITSIZE_proxy_in3w)+(-1):0] proxy_in3w;
  output [PORTSIZE_proxy_in4r-1:0] proxy_in4r;
  output [PORTSIZE_proxy_in4w-1:0] proxy_in4w;
  output [PORTSIZE_proxy_sel_LOAD-1:0] proxy_sel_LOAD;
  output [PORTSIZE_proxy_sel_STORE-1:0] proxy_sel_STORE;
  
  wire [PORTSIZE_sel_LOAD-1:0] int_sel_LOAD;
  wire [PORTSIZE_sel_STORE-1:0] int_sel_STORE;
  assign int_sel_LOAD = sel_LOAD & in4r;
  assign int_sel_STORE = sel_STORE & in4w;
  generate
  genvar i0;
  for (i0=0; i0<PORTSIZE_out1; i0=i0+1)
    begin : L0
      assign out1[(i0+1)*BITSIZE_out1-1:i0*BITSIZE_out1] = proxy_out1[(i0+1)*BITSIZE_proxy_out1-1:i0*BITSIZE_proxy_out1];
    end
  endgenerate
  generate
  genvar i1;
  for (i1=0; i1<PORTSIZE_in1; i1=i1+1)
    begin : L1
      assign proxy_in1[(i1+1)*BITSIZE_proxy_in1-1:i1*BITSIZE_proxy_in1] = int_sel_STORE[i1] ? in1[(i1+1)*BITSIZE_in1-1:i1*BITSIZE_in1] : 0;
    end
  endgenerate
  generate
  genvar i2r;
  for (i2r=0; i2r<PORTSIZE_in2r; i2r=i2r+1)
    begin : L2r
      assign proxy_in2r[(i2r+1)*BITSIZE_proxy_in2r-1:i2r*BITSIZE_proxy_in2r] = int_sel_LOAD[i2r] ? in2r[(i2r+1)*BITSIZE_in2r-1:i2r*BITSIZE_in2r] : 0;
    end
  endgenerate
  
  generate
  genvar i2w;
  for (i2w=0; i2w<PORTSIZE_in2w; i2w=i2w+1)
    begin : L2w
      assign proxy_in2w[(i2w+1)*BITSIZE_proxy_in2w-1:i2w*BITSIZE_proxy_in2w] = int_sel_STORE[i2w] ? in2w[(i2w+1)*BITSIZE_in2w-1:i2w*BITSIZE_in2w] : 0;
    end
  endgenerate
  
  generate
  genvar i3r;
  for (i3r=0; i3r<PORTSIZE_in3r; i3r=i3r+1)
    begin : L3r
      assign proxy_in3r[(i3r+1)*BITSIZE_proxy_in3r-1:i3r*BITSIZE_proxy_in3r] = int_sel_LOAD[i3r] ? in3r[(i3r+1)*BITSIZE_in3r-1:i3r*BITSIZE_in3r] : 0;
    end
  endgenerate
  
  generate
  genvar i3w;
  for (i3w=0; i3w<PORTSIZE_in3w; i3w=i3w+1)
    begin : L3w
      assign proxy_in3w[(i3w+1)*BITSIZE_proxy_in3w-1:i3w*BITSIZE_proxy_in3w] = int_sel_STORE[i3w] ? in3w[(i3w+1)*BITSIZE_in3w-1:i3w*BITSIZE_in3w] : 0;
    end
  endgenerate
  
  assign proxy_in4r = int_sel_LOAD;
  assign proxy_in4w = int_sel_STORE;
  assign proxy_sel_LOAD = int_sel_LOAD;
  assign proxy_sel_STORE = int_sel_STORE;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module UIdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){1'b0}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module IIdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){in1[BITSIZE_in1-1]}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module IUdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){in1[BITSIZE_in1-1]}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module gt_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 > in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module lt_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 < in2;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module max_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 > in2 ? in1 : in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module min_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 < in2 ? in1 : in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module mult_expr_FU(clock,
  in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    PIPE_PARAMETER=0;
  // IN
  input clock;
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  
  generate
    if(PIPE_PARAMETER==1)
    begin
      reg signed [BITSIZE_out1-1:0] out1_reg;
      assign out1 = out1_reg;
      always @(posedge clock)
      begin
        out1_reg <= in1 * in2;
      end
    end
    else if(PIPE_PARAMETER>1)
    begin
      reg signed [BITSIZE_in1-1:0] in1_in;
      reg signed [BITSIZE_in2-1:0] in2_in;
      wire signed [BITSIZE_out1-1:0] mult_res;
      reg signed [BITSIZE_out1-1:0] mul [PIPE_PARAMETER-2:0];
      integer i;
      assign mult_res = in1_in * in2_in;
      always @(posedge clock)
      begin
        in1_in <= in1;
        in2_in <= in2;
        mul[PIPE_PARAMETER-2] <= mult_res;
        for (i=0; i<PIPE_PARAMETER-2; i=i+1)
          mul[i] <= mul[i+1];
      end
      assign out1 = mul[0];
    end
    else
    begin
      assign out1 = in1 * in2;
    end
    endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module plus_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 + in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module rshift_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    PRECISION=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    localparam arg2_bitsize = $clog2(PRECISION);
  `else
    localparam arg2_bitsize = log2(PRECISION);
  `endif
  generate
    if(BITSIZE_in2 > arg2_bitsize)
      assign out1 = in1 >>> (in2[arg2_bitsize-1:0]);
    else
      assign out1 = in1 >>> in2;
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module MUX_GATE(sel,
  in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input sel;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = sel ? in1 : in2;
endmodule

// Datapath RTL description for conv_layer
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_conv_layer(clock,
  reset,
  in_port_in_off,
  in_port_out_off,
  in_port_w_off,
  in_port_m_off,
  in_port_cin,
  in_port_cout,
  in_port_H,
  in_port_hw,
  in_port_sh,
  in_port_pool,
  proxy_out1_428598,
  proxy_in1_428598,
  proxy_in2r_428598,
  proxy_in2w_428598,
  proxy_in3r_428598,
  proxy_in3w_428598,
  proxy_in4r_428598,
  proxy_in4w_428598,
  proxy_sel_LOAD_428598,
  proxy_sel_STORE_428598,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE,
  selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0,
  selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1,
  selector_MUX_148_reg_1_0_0_0,
  selector_MUX_157_reg_18_0_0_0,
  selector_MUX_158_reg_19_0_0_0,
  selector_MUX_160_reg_20_0_0_0,
  selector_MUX_163_reg_23_0_0_0,
  selector_MUX_166_reg_26_0_0_0,
  selector_MUX_167_reg_27_0_0_0,
  selector_MUX_171_reg_30_0_0_0,
  selector_MUX_172_reg_31_0_0_0,
  selector_MUX_174_reg_33_0_0_0,
  selector_MUX_176_reg_35_0_0_0,
  selector_MUX_176_reg_35_0_0_1,
  selector_MUX_177_reg_36_0_0_0,
  selector_MUX_179_reg_38_0_0_0,
  selector_MUX_181_reg_4_0_0_0,
  selector_MUX_183_reg_41_0_0_0,
  selector_MUX_191_reg_49_0_0_0,
  selector_MUX_193_reg_50_0_0_0,
  selector_MUX_194_reg_51_0_0_0,
  selector_MUX_195_reg_52_0_0_0,
  selector_MUX_219_reg_74_0_0_0,
  selector_MUX_219_reg_74_0_0_1,
  selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0,
  selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1,
  selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0,
  selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0,
  selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1,
  fuselector_SPROXY_CTRLN_3_i0_LOAD,
  fuselector_SPROXY_CTRLN_3_i0_STORE,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_10,
  wrenable_reg_11,
  wrenable_reg_12,
  wrenable_reg_13,
  wrenable_reg_14,
  wrenable_reg_15,
  wrenable_reg_16,
  wrenable_reg_17,
  wrenable_reg_18,
  wrenable_reg_19,
  wrenable_reg_2,
  wrenable_reg_20,
  wrenable_reg_21,
  wrenable_reg_22,
  wrenable_reg_23,
  wrenable_reg_24,
  wrenable_reg_25,
  wrenable_reg_26,
  wrenable_reg_27,
  wrenable_reg_28,
  wrenable_reg_29,
  wrenable_reg_3,
  wrenable_reg_30,
  wrenable_reg_31,
  wrenable_reg_32,
  wrenable_reg_33,
  wrenable_reg_34,
  wrenable_reg_35,
  wrenable_reg_36,
  wrenable_reg_37,
  wrenable_reg_38,
  wrenable_reg_39,
  wrenable_reg_4,
  wrenable_reg_40,
  wrenable_reg_41,
  wrenable_reg_42,
  wrenable_reg_43,
  wrenable_reg_44,
  wrenable_reg_45,
  wrenable_reg_46,
  wrenable_reg_47,
  wrenable_reg_48,
  wrenable_reg_49,
  wrenable_reg_5,
  wrenable_reg_50,
  wrenable_reg_51,
  wrenable_reg_52,
  wrenable_reg_53,
  wrenable_reg_54,
  wrenable_reg_55,
  wrenable_reg_56,
  wrenable_reg_57,
  wrenable_reg_58,
  wrenable_reg_59,
  wrenable_reg_6,
  wrenable_reg_60,
  wrenable_reg_61,
  wrenable_reg_62,
  wrenable_reg_63,
  wrenable_reg_64,
  wrenable_reg_65,
  wrenable_reg_66,
  wrenable_reg_67,
  wrenable_reg_68,
  wrenable_reg_69,
  wrenable_reg_7,
  wrenable_reg_70,
  wrenable_reg_71,
  wrenable_reg_72,
  wrenable_reg_73,
  wrenable_reg_74,
  wrenable_reg_75,
  wrenable_reg_76,
  wrenable_reg_77,
  wrenable_reg_78,
  wrenable_reg_79,
  wrenable_reg_8,
  wrenable_reg_80,
  wrenable_reg_81,
  wrenable_reg_82,
  wrenable_reg_83,
  wrenable_reg_84,
  wrenable_reg_9,
  OUT_CONDITION_conv_layer_428530_446745,
  OUT_CONDITION_conv_layer_428530_446751,
  OUT_CONDITION_conv_layer_428530_446755,
  OUT_CONDITION_conv_layer_428530_446783,
  OUT_CONDITION_conv_layer_428530_446788,
  OUT_CONDITION_conv_layer_428530_446825,
  OUT_CONDITION_conv_layer_428530_446832,
  OUT_CONDITION_conv_layer_428530_446849,
  OUT_CONDITION_conv_layer_428530_446854,
  OUT_CONDITION_conv_layer_428530_446860,
  OUT_CONDITION_conv_layer_428530_446865,
  OUT_CONDITION_conv_layer_428530_446871,
  OUT_CONDITION_conv_layer_428530_446876,
  OUT_CONDITION_conv_layer_428530_446882);
  parameter MEM_var_428598_428531=16384,
    MEM_var_440988_428530=16384,
    MEM_var_446454_428530=16384,
    MEM_var_446587_428530=16384;
  // IN
  input clock;
  input reset;
  input [31:0] in_port_in_off;
  input [31:0] in_port_out_off;
  input [31:0] in_port_w_off;
  input [31:0] in_port_m_off;
  input [31:0] in_port_cin;
  input [31:0] in_port_cout;
  input [31:0] in_port_H;
  input [31:0] in_port_hw;
  input [31:0] in_port_sh;
  input [31:0] in_port_pool;
  input [63:0] proxy_out1_428598;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  input selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  input selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  input selector_MUX_148_reg_1_0_0_0;
  input selector_MUX_157_reg_18_0_0_0;
  input selector_MUX_158_reg_19_0_0_0;
  input selector_MUX_160_reg_20_0_0_0;
  input selector_MUX_163_reg_23_0_0_0;
  input selector_MUX_166_reg_26_0_0_0;
  input selector_MUX_167_reg_27_0_0_0;
  input selector_MUX_171_reg_30_0_0_0;
  input selector_MUX_172_reg_31_0_0_0;
  input selector_MUX_174_reg_33_0_0_0;
  input selector_MUX_176_reg_35_0_0_0;
  input selector_MUX_176_reg_35_0_0_1;
  input selector_MUX_177_reg_36_0_0_0;
  input selector_MUX_179_reg_38_0_0_0;
  input selector_MUX_181_reg_4_0_0_0;
  input selector_MUX_183_reg_41_0_0_0;
  input selector_MUX_191_reg_49_0_0_0;
  input selector_MUX_193_reg_50_0_0_0;
  input selector_MUX_194_reg_51_0_0_0;
  input selector_MUX_195_reg_52_0_0_0;
  input selector_MUX_219_reg_74_0_0_0;
  input selector_MUX_219_reg_74_0_0_1;
  input selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0;
  input selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1;
  input selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0;
  input selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0;
  input selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1;
  input fuselector_SPROXY_CTRLN_3_i0_LOAD;
  input fuselector_SPROXY_CTRLN_3_i0_STORE;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_10;
  input wrenable_reg_11;
  input wrenable_reg_12;
  input wrenable_reg_13;
  input wrenable_reg_14;
  input wrenable_reg_15;
  input wrenable_reg_16;
  input wrenable_reg_17;
  input wrenable_reg_18;
  input wrenable_reg_19;
  input wrenable_reg_2;
  input wrenable_reg_20;
  input wrenable_reg_21;
  input wrenable_reg_22;
  input wrenable_reg_23;
  input wrenable_reg_24;
  input wrenable_reg_25;
  input wrenable_reg_26;
  input wrenable_reg_27;
  input wrenable_reg_28;
  input wrenable_reg_29;
  input wrenable_reg_3;
  input wrenable_reg_30;
  input wrenable_reg_31;
  input wrenable_reg_32;
  input wrenable_reg_33;
  input wrenable_reg_34;
  input wrenable_reg_35;
  input wrenable_reg_36;
  input wrenable_reg_37;
  input wrenable_reg_38;
  input wrenable_reg_39;
  input wrenable_reg_4;
  input wrenable_reg_40;
  input wrenable_reg_41;
  input wrenable_reg_42;
  input wrenable_reg_43;
  input wrenable_reg_44;
  input wrenable_reg_45;
  input wrenable_reg_46;
  input wrenable_reg_47;
  input wrenable_reg_48;
  input wrenable_reg_49;
  input wrenable_reg_5;
  input wrenable_reg_50;
  input wrenable_reg_51;
  input wrenable_reg_52;
  input wrenable_reg_53;
  input wrenable_reg_54;
  input wrenable_reg_55;
  input wrenable_reg_56;
  input wrenable_reg_57;
  input wrenable_reg_58;
  input wrenable_reg_59;
  input wrenable_reg_6;
  input wrenable_reg_60;
  input wrenable_reg_61;
  input wrenable_reg_62;
  input wrenable_reg_63;
  input wrenable_reg_64;
  input wrenable_reg_65;
  input wrenable_reg_66;
  input wrenable_reg_67;
  input wrenable_reg_68;
  input wrenable_reg_69;
  input wrenable_reg_7;
  input wrenable_reg_70;
  input wrenable_reg_71;
  input wrenable_reg_72;
  input wrenable_reg_73;
  input wrenable_reg_74;
  input wrenable_reg_75;
  input wrenable_reg_76;
  input wrenable_reg_77;
  input wrenable_reg_78;
  input wrenable_reg_79;
  input wrenable_reg_8;
  input wrenable_reg_80;
  input wrenable_reg_81;
  input wrenable_reg_82;
  input wrenable_reg_83;
  input wrenable_reg_84;
  input wrenable_reg_9;
  // OUT
  output [63:0] proxy_in1_428598;
  output [63:0] proxy_in2r_428598;
  output [63:0] proxy_in2w_428598;
  output [11:0] proxy_in3r_428598;
  output [11:0] proxy_in3w_428598;
  output [1:0] proxy_in4r_428598;
  output [1:0] proxy_in4w_428598;
  output [1:0] proxy_sel_LOAD_428598;
  output [1:0] proxy_sel_STORE_428598;
  output OUT_CONDITION_conv_layer_428530_446745;
  output OUT_CONDITION_conv_layer_428530_446751;
  output OUT_CONDITION_conv_layer_428530_446755;
  output OUT_CONDITION_conv_layer_428530_446783;
  output OUT_CONDITION_conv_layer_428530_446788;
  output OUT_CONDITION_conv_layer_428530_446825;
  output OUT_CONDITION_conv_layer_428530_446832;
  output OUT_CONDITION_conv_layer_428530_446849;
  output OUT_CONDITION_conv_layer_428530_446854;
  output OUT_CONDITION_conv_layer_428530_446860;
  output OUT_CONDITION_conv_layer_428530_446865;
  output OUT_CONDITION_conv_layer_428530_446871;
  output OUT_CONDITION_conv_layer_428530_446876;
  output OUT_CONDITION_conv_layer_428530_446882;
  // Component and signal declarations
  wire [7:0] null_out_signal_SPROXY_CTRLN_3_i0_out1_1;
  wire null_out_signal_array_440988_0_Sout_DataRdy_0;
  wire null_out_signal_array_440988_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_440988_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_440988_0_Sout_Rdata_ram_1;
  wire [31:0] null_out_signal_array_440988_0_out1_1;
  wire [31:0] null_out_signal_array_440988_0_proxy_out1_0;
  wire [31:0] null_out_signal_array_440988_0_proxy_out1_1;
  wire null_out_signal_array_446454_0_Sout_DataRdy_0;
  wire null_out_signal_array_446454_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_446454_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_446454_0_Sout_Rdata_ram_1;
  wire [15:0] null_out_signal_array_446454_0_out1_1;
  wire [31:0] null_out_signal_array_446454_0_proxy_out1_0;
  wire [31:0] null_out_signal_array_446454_0_proxy_out1_1;
  wire null_out_signal_array_446587_0_Sout_DataRdy_0;
  wire null_out_signal_array_446587_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_446587_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_446587_0_Sout_Rdata_ram_1;
  wire [31:0] null_out_signal_array_446587_0_out1_1;
  wire [31:0] null_out_signal_array_446587_0_proxy_out1_0;
  wire [31:0] null_out_signal_array_446587_0_proxy_out1_1;
  wire [31:0] out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_440988_0;
  wire [15:0] out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_446454_0;
  wire [31:0] out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_446587_0;
  wire signed [15:0] out_IIdata_converter_FU_18_i0_fu_conv_layer_428530_446438;
  wire signed [31:0] out_IIdata_converter_FU_20_i0_fu_conv_layer_428530_446576;
  wire signed [31:0] out_IIdata_converter_FU_52_i0_fu_conv_layer_428530_446140;
  wire [5:0] out_IUdata_converter_FU_53_i0_fu_conv_layer_428530_447001;
  wire [5:0] out_IUdata_converter_FU_57_i0_fu_conv_layer_428530_446900;
  wire [29:0] out_IUdata_converter_FU_76_i0_fu_conv_layer_428530_447086;
  wire [29:0] out_IUdata_converter_FU_80_i0_fu_conv_layer_428530_447127;
  wire [29:0] out_IUdata_converter_FU_84_i0_fu_conv_layer_428530_447167;
  wire [31:0] out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  wire [31:0] out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  wire [31:0] out_MUX_148_reg_1_0_0_0;
  wire [31:0] out_MUX_157_reg_18_0_0_0;
  wire [31:0] out_MUX_158_reg_19_0_0_0;
  wire [31:0] out_MUX_160_reg_20_0_0_0;
  wire [31:0] out_MUX_163_reg_23_0_0_0;
  wire [5:0] out_MUX_166_reg_26_0_0_0;
  wire [31:0] out_MUX_167_reg_27_0_0_0;
  wire [31:0] out_MUX_171_reg_30_0_0_0;
  wire [31:0] out_MUX_172_reg_31_0_0_0;
  wire [31:0] out_MUX_174_reg_33_0_0_0;
  wire [31:0] out_MUX_176_reg_35_0_0_0;
  wire [31:0] out_MUX_176_reg_35_0_0_1;
  wire [31:0] out_MUX_177_reg_36_0_0_0;
  wire [31:0] out_MUX_179_reg_38_0_0_0;
  wire [31:0] out_MUX_181_reg_4_0_0_0;
  wire [31:0] out_MUX_183_reg_41_0_0_0;
  wire [31:0] out_MUX_191_reg_49_0_0_0;
  wire [31:0] out_MUX_193_reg_50_0_0_0;
  wire [31:0] out_MUX_194_reg_51_0_0_0;
  wire [31:0] out_MUX_195_reg_52_0_0_0;
  wire [31:0] out_MUX_219_reg_74_0_0_0;
  wire [31:0] out_MUX_219_reg_74_0_0_1;
  wire [31:0] out_MUX_32_SPROXY_CTRLN_3_i0_1_0_0;
  wire [31:0] out_MUX_32_SPROXY_CTRLN_3_i0_1_0_1;
  wire [31:0] out_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0;
  wire [4:0] out_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0;
  wire [4:0] out_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1;
  wire [7:0] out_SPROXY_CTRLN_3_i0_SPROXY_CTRLN_3_i0;
  wire signed [15:0] out_UIdata_converter_FU_17_i0_fu_conv_layer_428530_446938;
  wire signed [31:0] out_UIdata_converter_FU_19_i0_fu_conv_layer_428530_446941;
  wire signed [7:0] out_UIdata_converter_FU_34_i0_fu_conv_layer_428530_447022;
  wire signed [31:0] out_UIdata_converter_FU_46_i0_fu_conv_layer_428530_447014;
  wire signed [31:0] out_UIdata_converter_FU_47_i0_fu_conv_layer_428530_447028;
  wire signed [31:0] out_UIdata_converter_FU_48_i0_fu_conv_layer_428530_447042;
  wire signed [6:0] out_UIdata_converter_FU_49_i0_fu_conv_layer_428530_447004;
  wire signed [31:0] out_UIdata_converter_FU_51_i0_fu_conv_layer_428530_446996;
  wire signed [6:0] out_UIdata_converter_FU_55_i0_fu_conv_layer_428530_447008;
  wire signed [31:0] out_UIdata_converter_FU_71_i0_fu_conv_layer_428530_447059;
  wire signed [31:0] out_UIdata_converter_FU_75_i0_fu_conv_layer_428530_447082;
  wire signed [31:0] out_UIdata_converter_FU_79_i0_fu_conv_layer_428530_447124;
  wire signed [31:0] out_UIdata_converter_FU_83_i0_fu_conv_layer_428530_447164;
  wire [7:0] out_UUdata_converter_FU_101_i0_fu_conv_layer_428530_446229;
  wire out_UUdata_converter_FU_106_i0_fu_conv_layer_428530_446870;
  wire [7:0] out_UUdata_converter_FU_111_i0_fu_conv_layer_428530_446346;
  wire out_UUdata_converter_FU_116_i0_fu_conv_layer_428530_446881;
  wire [7:0] out_UUdata_converter_FU_120_i0_fu_conv_layer_428530_446415;
  wire out_UUdata_converter_FU_21_i0_fu_conv_layer_428530_446744;
  wire out_UUdata_converter_FU_24_i0_fu_conv_layer_428530_446750;
  wire [5:0] out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090;
  wire out_UUdata_converter_FU_27_i0_fu_conv_layer_428530_446754;
  wire out_UUdata_converter_FU_29_i0_fu_conv_layer_428530_446269;
  wire out_UUdata_converter_FU_30_i0_fu_conv_layer_428530_446266;
  wire [4:0] out_UUdata_converter_FU_31_i0_fu_conv_layer_428530_446700;
  wire out_UUdata_converter_FU_42_i0_fu_conv_layer_428530_446782;
  wire [5:0] out_UUdata_converter_FU_54_i0_fu_conv_layer_428530_446113;
  wire out_UUdata_converter_FU_56_i0_fu_conv_layer_428530_446787;
  wire out_UUdata_converter_FU_64_i0_fu_conv_layer_428530_446824;
  wire out_UUdata_converter_FU_72_i0_fu_conv_layer_428530_446830;
  wire out_UUdata_converter_FU_74_i0_fu_conv_layer_428530_446853;
  wire out_UUdata_converter_FU_78_i0_fu_conv_layer_428530_446864;
  wire out_UUdata_converter_FU_82_i0_fu_conv_layer_428530_446875;
  wire out_UUdata_converter_FU_85_i0_fu_conv_layer_428530_446848;
  wire out_UUdata_converter_FU_95_i0_fu_conv_layer_428530_446859;
  wire [31:0] out_addr_expr_FU_32_i0_fu_conv_layer_428530_446945;
  wire [31:0] out_addr_expr_FU_33_i0_fu_conv_layer_428530_446952;
  wire [31:0] out_addr_expr_FU_35_i0_fu_conv_layer_428530_447098;
  wire [31:0] out_addr_expr_FU_36_i0_fu_conv_layer_428530_447120;
  wire out_const_0;
  wire [4:0] out_const_1;
  wire [2:0] out_const_10;
  wire [2:0] out_const_11;
  wire [5:0] out_const_12;
  wire [31:0] out_const_13;
  wire [14:0] out_const_14;
  wire [14:0] out_const_15;
  wire [14:0] out_const_16;
  wire [14:0] out_const_17;
  wire [5:0] out_const_2;
  wire [6:0] out_const_3;
  wire [6:0] out_const_4;
  wire out_const_5;
  wire [1:0] out_const_6;
  wire [7:0] out_const_7;
  wire [3:0] out_const_8;
  wire [1:0] out_const_9;
  wire [6:0] out_conv_in_port_H_32_7;
  wire [4:0] out_conv_in_port_cin_32_5;
  wire [4:0] out_conv_in_port_cout_32_5;
  wire [12:0] out_conv_in_port_hw_32_13;
  wire [6:0] out_conv_in_port_m_off_32_7;
  wire out_conv_in_port_pool_32_1;
  wire [4:0] out_conv_in_port_sh_32_5;
  wire [10:0] out_conv_in_port_w_off_32_11;
  wire [7:0] out_conv_out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090_6_8;
  wire [31:0] out_conv_out_const_0_1_32;
  wire [5:0] out_conv_out_const_0_1_6;
  wire [31:0] out_conv_out_const_14_15_32;
  wire [31:0] out_conv_out_const_15_15_32;
  wire [31:0] out_conv_out_const_16_15_32;
  wire [31:0] out_conv_out_const_17_15_32;
  wire [5:0] out_conv_out_const_1_5_6;
  wire [5:0] out_conv_out_const_3_7_6;
  wire out_gt_expr_FU_32_0_32_121_i0_fu_conv_layer_428530_447016;
  wire out_gt_expr_FU_32_0_32_121_i1_fu_conv_layer_428530_447030;
  wire out_gt_expr_FU_32_0_32_121_i2_fu_conv_layer_428530_447044;
  wire out_gt_expr_FU_32_0_32_121_i3_fu_conv_layer_428530_447061;
  wire out_lt_expr_FU_32_32_32_122_i0_fu_conv_layer_428530_447024;
  wire out_lt_expr_FU_32_32_32_122_i1_fu_conv_layer_428530_447038;
  wire out_lt_expr_FU_32_32_32_122_i2_fu_conv_layer_428530_447052;
  wire out_lt_expr_FU_32_32_32_122_i3_fu_conv_layer_428530_447069;
  wire out_lut_expr_FU_105_i0_fu_conv_layer_428530_447134;
  wire out_lut_expr_FU_108_i0_fu_conv_layer_428530_447157;
  wire out_lut_expr_FU_115_i0_fu_conv_layer_428530_447174;
  wire out_lut_expr_FU_118_i0_fu_conv_layer_428530_447191;
  wire out_lut_expr_FU_73_i0_fu_conv_layer_428530_447807;
  wire out_lut_expr_FU_77_i0_fu_conv_layer_428530_447814;
  wire out_lut_expr_FU_81_i0_fu_conv_layer_428530_447821;
  wire out_lut_expr_FU_94_i0_fu_conv_layer_428530_447093;
  wire out_lut_expr_FU_97_i0_fu_conv_layer_428530_447117;
  wire signed [6:0] out_max_expr_FU_64_0_64_123_i0_fu_conv_layer_428530_446118;
  wire signed [6:0] out_max_expr_FU_8_8_8_124_i0_fu_conv_layer_428530_446100;
  wire signed [48:0] out_min_expr_FU_64_0_64_125_i0_fu_conv_layer_428530_446125;
  wire signed [47:0] out_mult_expr_FU_32_32_32_0_126_i0_fu_conv_layer_428530_446136;
  wire signed [48:0] out_plus_expr_FU_64_64_64_127_i0_fu_conv_layer_428530_446132;
  wire out_read_cond_FU_109_i0_fu_conv_layer_428530_446871;
  wire out_read_cond_FU_110_i0_fu_conv_layer_428530_446876;
  wire out_read_cond_FU_119_i0_fu_conv_layer_428530_446882;
  wire out_read_cond_FU_22_i0_fu_conv_layer_428530_446745;
  wire out_read_cond_FU_25_i0_fu_conv_layer_428530_446751;
  wire out_read_cond_FU_28_i0_fu_conv_layer_428530_446755;
  wire out_read_cond_FU_43_i0_fu_conv_layer_428530_446783;
  wire out_read_cond_FU_58_i0_fu_conv_layer_428530_446788;
  wire out_read_cond_FU_65_i0_fu_conv_layer_428530_446825;
  wire out_read_cond_FU_86_i0_fu_conv_layer_428530_446832;
  wire out_read_cond_FU_88_i0_fu_conv_layer_428530_446849;
  wire out_read_cond_FU_89_i0_fu_conv_layer_428530_446854;
  wire out_read_cond_FU_98_i0_fu_conv_layer_428530_446860;
  wire out_read_cond_FU_99_i0_fu_conv_layer_428530_446865;
  wire [4:0] out_reg_0_reg_0;
  wire [7:0] out_reg_10_reg_10;
  wire [31:0] out_reg_11_reg_11;
  wire [31:0] out_reg_12_reg_12;
  wire [3:0] out_reg_13_reg_13;
  wire [6:0] out_reg_14_reg_14;
  wire [31:0] out_reg_15_reg_15;
  wire [15:0] out_reg_16_reg_16;
  wire [31:0] out_reg_17_reg_17;
  wire [31:0] out_reg_18_reg_18;
  wire [31:0] out_reg_19_reg_19;
  wire [31:0] out_reg_1_reg_1;
  wire [31:0] out_reg_20_reg_20;
  wire [31:0] out_reg_21_reg_21;
  wire [31:0] out_reg_22_reg_22;
  wire [31:0] out_reg_23_reg_23;
  wire [31:0] out_reg_24_reg_24;
  wire [31:0] out_reg_25_reg_25;
  wire [5:0] out_reg_26_reg_26;
  wire [31:0] out_reg_27_reg_27;
  wire [31:0] out_reg_28_reg_28;
  wire [31:0] out_reg_29_reg_29;
  wire [7:0] out_reg_2_reg_2;
  wire [31:0] out_reg_30_reg_30;
  wire [31:0] out_reg_31_reg_31;
  wire [31:0] out_reg_32_reg_32;
  wire [31:0] out_reg_33_reg_33;
  wire [31:0] out_reg_34_reg_34;
  wire [31:0] out_reg_35_reg_35;
  wire [31:0] out_reg_36_reg_36;
  wire [31:0] out_reg_37_reg_37;
  wire [31:0] out_reg_38_reg_38;
  wire [31:0] out_reg_39_reg_39;
  wire out_reg_3_reg_3;
  wire [31:0] out_reg_40_reg_40;
  wire [31:0] out_reg_41_reg_41;
  wire [6:0] out_reg_42_reg_42;
  wire out_reg_43_reg_43;
  wire out_reg_44_reg_44;
  wire out_reg_45_reg_45;
  wire out_reg_46_reg_46;
  wire out_reg_47_reg_47;
  wire out_reg_48_reg_48;
  wire [31:0] out_reg_49_reg_49;
  wire [31:0] out_reg_4_reg_4;
  wire [31:0] out_reg_50_reg_50;
  wire [31:0] out_reg_51_reg_51;
  wire [31:0] out_reg_52_reg_52;
  wire [25:0] out_reg_53_reg_53;
  wire [4:0] out_reg_54_reg_54;
  wire [31:0] out_reg_55_reg_55;
  wire [4:0] out_reg_56_reg_56;
  wire [4:0] out_reg_57_reg_57;
  wire out_reg_58_reg_58;
  wire out_reg_59_reg_59;
  wire [6:0] out_reg_5_reg_5;
  wire out_reg_60_reg_60;
  wire out_reg_61_reg_61;
  wire [31:0] out_reg_62_reg_62;
  wire [29:0] out_reg_63_reg_63;
  wire [29:0] out_reg_64_reg_64;
  wire [31:0] out_reg_65_reg_65;
  wire [31:0] out_reg_66_reg_66;
  wire [31:0] out_reg_67_reg_67;
  wire [31:0] out_reg_68_reg_68;
  wire [31:0] out_reg_69_reg_69;
  wire [1:0] out_reg_6_reg_6;
  wire [31:0] out_reg_70_reg_70;
  wire [31:0] out_reg_71_reg_71;
  wire [2:0] out_reg_72_reg_72;
  wire out_reg_73_reg_73;
  wire [31:0] out_reg_74_reg_74;
  wire [31:0] out_reg_75_reg_75;
  wire [31:0] out_reg_76_reg_76;
  wire [31:0] out_reg_77_reg_77;
  wire [31:0] out_reg_78_reg_78;
  wire [2:0] out_reg_79_reg_79;
  wire [31:0] out_reg_7_reg_7;
  wire out_reg_80_reg_80;
  wire [2:0] out_reg_81_reg_81;
  wire out_reg_82_reg_82;
  wire [48:0] out_reg_83_reg_83;
  wire out_reg_84_reg_84;
  wire [31:0] out_reg_8_reg_8;
  wire [8:0] out_reg_9_reg_9;
  wire signed [28:0] out_rshift_expr_FU_32_0_32_128_i0_fu_conv_layer_428530_446193;
  wire signed [28:0] out_rshift_expr_FU_32_0_32_128_i1_fu_conv_layer_428530_446331;
  wire signed [28:0] out_rshift_expr_FU_32_0_32_128_i2_fu_conv_layer_428530_446400;
  wire signed [48:0] out_rshift_expr_FU_64_64_64_129_i0_fu_conv_layer_428530_446128;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_130_i0_fu_conv_layer_428530_447611;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_131_i0_fu_conv_layer_428530_446219;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_131_i1_fu_conv_layer_428530_446337;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_131_i2_fu_conv_layer_428530_446406;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_131_i3_fu_conv_layer_428530_447454;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_131_i4_fu_conv_layer_428530_447471;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_131_i5_fu_conv_layer_428530_447530;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_132_i0_fu_conv_layer_428530_446297;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_132_i1_fu_conv_layer_428530_446366;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_132_i2_fu_conv_layer_428530_446434;
  wire [5:0] out_ui_bit_and_expr_FU_8_0_8_133_i0_fu_conv_layer_428530_447515;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_134_i0_fu_conv_layer_428530_446244;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_135_i0_fu_conv_layer_428530_446251;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_135_i1_fu_conv_layer_428530_446273;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_135_i2_fu_conv_layer_428530_446276;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_136_i0_fu_conv_layer_428530_446404;
  wire [8:0] out_ui_bit_ior_concat_expr_FU_137_i0_fu_conv_layer_428530_446984;
  wire [2:0] out_ui_bit_xor_expr_FU_8_0_8_138_i0_fu_conv_layer_428530_446294;
  wire [2:0] out_ui_bit_xor_expr_FU_8_0_8_138_i1_fu_conv_layer_428530_446363;
  wire [2:0] out_ui_bit_xor_expr_FU_8_0_8_138_i2_fu_conv_layer_428530_446431;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_139_i0_fu_conv_layer_428530_446165;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_139_i1_fu_conv_layer_428530_446304;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_139_i2_fu_conv_layer_428530_446373;
  wire [1:0] out_ui_cond_expr_FU_8_8_8_8_140_i0_fu_conv_layer_428530_446758;
  wire out_ui_eq_expr_FU_32_0_32_141_i0_fu_conv_layer_428530_447072;
  wire out_ui_eq_expr_FU_32_32_32_142_i0_fu_conv_layer_428530_446921;
  wire out_ui_eq_expr_FU_32_32_32_142_i1_fu_conv_layer_428530_446924;
  wire out_ui_eq_expr_FU_32_32_32_142_i2_fu_conv_layer_428530_446962;
  wire out_ui_eq_expr_FU_32_32_32_142_i3_fu_conv_layer_428530_446992;
  wire out_ui_eq_expr_FU_32_32_32_142_i4_fu_conv_layer_428530_447010;
  wire out_ui_eq_expr_FU_32_32_32_142_i5_fu_conv_layer_428530_447055;
  wire out_ui_extract_bit_expr_FU_102_i0_fu_conv_layer_428530_447903;
  wire out_ui_extract_bit_expr_FU_103_i0_fu_conv_layer_428530_447907;
  wire out_ui_extract_bit_expr_FU_104_i0_fu_conv_layer_428530_447911;
  wire out_ui_extract_bit_expr_FU_107_i0_fu_conv_layer_428530_447915;
  wire out_ui_extract_bit_expr_FU_112_i0_fu_conv_layer_428530_447923;
  wire out_ui_extract_bit_expr_FU_113_i0_fu_conv_layer_428530_447927;
  wire out_ui_extract_bit_expr_FU_114_i0_fu_conv_layer_428530_447931;
  wire out_ui_extract_bit_expr_FU_117_i0_fu_conv_layer_428530_447935;
  wire out_ui_extract_bit_expr_FU_6_i0_fu_conv_layer_428530_447797;
  wire out_ui_extract_bit_expr_FU_91_i0_fu_conv_layer_428530_447882;
  wire out_ui_extract_bit_expr_FU_92_i0_fu_conv_layer_428530_447886;
  wire out_ui_extract_bit_expr_FU_93_i0_fu_conv_layer_428530_447890;
  wire out_ui_extract_bit_expr_FU_96_i0_fu_conv_layer_428530_447895;
  wire [8:0] out_ui_lshift_expr_FU_16_0_16_143_i0_fu_conv_layer_428530_447449;
  wire [14:0] out_ui_lshift_expr_FU_16_16_16_144_i0_fu_conv_layer_428530_446224;
  wire [14:0] out_ui_lshift_expr_FU_16_16_16_144_i1_fu_conv_layer_428530_446342;
  wire [14:0] out_ui_lshift_expr_FU_16_16_16_144_i2_fu_conv_layer_428530_446411;
  wire [4:0] out_ui_lshift_expr_FU_32_0_32_145_i0_fu_conv_layer_428530_446222;
  wire [4:0] out_ui_lshift_expr_FU_32_0_32_145_i1_fu_conv_layer_428530_446340;
  wire [4:0] out_ui_lshift_expr_FU_32_0_32_145_i2_fu_conv_layer_428530_446409;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_146_i0_fu_conv_layer_428530_446930;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_146_i1_fu_conv_layer_428530_447091;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_146_i2_fu_conv_layer_428530_447132;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_146_i3_fu_conv_layer_428530_447172;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_147_i0_fu_conv_layer_428530_446935;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_147_i1_fu_conv_layer_428530_447608;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_148_i0_fu_conv_layer_428530_447468;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_148_i1_fu_conv_layer_428530_447483;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_148_i2_fu_conv_layer_428530_447527;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_149_i0_fu_conv_layer_428530_447501;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_149_i1_fu_conv_layer_428530_447512;
  wire [31:0] out_ui_lshift_expr_FU_32_32_32_150_i0_ui_lshift_expr_FU_32_32_32_150_i0;
  wire [7:0] out_ui_lshift_expr_FU_8_0_8_151_i0_fu_conv_layer_428530_446981;
  wire [4:0] out_ui_lshift_expr_FU_8_0_8_152_i0_fu_conv_layer_428530_447546;
  wire [4:0] out_ui_lshift_expr_FU_8_0_8_152_i1_fu_conv_layer_428530_447576;
  wire [4:0] out_ui_lshift_expr_FU_8_0_8_152_i2_fu_conv_layer_428530_447619;
  wire [7:0] out_ui_lshift_expr_FU_8_8_8_153_i0_fu_conv_layer_428530_446263;
  wire [28:0] out_ui_minus_expr_FU_32_32_32_154_i0_fu_conv_layer_428530_447465;
  wire [31:0] out_ui_negate_expr_FU_16_16_155_i0_fu_conv_layer_428530_446299;
  wire [31:0] out_ui_negate_expr_FU_16_16_155_i1_fu_conv_layer_428530_446368;
  wire [31:0] out_ui_negate_expr_FU_16_16_155_i2_fu_conv_layer_428530_446436;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_156_i0_fu_conv_layer_428530_446070;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_156_i1_fu_conv_layer_428530_446771;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_157_i0_fu_conv_layer_428530_446214;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_158_i0_fu_conv_layer_428530_446216;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i0_fu_conv_layer_428530_446292;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i10_fu_conv_layer_428530_446835;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i11_fu_conv_layer_428530_446839;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i1_fu_conv_layer_428530_446335;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i2_fu_conv_layer_428530_446429;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i3_fu_conv_layer_428530_446573;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i4_fu_conv_layer_428530_446716;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i5_fu_conv_layer_428530_446720;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i6_fu_conv_layer_428530_446728;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i7_fu_conv_layer_428530_446774;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i8_fu_conv_layer_428530_446778;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_159_i9_fu_conv_layer_428530_446822;
  wire [30:0] out_ui_plus_expr_FU_32_0_32_160_i0_fu_conv_layer_428530_447605;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i0_fu_conv_layer_428530_446162;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i10_fu_conv_layer_428530_446370;
  wire [29:0] out_ui_plus_expr_FU_32_32_32_161_i11_fu_conv_layer_428530_446396;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i12_fu_conv_layer_428530_446426;
  wire [30:0] out_ui_plus_expr_FU_32_32_32_161_i13_fu_conv_layer_428530_446567;
  wire [28:0] out_ui_plus_expr_FU_32_32_32_161_i14_fu_conv_layer_428530_447480;
  wire [25:0] out_ui_plus_expr_FU_32_32_32_161_i15_fu_conv_layer_428530_447498;
  wire [25:0] out_ui_plus_expr_FU_32_32_32_161_i16_fu_conv_layer_428530_447509;
  wire [28:0] out_ui_plus_expr_FU_32_32_32_161_i17_fu_conv_layer_428530_447524;
  wire [29:0] out_ui_plus_expr_FU_32_32_32_161_i1_fu_conv_layer_428530_446188;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i2_fu_conv_layer_428530_446207;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i3_fu_conv_layer_428530_446240;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i4_fu_conv_layer_428530_446260;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i5_fu_conv_layer_428530_446286;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i6_fu_conv_layer_428530_446301;
  wire [29:0] out_ui_plus_expr_FU_32_32_32_161_i7_fu_conv_layer_428530_446327;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i8_fu_conv_layer_428530_446357;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_161_i9_fu_conv_layer_428530_446360;
  wire [5:0] out_ui_plus_expr_FU_8_8_8_162_i0_fu_conv_layer_428530_447445;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i0_fu_conv_layer_428530_446085;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i1_fu_conv_layer_428530_446183;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i2_fu_conv_layer_428530_446235;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i3_fu_conv_layer_428530_446322;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i4_fu_conv_layer_428530_446352;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i5_fu_conv_layer_428530_446391;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i6_fu_conv_layer_428530_446421;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i7_fu_conv_layer_428530_446450;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_163_i8_fu_conv_layer_428530_446583;
  wire [6:0] out_ui_rshift_expr_FU_16_0_16_164_i0_fu_conv_layer_428530_447495;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_165_i0_fu_conv_layer_428530_447459;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_165_i1_fu_conv_layer_428530_447519;
  wire [25:0] out_ui_rshift_expr_FU_32_0_32_166_i0_fu_conv_layer_428530_447504;
  wire [25:0] out_ui_rshift_expr_FU_32_0_32_166_i1_fu_conv_layer_428530_447507;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_167_i0_fu_conv_layer_428530_447602;
  wire [3:0] out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0;
  wire [4:0] out_ui_rshift_expr_FU_8_0_8_169_i0_fu_conv_layer_428530_447439;
  wire [1:0] out_ui_rshift_expr_FU_8_0_8_169_i1_fu_conv_layer_428530_447443;
  wire [3:0] out_ui_rshift_expr_FU_8_0_8_169_i2_fu_conv_layer_428530_447463;
  wire [2:0] out_ui_rshift_expr_FU_8_0_8_170_i0_fu_conv_layer_428530_447542;
  wire [2:0] out_ui_rshift_expr_FU_8_0_8_170_i1_fu_conv_layer_428530_447572;
  wire [2:0] out_ui_rshift_expr_FU_8_0_8_170_i2_fu_conv_layer_428530_447615;
  wire [6:0] out_ui_rshift_expr_FU_8_8_8_171_i0_fu_conv_layer_428530_446738;
  wire [31:0] out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0;
  wire [31:0] out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1;
  wire [7:0] out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2;
  wire [5:0] out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3;
  wire [31:0] out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4;
  
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0 (.out1(out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .sel(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .in1(out_reg_77_reg_77),
    .in2(out_reg_75_reg_75));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1 (.out1(out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .sel(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .in1(out_reg_65_reg_65),
    .in2(out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_148_reg_1_0_0_0 (.out1(out_MUX_148_reg_1_0_0_0),
    .sel(selector_MUX_148_reg_1_0_0_0),
    .in1(out_reg_17_reg_17),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_157_reg_18_0_0_0 (.out1(out_MUX_157_reg_18_0_0_0),
    .sel(selector_MUX_157_reg_18_0_0_0),
    .in1(out_reg_22_reg_22),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_158_reg_19_0_0_0 (.out1(out_MUX_158_reg_19_0_0_0),
    .sel(selector_MUX_158_reg_19_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i4_fu_conv_layer_428530_446716),
    .in2(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_160_reg_20_0_0_0 (.out1(out_MUX_160_reg_20_0_0_0),
    .sel(selector_MUX_160_reg_20_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i6_fu_conv_layer_428530_446728),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_163_reg_23_0_0_0 (.out1(out_MUX_163_reg_23_0_0_0),
    .sel(selector_MUX_163_reg_23_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i5_fu_conv_layer_428530_446720),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(6),
    .BITSIZE_in2(6),
    .BITSIZE_out1(6)) MUX_166_reg_26_0_0_0 (.out1(out_MUX_166_reg_26_0_0_0),
    .sel(selector_MUX_166_reg_26_0_0_0),
    .in1(out_IUdata_converter_FU_57_i0_fu_conv_layer_428530_446900),
    .in2(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_167_reg_27_0_0_0 (.out1(out_MUX_167_reg_27_0_0_0),
    .sel(selector_MUX_167_reg_27_0_0_0),
    .in1(out_reg_18_reg_18),
    .in2(out_ui_bit_ior_concat_expr_FU_135_i1_fu_conv_layer_428530_446273));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_171_reg_30_0_0_0 (.out1(out_MUX_171_reg_30_0_0_0),
    .sel(selector_MUX_171_reg_30_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i7_fu_conv_layer_428530_446774),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_172_reg_31_0_0_0 (.out1(out_MUX_172_reg_31_0_0_0),
    .sel(selector_MUX_172_reg_31_0_0_0),
    .in1(out_reg_24_reg_24),
    .in2(out_ui_plus_expr_FU_32_0_32_159_i8_fu_conv_layer_428530_446778));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_174_reg_33_0_0_0 (.out1(out_MUX_174_reg_33_0_0_0),
    .sel(selector_MUX_174_reg_33_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i0_fu_conv_layer_428530_446292),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_176_reg_35_0_0_0 (.out1(out_MUX_176_reg_35_0_0_0),
    .sel(selector_MUX_176_reg_35_0_0_0),
    .in1(out_reg_74_reg_74),
    .in2(out_ui_plus_expr_FU_32_32_32_161_i10_fu_conv_layer_428530_446370));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_176_reg_35_0_0_1 (.out1(out_MUX_176_reg_35_0_0_1),
    .sel(selector_MUX_176_reg_35_0_0_1),
    .in1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in2(out_MUX_176_reg_35_0_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_177_reg_36_0_0_0 (.out1(out_MUX_177_reg_36_0_0_0),
    .sel(selector_MUX_177_reg_36_0_0_0),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_plus_expr_FU_32_0_32_157_i0_fu_conv_layer_428530_446214));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_179_reg_38_0_0_0 (.out1(out_MUX_179_reg_38_0_0_0),
    .sel(selector_MUX_179_reg_38_0_0_0),
    .in1(out_ui_lshift_expr_FU_32_0_32_149_i0_fu_conv_layer_428530_447501),
    .in2(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_181_reg_4_0_0_0 (.out1(out_MUX_181_reg_4_0_0_0),
    .sel(selector_MUX_181_reg_4_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i3_fu_conv_layer_428530_446573),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_183_reg_41_0_0_0 (.out1(out_MUX_183_reg_41_0_0_0),
    .sel(selector_MUX_183_reg_41_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i9_fu_conv_layer_428530_446822),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_191_reg_49_0_0_0 (.out1(out_MUX_191_reg_49_0_0_0),
    .sel(selector_MUX_191_reg_49_0_0_0),
    .in1(out_reg_36_reg_36),
    .in2(out_ui_plus_expr_FU_32_0_32_158_i0_fu_conv_layer_428530_446216));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_193_reg_50_0_0_0 (.out1(out_MUX_193_reg_50_0_0_0),
    .sel(selector_MUX_193_reg_50_0_0_0),
    .in1(out_reg_32_reg_32),
    .in2(out_ui_bit_ior_concat_expr_FU_135_i2_fu_conv_layer_428530_446276));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_194_reg_51_0_0_0 (.out1(out_MUX_194_reg_51_0_0_0),
    .sel(selector_MUX_194_reg_51_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i10_fu_conv_layer_428530_446835),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_195_reg_52_0_0_0 (.out1(out_MUX_195_reg_52_0_0_0),
    .sel(selector_MUX_195_reg_52_0_0_0),
    .in1(out_reg_34_reg_34),
    .in2(out_ui_plus_expr_FU_32_0_32_159_i11_fu_conv_layer_428530_446839));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_219_reg_74_0_0_0 (.out1(out_MUX_219_reg_74_0_0_0),
    .sel(selector_MUX_219_reg_74_0_0_0),
    .in1(out_reg_35_reg_35),
    .in2(out_ui_plus_expr_FU_32_32_32_161_i0_fu_conv_layer_428530_446162));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_219_reg_74_0_0_1 (.out1(out_MUX_219_reg_74_0_0_1),
    .sel(selector_MUX_219_reg_74_0_0_1),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i6_fu_conv_layer_428530_446301),
    .in2(out_MUX_219_reg_74_0_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_32_SPROXY_CTRLN_3_i0_1_0_0 (.out1(out_MUX_32_SPROXY_CTRLN_3_i0_1_0_0),
    .sel(selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0),
    .in1(out_reg_78_reg_78),
    .in2(out_reg_76_reg_76));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_32_SPROXY_CTRLN_3_i0_1_0_1 (.out1(out_MUX_32_SPROXY_CTRLN_3_i0_1_0_1),
    .sel(selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1),
    .in1(out_reg_71_reg_71),
    .in2(out_MUX_32_SPROXY_CTRLN_3_i0_1_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0 (.out1(out_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0),
    .sel(selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0),
    .in1(out_reg_23_reg_23),
    .in2(out_reg_20_reg_20));
  MUX_GATE #(.BITSIZE_in1(5),
    .BITSIZE_in2(5),
    .BITSIZE_out1(5)) MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0 (.out1(out_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0),
    .sel(selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0),
    .in1(out_reg_57_reg_57),
    .in2(out_reg_56_reg_56));
  MUX_GATE #(.BITSIZE_in1(5),
    .BITSIZE_in2(5),
    .BITSIZE_out1(5)) MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1 (.out1(out_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1),
    .sel(selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1),
    .in1(out_reg_54_reg_54),
    .in2(out_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0));
  SPROXY_CTRLN #(.BITSIZE_in1(8),
    .PORTSIZE_in1(2),
    .BITSIZE_in2r(32),
    .PORTSIZE_in2r(2),
    .BITSIZE_in2w(32),
    .PORTSIZE_in2w(2),
    .BITSIZE_in3r(6),
    .PORTSIZE_in3r(2),
    .BITSIZE_in3w(6),
    .PORTSIZE_in3w(2),
    .BITSIZE_in4r(1),
    .PORTSIZE_in4r(2),
    .BITSIZE_in4w(1),
    .PORTSIZE_in4w(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_out1(8),
    .PORTSIZE_out1(2),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2r(32),
    .PORTSIZE_proxy_in2r(2),
    .BITSIZE_proxy_in2w(32),
    .PORTSIZE_proxy_in2w(2),
    .BITSIZE_proxy_in3r(6),
    .PORTSIZE_proxy_in3r(2),
    .BITSIZE_proxy_in3w(6),
    .PORTSIZE_proxy_in3w(2),
    .BITSIZE_proxy_in4r(1),
    .PORTSIZE_proxy_in4r(2),
    .BITSIZE_proxy_in4w(1),
    .PORTSIZE_proxy_in4w(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) SPROXY_CTRLN_3_i0 (.out1({null_out_signal_SPROXY_CTRLN_3_i0_out1_1,
      out_SPROXY_CTRLN_3_i0_SPROXY_CTRLN_3_i0}),
    .proxy_in1(proxy_in1_428598),
    .proxy_in2r(proxy_in2r_428598),
    .proxy_in2w(proxy_in2w_428598),
    .proxy_in3r(proxy_in3r_428598),
    .proxy_in3w(proxy_in3w_428598),
    .proxy_in4r(proxy_in4r_428598),
    .proxy_in4w(proxy_in4w_428598),
    .proxy_sel_LOAD(proxy_sel_LOAD_428598),
    .proxy_sel_STORE(proxy_sel_STORE_428598),
    .in1({8'b00000000,
      out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2}),
    .in2r({32'b00000000000000000000000000000000,
      out_MUX_32_SPROXY_CTRLN_3_i0_1_0_1}),
    .in2w({32'b00000000000000000000000000000000,
      out_reg_25_reg_25}),
    .in3r({6'b000000,
      out_conv_out_const_1_5_6}),
    .in3w({6'b000000,
      out_conv_out_const_1_5_6}),
    .in4r({1'b0,
      out_const_5}),
    .in4w({1'b0,
      out_const_5}),
    .sel_LOAD({1'b0,
      fuselector_SPROXY_CTRLN_3_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_SPROXY_CTRLN_3_i0_STORE}),
    .proxy_out1(proxy_out1_428598));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_0 (.out1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in1(out_conv_out_const_0_1_32));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_1 (.out1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in1(in_port_out_off));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) UUdata_converter_FU_uu_conv_2 (.out1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in1(out_conv_out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090_6_8));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) UUdata_converter_FU_uu_conv_3 (.out1(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3),
    .in1(out_conv_out_const_0_1_6));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_4 (.out1(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4),
    .in1(in_port_in_off));
  ARRAY_1D_STD_BRAM_NN_SDS #(.BITSIZE_in1(32),
    .PORTSIZE_in1(2),
    .BITSIZE_in2r(32),
    .PORTSIZE_in2r(2),
    .BITSIZE_in2w(32),
    .PORTSIZE_in2w(2),
    .BITSIZE_in3r(6),
    .PORTSIZE_in3r(2),
    .BITSIZE_in3w(6),
    .PORTSIZE_in3w(2),
    .BITSIZE_in4r(1),
    .PORTSIZE_in4r(2),
    .BITSIZE_in4w(1),
    .PORTSIZE_in4w(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(32),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("array_ref_440988.mem"),
    .n_elements(2390),
    .data_size(32),
    .address_space_begin(MEM_var_440988_428530),
    .address_space_rangesize(16384),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(32),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2r(32),
    .PORTSIZE_proxy_in2r(2),
    .BITSIZE_proxy_in2w(32),
    .PORTSIZE_proxy_in2w(2),
    .BITSIZE_proxy_in3r(6),
    .PORTSIZE_proxy_in3r(2),
    .BITSIZE_proxy_in3w(6),
    .PORTSIZE_proxy_in3w(2),
    .BITSIZE_proxy_in4r(1),
    .PORTSIZE_proxy_in4r(2),
    .BITSIZE_proxy_in4w(1),
    .PORTSIZE_proxy_in4w(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_440988_0 (.out1({null_out_signal_array_440988_0_out1_1,
      out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_440988_0}),
    .Sout_Rdata_ram({null_out_signal_array_440988_0_Sout_Rdata_ram_1,
      null_out_signal_array_440988_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_440988_0_Sout_DataRdy_1,
      null_out_signal_array_440988_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_440988_0_proxy_out1_1,
      null_out_signal_array_440988_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in2r({32'b00000000000000000000000000000000,
      out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1}),
    .in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in3r({6'b000000,
      out_conv_out_const_3_7_6}),
    .in3w({6'b000000,
      6'b000000}),
    .in4r({1'b0,
      out_const_5}),
    .in4w({1'b0,
      1'b0}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2r({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in3r({6'b000000,
      6'b000000}),
    .proxy_in3w({6'b000000,
      6'b000000}),
    .proxy_in4r({1'b0,
      1'b0}),
    .proxy_in4w({1'b0,
      1'b0}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  ARRAY_1D_STD_DISTRAM_NN_SDS #(.BITSIZE_in1(16),
    .PORTSIZE_in1(2),
    .BITSIZE_in2r(32),
    .PORTSIZE_in2r(2),
    .BITSIZE_in2w(32),
    .PORTSIZE_in2w(2),
    .BITSIZE_in3r(6),
    .PORTSIZE_in3r(2),
    .BITSIZE_in3w(6),
    .PORTSIZE_in3w(2),
    .BITSIZE_in4r(1),
    .PORTSIZE_in4r(2),
    .BITSIZE_in4w(1),
    .PORTSIZE_in4w(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(16),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("array_ref_446454.mem"),
    .n_elements(107),
    .data_size(16),
    .address_space_begin(MEM_var_446454_428530),
    .address_space_rangesize(16384),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(16),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2r(32),
    .PORTSIZE_proxy_in2r(2),
    .BITSIZE_proxy_in2w(32),
    .PORTSIZE_proxy_in2w(2),
    .BITSIZE_proxy_in3r(6),
    .PORTSIZE_proxy_in3r(2),
    .BITSIZE_proxy_in3w(6),
    .PORTSIZE_proxy_in3w(2),
    .BITSIZE_proxy_in4r(1),
    .PORTSIZE_proxy_in4r(2),
    .BITSIZE_proxy_in4w(1),
    .PORTSIZE_proxy_in4w(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_446454_0 (.out1({null_out_signal_array_446454_0_out1_1,
      out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_446454_0}),
    .Sout_Rdata_ram({null_out_signal_array_446454_0_Sout_Rdata_ram_1,
      null_out_signal_array_446454_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_446454_0_Sout_DataRdy_1,
      null_out_signal_array_446454_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_446454_0_proxy_out1_1,
      null_out_signal_array_446454_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({16'b0000000000000000,
      16'b0000000000000000}),
    .in2r({32'b00000000000000000000000000000000,
      out_ui_pointer_plus_expr_FU_32_32_32_163_i7_fu_conv_layer_428530_446450}),
    .in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in3r({6'b000000,
      out_const_2}),
    .in3w({6'b000000,
      6'b000000}),
    .in4r({1'b0,
      out_const_5}),
    .in4w({1'b0,
      1'b0}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2r({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in3r({6'b000000,
      6'b000000}),
    .proxy_in3w({6'b000000,
      6'b000000}),
    .proxy_in4r({1'b0,
      1'b0}),
    .proxy_in4w({1'b0,
      1'b0}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  ARRAY_1D_STD_DISTRAM_NN_SDS #(.BITSIZE_in1(32),
    .PORTSIZE_in1(2),
    .BITSIZE_in2r(32),
    .PORTSIZE_in2r(2),
    .BITSIZE_in2w(32),
    .PORTSIZE_in2w(2),
    .BITSIZE_in3r(6),
    .PORTSIZE_in3r(2),
    .BITSIZE_in3w(6),
    .PORTSIZE_in3w(2),
    .BITSIZE_in4r(1),
    .PORTSIZE_in4r(2),
    .BITSIZE_in4w(1),
    .PORTSIZE_in4w(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(32),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("array_ref_446587.mem"),
    .n_elements(107),
    .data_size(32),
    .address_space_begin(MEM_var_446587_428530),
    .address_space_rangesize(16384),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(32),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2r(32),
    .PORTSIZE_proxy_in2r(2),
    .BITSIZE_proxy_in2w(32),
    .PORTSIZE_proxy_in2w(2),
    .BITSIZE_proxy_in3r(6),
    .PORTSIZE_proxy_in3r(2),
    .BITSIZE_proxy_in3w(6),
    .PORTSIZE_proxy_in3w(2),
    .BITSIZE_proxy_in4r(1),
    .PORTSIZE_proxy_in4r(2),
    .BITSIZE_proxy_in4w(1),
    .PORTSIZE_proxy_in4w(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_446587_0 (.out1({null_out_signal_array_446587_0_out1_1,
      out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_446587_0}),
    .Sout_Rdata_ram({null_out_signal_array_446587_0_Sout_Rdata_ram_1,
      null_out_signal_array_446587_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_446587_0_Sout_DataRdy_1,
      null_out_signal_array_446587_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_446587_0_proxy_out1_1,
      null_out_signal_array_446587_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in2r({32'b00000000000000000000000000000000,
      out_ui_pointer_plus_expr_FU_32_32_32_163_i8_fu_conv_layer_428530_446583}),
    .in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in3r({6'b000000,
      out_conv_out_const_3_7_6}),
    .in3w({6'b000000,
      6'b000000}),
    .in4r({1'b0,
      out_const_5}),
    .in4w({1'b0,
      1'b0}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2r({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in3r({6'b000000,
      6'b000000}),
    .proxy_in3w({6'b000000,
      6'b000000}),
    .proxy_in4r({1'b0,
      1'b0}),
    .proxy_in4w({1'b0,
      1'b0}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b01000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b110)) const_10 (.out1(out_const_10));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b111)) const_11 (.out1(out_const_11));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b111111)) const_12 (.out1(out_const_12));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b11111111111111111111111111111111)) const_13 (.out1(out_const_13));
  constant_value #(.BITSIZE_out1(15),
    .value(MEM_var_428598_428531)) const_14 (.out1(out_const_14));
  constant_value #(.BITSIZE_out1(15),
    .value(MEM_var_440988_428530)) const_15 (.out1(out_const_15));
  constant_value #(.BITSIZE_out1(15),
    .value(MEM_var_446454_428530)) const_16 (.out1(out_const_16));
  constant_value #(.BITSIZE_out1(15),
    .value(MEM_var_446587_428530)) const_17 (.out1(out_const_17));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b010000)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0111111)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b10000000)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1001)) const_8 (.out1(out_const_8));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_9 (.out1(out_const_9));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(7)) conv_in_port_H_32_7 (.out1(out_conv_in_port_H_32_7),
    .in1(in_port_H));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(5)) conv_in_port_cin_32_5 (.out1(out_conv_in_port_cin_32_5),
    .in1(in_port_cin));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(5)) conv_in_port_cout_32_5 (.out1(out_conv_in_port_cout_32_5),
    .in1(in_port_cout));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(13)) conv_in_port_hw_32_13 (.out1(out_conv_in_port_hw_32_13),
    .in1(in_port_hw));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(7)) conv_in_port_m_off_32_7 (.out1(out_conv_in_port_m_off_32_7),
    .in1(in_port_m_off));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(1)) conv_in_port_pool_32_1 (.out1(out_conv_in_port_pool_32_1),
    .in1(in_port_pool));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(5)) conv_in_port_sh_32_5 (.out1(out_conv_in_port_sh_32_5),
    .in1(in_port_sh));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(11)) conv_in_port_w_off_32_11 (.out1(out_conv_in_port_w_off_32_11),
    .in1(in_port_w_off));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(8)) conv_out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090_6_8 (.out1(out_conv_out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090_6_8),
    .in1(out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(32)) conv_out_const_0_1_32 (.out1(out_conv_out_const_0_1_32),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(6)) conv_out_const_0_1_6 (.out1(out_conv_out_const_0_1_6),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) conv_out_const_14_15_32 (.out1(out_conv_out_const_14_15_32),
    .in1(out_const_14));
  UUdata_converter_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) conv_out_const_15_15_32 (.out1(out_conv_out_const_15_15_32),
    .in1(out_const_15));
  UUdata_converter_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) conv_out_const_16_15_32 (.out1(out_conv_out_const_16_15_32),
    .in1(out_const_16));
  UUdata_converter_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) conv_out_const_17_15_32 (.out1(out_conv_out_const_17_15_32),
    .in1(out_const_17));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(6)) conv_out_const_1_5_6 (.out1(out_conv_out_const_1_5_6),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_3_7_6 (.out1(out_conv_out_const_3_7_6),
    .in1(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446070 (.out1(out_ui_plus_expr_FU_32_0_32_156_i0_fu_conv_layer_428530_446070),
    .in1(out_ui_lshift_expr_FU_32_32_32_150_i0_ui_lshift_expr_FU_32_32_32_150_i0),
    .in2(out_const_13));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_conv_layer_428530_446085 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i0_fu_conv_layer_428530_446085),
    .in1(out_reg_12_reg_12),
    .in2(out_reg_21_reg_21));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) fu_conv_layer_428530_446090 (.out1(out_UUdata_converter_FU_26_i0_fu_conv_layer_428530_446090),
    .in1(out_reg_26_reg_26));
  max_expr_FU #(.BITSIZE_in1(7),
    .BITSIZE_in2(7),
    .BITSIZE_out1(7)) fu_conv_layer_428530_446100 (.out1(out_max_expr_FU_8_8_8_124_i0_fu_conv_layer_428530_446100),
    .in1(out_reg_42_reg_42),
    .in2(out_UIdata_converter_FU_55_i0_fu_conv_layer_428530_447008));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) fu_conv_layer_428530_446113 (.out1(out_UUdata_converter_FU_54_i0_fu_conv_layer_428530_446113),
    .in1(out_IUdata_converter_FU_53_i0_fu_conv_layer_428530_447001));
  max_expr_FU #(.BITSIZE_in1(49),
    .BITSIZE_in2(1),
    .BITSIZE_out1(7)) fu_conv_layer_428530_446118 (.out1(out_max_expr_FU_64_0_64_123_i0_fu_conv_layer_428530_446118),
    .in1(out_reg_83_reg_83),
    .in2(out_const_0));
  min_expr_FU #(.BITSIZE_in1(49),
    .BITSIZE_in2(7),
    .BITSIZE_out1(49)) fu_conv_layer_428530_446125 (.out1(out_min_expr_FU_64_0_64_125_i0_fu_conv_layer_428530_446125),
    .in1(out_rshift_expr_FU_64_64_64_129_i0_fu_conv_layer_428530_446128),
    .in2(out_const_4));
  rshift_expr_FU #(.BITSIZE_in1(49),
    .BITSIZE_in2(5),
    .BITSIZE_out1(49),
    .PRECISION(64)) fu_conv_layer_428530_446128 (.out1(out_rshift_expr_FU_64_64_64_129_i0_fu_conv_layer_428530_446128),
    .in1(out_plus_expr_FU_64_64_64_127_i0_fu_conv_layer_428530_446132),
    .in2(out_reg_0_reg_0));
  plus_expr_FU #(.BITSIZE_in1(48),
    .BITSIZE_in2(32),
    .BITSIZE_out1(49)) fu_conv_layer_428530_446132 (.out1(out_plus_expr_FU_64_64_64_127_i0_fu_conv_layer_428530_446132),
    .in1(out_mult_expr_FU_32_32_32_0_126_i0_fu_conv_layer_428530_446136),
    .in2(out_reg_15_reg_15));
  mult_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(16),
    .BITSIZE_out1(48),
    .PIPE_PARAMETER(0)) fu_conv_layer_428530_446136 (.out1(out_mult_expr_FU_32_32_32_0_126_i0_fu_conv_layer_428530_446136),
    .clock(clock),
    .in1(out_IIdata_converter_FU_52_i0_fu_conv_layer_428530_446140),
    .in2(out_reg_16_reg_16));
  IIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446140 (.out1(out_IIdata_converter_FU_52_i0_fu_conv_layer_428530_446140),
    .in1(out_UIdata_converter_FU_51_i0_fu_conv_layer_428530_446996));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446162 (.out1(out_ui_plus_expr_FU_32_32_32_161_i0_fu_conv_layer_428530_446162),
    .in1(out_ui_cond_expr_FU_32_32_32_32_139_i0_fu_conv_layer_428530_446165),
    .in2(out_reg_35_reg_35));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(15),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446165 (.out1(out_ui_cond_expr_FU_32_32_32_32_139_i0_fu_conv_layer_428530_446165),
    .in1(out_reg_73_reg_73),
    .in2(out_ui_lshift_expr_FU_16_16_16_144_i0_fu_conv_layer_428530_446224),
    .in3(out_ui_negate_expr_FU_16_16_155_i0_fu_conv_layer_428530_446299));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(2)) fu_conv_layer_428530_446183 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i1_fu_conv_layer_428530_446183),
    .in1(out_reg_11_reg_11),
    .in2(out_reg_62_reg_62));
  ui_plus_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(11),
    .BITSIZE_out1(30)) fu_conv_layer_428530_446188 (.out1(out_ui_plus_expr_FU_32_32_32_161_i1_fu_conv_layer_428530_446188),
    .in1(out_IUdata_converter_FU_76_i0_fu_conv_layer_428530_447086),
    .in2(out_conv_in_port_w_off_32_11));
  rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_conv_layer_428530_446193 (.out1(out_rshift_expr_FU_32_0_32_128_i0_fu_conv_layer_428530_446193),
    .in1(out_UIdata_converter_FU_75_i0_fu_conv_layer_428530_447082),
    .in2(out_const_9));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(9),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446207 (.out1(out_ui_plus_expr_FU_32_32_32_161_i2_fu_conv_layer_428530_446207),
    .in1(out_reg_1_reg_1),
    .in2(out_reg_9_reg_9));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446214 (.out1(out_ui_plus_expr_FU_32_0_32_157_i0_fu_conv_layer_428530_446214),
    .in1(out_reg_36_reg_36),
    .in2(out_const_8));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446216 (.out1(out_ui_plus_expr_FU_32_0_32_158_i0_fu_conv_layer_428530_446216),
    .in1(out_reg_49_reg_49),
    .in2(out_const_9));
  ui_bit_and_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446219 (.out1(out_ui_bit_and_expr_FU_8_0_8_131_i0_fu_conv_layer_428530_446219),
    .in1(out_ui_rshift_expr_FU_8_0_8_170_i0_fu_conv_layer_428530_447542),
    .in2(out_const_11));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_446222 (.out1(out_ui_lshift_expr_FU_32_0_32_145_i0_fu_conv_layer_428530_446222),
    .in1(out_reg_49_reg_49),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(3),
    .BITSIZE_out1(15),
    .PRECISION(32)) fu_conv_layer_428530_446224 (.out1(out_ui_lshift_expr_FU_16_16_16_144_i0_fu_conv_layer_428530_446224),
    .in1(out_UUdata_converter_FU_101_i0_fu_conv_layer_428530_446229),
    .in2(out_reg_72_reg_72));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_conv_layer_428530_446229 (.out1(out_UUdata_converter_FU_101_i0_fu_conv_layer_428530_446229),
    .in1(out_SPROXY_CTRLN_3_i0_SPROXY_CTRLN_3_i0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_conv_layer_428530_446235 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i2_fu_conv_layer_428530_446235),
    .in1(out_reg_12_reg_12),
    .in2(out_reg_66_reg_66));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446240 (.out1(out_ui_plus_expr_FU_32_32_32_161_i3_fu_conv_layer_428530_446240),
    .in1(out_reg_55_reg_55),
    .in2(out_reg_37_reg_37));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(6),
    .BITSIZE_in3(3),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(6)) fu_conv_layer_428530_446244 (.out1(out_ui_bit_ior_concat_expr_FU_134_i0_fu_conv_layer_428530_446244),
    .in1(out_ui_lshift_expr_FU_32_0_32_149_i1_fu_conv_layer_428530_447512),
    .in2(out_ui_bit_and_expr_FU_8_0_8_133_i0_fu_conv_layer_428530_447515),
    .in3(out_const_10));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_in3(2),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(3)) fu_conv_layer_428530_446251 (.out1(out_ui_bit_ior_concat_expr_FU_135_i0_fu_conv_layer_428530_446251),
    .in1(out_ui_lshift_expr_FU_32_0_32_148_i0_fu_conv_layer_428530_447468),
    .in2(out_ui_bit_and_expr_FU_8_0_8_131_i4_fu_conv_layer_428530_447471),
    .in3(out_const_9));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(8),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446260 (.out1(out_ui_plus_expr_FU_32_32_32_161_i4_fu_conv_layer_428530_446260),
    .in1(out_reg_18_reg_18),
    .in2(out_reg_2_reg_2));
  ui_lshift_expr_FU #(.BITSIZE_in1(7),
    .BITSIZE_in2(1),
    .BITSIZE_out1(8),
    .PRECISION(32)) fu_conv_layer_428530_446263 (.out1(out_ui_lshift_expr_FU_8_8_8_153_i0_fu_conv_layer_428530_446263),
    .in1(out_conv_in_port_H_32_7),
    .in2(out_UUdata_converter_FU_30_i0_fu_conv_layer_428530_446266));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446266 (.out1(out_UUdata_converter_FU_30_i0_fu_conv_layer_428530_446266),
    .in1(out_UUdata_converter_FU_29_i0_fu_conv_layer_428530_446269));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446269 (.out1(out_UUdata_converter_FU_29_i0_fu_conv_layer_428530_446269),
    .in1(out_ui_extract_bit_expr_FU_6_i0_fu_conv_layer_428530_447797));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_in3(2),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(3)) fu_conv_layer_428530_446273 (.out1(out_ui_bit_ior_concat_expr_FU_135_i1_fu_conv_layer_428530_446273),
    .in1(out_ui_lshift_expr_FU_32_0_32_148_i1_fu_conv_layer_428530_447483),
    .in2(out_ui_bit_and_expr_FU_8_0_8_131_i4_fu_conv_layer_428530_447471),
    .in3(out_const_9));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_in3(2),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(3)) fu_conv_layer_428530_446276 (.out1(out_ui_bit_ior_concat_expr_FU_135_i2_fu_conv_layer_428530_446276),
    .in1(out_ui_lshift_expr_FU_32_0_32_148_i2_fu_conv_layer_428530_447527),
    .in2(out_ui_bit_and_expr_FU_8_0_8_131_i5_fu_conv_layer_428530_447530),
    .in3(out_const_9));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446286 (.out1(out_ui_plus_expr_FU_32_32_32_161_i5_fu_conv_layer_428530_446286),
    .in1(out_reg_28_reg_28),
    .in2(out_reg_33_reg_33));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446292 (.out1(out_ui_plus_expr_FU_32_0_32_159_i0_fu_conv_layer_428530_446292),
    .in1(out_reg_33_reg_33),
    .in2(out_const_5));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446294 (.out1(out_ui_bit_xor_expr_FU_8_0_8_138_i0_fu_conv_layer_428530_446294),
    .in1(out_ui_bit_and_expr_FU_8_0_8_132_i0_fu_conv_layer_428530_446297),
    .in2(out_const_11));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446297 (.out1(out_ui_bit_and_expr_FU_8_0_8_132_i0_fu_conv_layer_428530_446297),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_11));
  ui_negate_expr_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446299 (.out1(out_ui_negate_expr_FU_16_16_155_i0_fu_conv_layer_428530_446299),
    .in1(out_ui_lshift_expr_FU_16_16_16_144_i0_fu_conv_layer_428530_446224));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446301 (.out1(out_ui_plus_expr_FU_32_32_32_161_i6_fu_conv_layer_428530_446301),
    .in1(out_ui_cond_expr_FU_32_32_32_32_139_i1_fu_conv_layer_428530_446304),
    .in2(out_reg_74_reg_74));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(15),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446304 (.out1(out_ui_cond_expr_FU_32_32_32_32_139_i1_fu_conv_layer_428530_446304),
    .in1(out_reg_80_reg_80),
    .in2(out_ui_lshift_expr_FU_16_16_16_144_i1_fu_conv_layer_428530_446342),
    .in3(out_ui_negate_expr_FU_16_16_155_i1_fu_conv_layer_428530_446368));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(2)) fu_conv_layer_428530_446322 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i3_fu_conv_layer_428530_446322),
    .in1(out_reg_11_reg_11),
    .in2(out_reg_69_reg_69));
  ui_plus_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(11),
    .BITSIZE_out1(30)) fu_conv_layer_428530_446327 (.out1(out_ui_plus_expr_FU_32_32_32_161_i7_fu_conv_layer_428530_446327),
    .in1(out_reg_63_reg_63),
    .in2(out_conv_in_port_w_off_32_11));
  rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_conv_layer_428530_446331 (.out1(out_rshift_expr_FU_32_0_32_128_i1_fu_conv_layer_428530_446331),
    .in1(out_UIdata_converter_FU_79_i0_fu_conv_layer_428530_447124),
    .in2(out_const_9));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446335 (.out1(out_ui_plus_expr_FU_32_0_32_159_i1_fu_conv_layer_428530_446335),
    .in1(out_reg_49_reg_49),
    .in2(out_const_5));
  ui_bit_and_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446337 (.out1(out_ui_bit_and_expr_FU_8_0_8_131_i1_fu_conv_layer_428530_446337),
    .in1(out_ui_rshift_expr_FU_8_0_8_170_i1_fu_conv_layer_428530_447572),
    .in2(out_const_11));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_446340 (.out1(out_ui_lshift_expr_FU_32_0_32_145_i1_fu_conv_layer_428530_446340),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i1_fu_conv_layer_428530_446335),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(3),
    .BITSIZE_out1(15),
    .PRECISION(32)) fu_conv_layer_428530_446342 (.out1(out_ui_lshift_expr_FU_16_16_16_144_i1_fu_conv_layer_428530_446342),
    .in1(out_UUdata_converter_FU_111_i0_fu_conv_layer_428530_446346),
    .in2(out_reg_79_reg_79));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_conv_layer_428530_446346 (.out1(out_UUdata_converter_FU_111_i0_fu_conv_layer_428530_446346),
    .in1(out_SPROXY_CTRLN_3_i0_SPROXY_CTRLN_3_i0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_conv_layer_428530_446352 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i4_fu_conv_layer_428530_446352),
    .in1(out_reg_12_reg_12),
    .in2(out_reg_67_reg_67));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446357 (.out1(out_ui_plus_expr_FU_32_32_32_161_i8_fu_conv_layer_428530_446357),
    .in1(out_reg_55_reg_55),
    .in2(out_reg_39_reg_39));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446360 (.out1(out_ui_plus_expr_FU_32_32_32_161_i9_fu_conv_layer_428530_446360),
    .in1(out_reg_29_reg_29),
    .in2(out_reg_33_reg_33));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446363 (.out1(out_ui_bit_xor_expr_FU_8_0_8_138_i1_fu_conv_layer_428530_446363),
    .in1(out_ui_bit_and_expr_FU_8_0_8_132_i1_fu_conv_layer_428530_446366),
    .in2(out_const_11));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446366 (.out1(out_ui_bit_and_expr_FU_8_0_8_132_i1_fu_conv_layer_428530_446366),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_11));
  ui_negate_expr_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446368 (.out1(out_ui_negate_expr_FU_16_16_155_i1_fu_conv_layer_428530_446368),
    .in1(out_ui_lshift_expr_FU_16_16_16_144_i1_fu_conv_layer_428530_446342));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446370 (.out1(out_ui_plus_expr_FU_32_32_32_161_i10_fu_conv_layer_428530_446370),
    .in1(out_ui_cond_expr_FU_32_32_32_32_139_i2_fu_conv_layer_428530_446373),
    .in2(out_reg_74_reg_74));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(15),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446373 (.out1(out_ui_cond_expr_FU_32_32_32_32_139_i2_fu_conv_layer_428530_446373),
    .in1(out_reg_82_reg_82),
    .in2(out_ui_lshift_expr_FU_16_16_16_144_i2_fu_conv_layer_428530_446411),
    .in3(out_ui_negate_expr_FU_16_16_155_i2_fu_conv_layer_428530_446436));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(2)) fu_conv_layer_428530_446391 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i5_fu_conv_layer_428530_446391),
    .in1(out_reg_11_reg_11),
    .in2(out_reg_70_reg_70));
  ui_plus_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(11),
    .BITSIZE_out1(30)) fu_conv_layer_428530_446396 (.out1(out_ui_plus_expr_FU_32_32_32_161_i11_fu_conv_layer_428530_446396),
    .in1(out_reg_64_reg_64),
    .in2(out_conv_in_port_w_off_32_11));
  rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_conv_layer_428530_446400 (.out1(out_rshift_expr_FU_32_0_32_128_i2_fu_conv_layer_428530_446400),
    .in1(out_UIdata_converter_FU_83_i0_fu_conv_layer_428530_447164),
    .in2(out_const_9));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_conv_layer_428530_446404 (.out1(out_ui_bit_ior_concat_expr_FU_136_i0_fu_conv_layer_428530_446404),
    .in1(out_ui_lshift_expr_FU_32_0_32_147_i1_fu_conv_layer_428530_447608),
    .in2(out_ui_bit_and_expr_FU_1_0_1_130_i0_fu_conv_layer_428530_447611),
    .in3(out_const_5));
  ui_bit_and_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446406 (.out1(out_ui_bit_and_expr_FU_8_0_8_131_i2_fu_conv_layer_428530_446406),
    .in1(out_ui_rshift_expr_FU_8_0_8_170_i2_fu_conv_layer_428530_447615),
    .in2(out_const_11));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_446409 (.out1(out_ui_lshift_expr_FU_32_0_32_145_i2_fu_conv_layer_428530_446409),
    .in1(out_ui_bit_ior_concat_expr_FU_136_i0_fu_conv_layer_428530_446404),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(3),
    .BITSIZE_out1(15),
    .PRECISION(32)) fu_conv_layer_428530_446411 (.out1(out_ui_lshift_expr_FU_16_16_16_144_i2_fu_conv_layer_428530_446411),
    .in1(out_UUdata_converter_FU_120_i0_fu_conv_layer_428530_446415),
    .in2(out_reg_81_reg_81));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_conv_layer_428530_446415 (.out1(out_UUdata_converter_FU_120_i0_fu_conv_layer_428530_446415),
    .in1(out_SPROXY_CTRLN_3_i0_SPROXY_CTRLN_3_i0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_conv_layer_428530_446421 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i6_fu_conv_layer_428530_446421),
    .in1(out_reg_12_reg_12),
    .in2(out_reg_68_reg_68));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446426 (.out1(out_ui_plus_expr_FU_32_32_32_161_i12_fu_conv_layer_428530_446426),
    .in1(out_reg_55_reg_55),
    .in2(out_reg_40_reg_40));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446429 (.out1(out_ui_plus_expr_FU_32_0_32_159_i2_fu_conv_layer_428530_446429),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i9_fu_conv_layer_428530_446360),
    .in2(out_const_5));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446431 (.out1(out_ui_bit_xor_expr_FU_8_0_8_138_i2_fu_conv_layer_428530_446431),
    .in1(out_ui_bit_and_expr_FU_8_0_8_132_i2_fu_conv_layer_428530_446434),
    .in2(out_const_11));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_446434 (.out1(out_ui_bit_and_expr_FU_8_0_8_132_i2_fu_conv_layer_428530_446434),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_11));
  ui_negate_expr_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446436 (.out1(out_ui_negate_expr_FU_16_16_155_i2_fu_conv_layer_428530_446436),
    .in1(out_ui_lshift_expr_FU_16_16_16_144_i2_fu_conv_layer_428530_446411));
  IIdata_converter_FU #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) fu_conv_layer_428530_446438 (.out1(out_IIdata_converter_FU_18_i0_fu_conv_layer_428530_446438),
    .in1(out_UIdata_converter_FU_17_i0_fu_conv_layer_428530_446938));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(1)) fu_conv_layer_428530_446450 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i7_fu_conv_layer_428530_446450),
    .in1(out_reg_8_reg_8),
    .in2(out_ui_lshift_expr_FU_32_0_32_147_i0_fu_conv_layer_428530_446935));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(7),
    .BITSIZE_out1(31)) fu_conv_layer_428530_446567 (.out1(out_ui_plus_expr_FU_32_32_32_161_i13_fu_conv_layer_428530_446567),
    .in1(out_reg_4_reg_4),
    .in2(out_conv_in_port_m_off_32_7));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446573 (.out1(out_ui_plus_expr_FU_32_0_32_159_i3_fu_conv_layer_428530_446573),
    .in1(out_reg_4_reg_4),
    .in2(out_const_5));
  IIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446576 (.out1(out_IIdata_converter_FU_20_i0_fu_conv_layer_428530_446576),
    .in1(out_UIdata_converter_FU_19_i0_fu_conv_layer_428530_446941));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(2)) fu_conv_layer_428530_446583 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_163_i8_fu_conv_layer_428530_446583),
    .in1(out_reg_7_reg_7),
    .in2(out_ui_lshift_expr_FU_32_0_32_146_i0_fu_conv_layer_428530_446930));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) fu_conv_layer_428530_446700 (.out1(out_UUdata_converter_FU_31_i0_fu_conv_layer_428530_446700),
    .in1(out_conv_in_port_sh_32_5));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446716 (.out1(out_ui_plus_expr_FU_32_0_32_159_i4_fu_conv_layer_428530_446716),
    .in1(out_reg_21_reg_21),
    .in2(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446720 (.out1(out_ui_plus_expr_FU_32_0_32_159_i5_fu_conv_layer_428530_446720),
    .in1(out_reg_23_reg_23),
    .in2(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446728 (.out1(out_ui_plus_expr_FU_32_0_32_159_i6_fu_conv_layer_428530_446728),
    .in1(out_reg_20_reg_20),
    .in2(out_const_5));
  ui_rshift_expr_FU #(.BITSIZE_in1(7),
    .BITSIZE_in2(1),
    .BITSIZE_out1(7),
    .PRECISION(32)) fu_conv_layer_428530_446738 (.out1(out_ui_rshift_expr_FU_8_8_8_171_i0_fu_conv_layer_428530_446738),
    .in1(out_conv_in_port_H_32_7),
    .in2(out_UUdata_converter_FU_30_i0_fu_conv_layer_428530_446266));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446744 (.out1(out_UUdata_converter_FU_21_i0_fu_conv_layer_428530_446744),
    .in1(out_ui_eq_expr_FU_32_32_32_142_i0_fu_conv_layer_428530_446921));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446745 (.out1(out_read_cond_FU_22_i0_fu_conv_layer_428530_446745),
    .in1(out_UUdata_converter_FU_21_i0_fu_conv_layer_428530_446744));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446750 (.out1(out_UUdata_converter_FU_24_i0_fu_conv_layer_428530_446750),
    .in1(out_ui_eq_expr_FU_32_32_32_142_i1_fu_conv_layer_428530_446924));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446751 (.out1(out_read_cond_FU_25_i0_fu_conv_layer_428530_446751),
    .in1(out_UUdata_converter_FU_24_i0_fu_conv_layer_428530_446750));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446754 (.out1(out_UUdata_converter_FU_27_i0_fu_conv_layer_428530_446754),
    .in1(out_ui_eq_expr_FU_32_32_32_142_i2_fu_conv_layer_428530_446962));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446755 (.out1(out_read_cond_FU_28_i0_fu_conv_layer_428530_446755),
    .in1(out_UUdata_converter_FU_27_i0_fu_conv_layer_428530_446754));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(2),
    .BITSIZE_in3(1),
    .BITSIZE_out1(2)) fu_conv_layer_428530_446758 (.out1(out_ui_cond_expr_FU_8_8_8_8_140_i0_fu_conv_layer_428530_446758),
    .in1(out_ui_extract_bit_expr_FU_6_i0_fu_conv_layer_428530_447797),
    .in2(out_const_6),
    .in3(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446771 (.out1(out_ui_plus_expr_FU_32_0_32_156_i1_fu_conv_layer_428530_446771),
    .in1(out_reg_31_reg_31),
    .in2(out_const_13));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446774 (.out1(out_ui_plus_expr_FU_32_0_32_159_i7_fu_conv_layer_428530_446774),
    .in1(out_reg_30_reg_30),
    .in2(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446778 (.out1(out_ui_plus_expr_FU_32_0_32_159_i8_fu_conv_layer_428530_446778),
    .in1(out_reg_31_reg_31),
    .in2(out_const_5));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446782 (.out1(out_UUdata_converter_FU_42_i0_fu_conv_layer_428530_446782),
    .in1(out_ui_eq_expr_FU_32_32_32_142_i3_fu_conv_layer_428530_446992));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446783 (.out1(out_read_cond_FU_43_i0_fu_conv_layer_428530_446783),
    .in1(out_UUdata_converter_FU_42_i0_fu_conv_layer_428530_446782));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446787 (.out1(out_UUdata_converter_FU_56_i0_fu_conv_layer_428530_446787),
    .in1(out_ui_eq_expr_FU_32_32_32_142_i4_fu_conv_layer_428530_447010));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446788 (.out1(out_read_cond_FU_58_i0_fu_conv_layer_428530_446788),
    .in1(out_reg_84_reg_84));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446822 (.out1(out_ui_plus_expr_FU_32_0_32_159_i9_fu_conv_layer_428530_446822),
    .in1(out_reg_41_reg_41),
    .in2(out_const_5));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446824 (.out1(out_UUdata_converter_FU_64_i0_fu_conv_layer_428530_446824),
    .in1(out_ui_eq_expr_FU_32_32_32_142_i5_fu_conv_layer_428530_447055));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446825 (.out1(out_read_cond_FU_65_i0_fu_conv_layer_428530_446825),
    .in1(out_UUdata_converter_FU_64_i0_fu_conv_layer_428530_446824));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446830 (.out1(out_UUdata_converter_FU_72_i0_fu_conv_layer_428530_446830),
    .in1(out_gt_expr_FU_32_0_32_121_i3_fu_conv_layer_428530_447061));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446832 (.out1(out_read_cond_FU_86_i0_fu_conv_layer_428530_446832),
    .in1(out_UUdata_converter_FU_72_i0_fu_conv_layer_428530_446830));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446835 (.out1(out_ui_plus_expr_FU_32_0_32_159_i10_fu_conv_layer_428530_446835),
    .in1(out_reg_51_reg_51),
    .in2(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446839 (.out1(out_ui_plus_expr_FU_32_0_32_159_i11_fu_conv_layer_428530_446839),
    .in1(out_reg_52_reg_52),
    .in2(out_const_5));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446848 (.out1(out_UUdata_converter_FU_85_i0_fu_conv_layer_428530_446848),
    .in1(out_ui_eq_expr_FU_32_0_32_141_i0_fu_conv_layer_428530_447072));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446849 (.out1(out_read_cond_FU_88_i0_fu_conv_layer_428530_446849),
    .in1(out_reg_58_reg_58));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446853 (.out1(out_UUdata_converter_FU_74_i0_fu_conv_layer_428530_446853),
    .in1(out_lut_expr_FU_73_i0_fu_conv_layer_428530_447807));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446854 (.out1(out_read_cond_FU_89_i0_fu_conv_layer_428530_446854),
    .in1(out_reg_59_reg_59));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446859 (.out1(out_UUdata_converter_FU_95_i0_fu_conv_layer_428530_446859),
    .in1(out_lut_expr_FU_94_i0_fu_conv_layer_428530_447093));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446860 (.out1(out_read_cond_FU_98_i0_fu_conv_layer_428530_446860),
    .in1(out_UUdata_converter_FU_95_i0_fu_conv_layer_428530_446859));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446864 (.out1(out_UUdata_converter_FU_78_i0_fu_conv_layer_428530_446864),
    .in1(out_lut_expr_FU_77_i0_fu_conv_layer_428530_447814));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446865 (.out1(out_read_cond_FU_99_i0_fu_conv_layer_428530_446865),
    .in1(out_reg_60_reg_60));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446870 (.out1(out_UUdata_converter_FU_106_i0_fu_conv_layer_428530_446870),
    .in1(out_lut_expr_FU_105_i0_fu_conv_layer_428530_447134));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446871 (.out1(out_read_cond_FU_109_i0_fu_conv_layer_428530_446871),
    .in1(out_UUdata_converter_FU_106_i0_fu_conv_layer_428530_446870));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446875 (.out1(out_UUdata_converter_FU_82_i0_fu_conv_layer_428530_446875),
    .in1(out_lut_expr_FU_81_i0_fu_conv_layer_428530_447821));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446876 (.out1(out_read_cond_FU_110_i0_fu_conv_layer_428530_446876),
    .in1(out_reg_61_reg_61));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446881 (.out1(out_UUdata_converter_FU_116_i0_fu_conv_layer_428530_446881),
    .in1(out_lut_expr_FU_115_i0_fu_conv_layer_428530_447174));
  read_cond_FU #(.BITSIZE_in1(1)) fu_conv_layer_428530_446882 (.out1(out_read_cond_FU_119_i0_fu_conv_layer_428530_446882),
    .in1(out_UUdata_converter_FU_116_i0_fu_conv_layer_428530_446881));
  IUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) fu_conv_layer_428530_446900 (.out1(out_IUdata_converter_FU_57_i0_fu_conv_layer_428530_446900),
    .in1(out_max_expr_FU_8_8_8_124_i0_fu_conv_layer_428530_446100));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446921 (.out1(out_ui_eq_expr_FU_32_32_32_142_i0_fu_conv_layer_428530_446921),
    .in1(out_reg_4_reg_4),
    .in2(out_conv_in_port_cout_32_5));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(7),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446924 (.out1(out_ui_eq_expr_FU_32_32_32_142_i1_fu_conv_layer_428530_446924),
    .in1(out_reg_20_reg_20),
    .in2(out_reg_5_reg_5));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_446930 (.out1(out_ui_lshift_expr_FU_32_0_32_146_i0_fu_conv_layer_428530_446930),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i13_fu_conv_layer_428530_446567),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_446935 (.out1(out_ui_lshift_expr_FU_32_0_32_147_i0_fu_conv_layer_428530_446935),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i13_fu_conv_layer_428530_446567),
    .in2(out_const_5));
  UIdata_converter_FU #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) fu_conv_layer_428530_446938 (.out1(out_UIdata_converter_FU_17_i0_fu_conv_layer_428530_446938),
    .in1(out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_446454_0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446941 (.out1(out_UIdata_converter_FU_19_i0_fu_conv_layer_428530_446941),
    .in1(out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_446587_0));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446945 (.out1(out_addr_expr_FU_32_i0_fu_conv_layer_428530_446945),
    .in1(out_conv_out_const_17_15_32));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446952 (.out1(out_addr_expr_FU_33_i0_fu_conv_layer_428530_446952),
    .in1(out_conv_out_const_16_15_32));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(7),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446962 (.out1(out_ui_eq_expr_FU_32_32_32_142_i2_fu_conv_layer_428530_446962),
    .in1(out_reg_23_reg_23),
    .in2(out_reg_5_reg_5));
  ui_lshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(8),
    .PRECISION(32)) fu_conv_layer_428530_446981 (.out1(out_ui_lshift_expr_FU_8_0_8_151_i0_fu_conv_layer_428530_446981),
    .in1(out_conv_in_port_cin_32_5),
    .in2(out_const_9));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(9),
    .BITSIZE_in2(3),
    .BITSIZE_in3(2),
    .BITSIZE_out1(9),
    .OFFSET_PARAMETER(3)) fu_conv_layer_428530_446984 (.out1(out_ui_bit_ior_concat_expr_FU_137_i0_fu_conv_layer_428530_446984),
    .in1(out_ui_lshift_expr_FU_16_0_16_143_i0_fu_conv_layer_428530_447449),
    .in2(out_ui_bit_and_expr_FU_8_0_8_131_i3_fu_conv_layer_428530_447454),
    .in3(out_const_9));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(1)) fu_conv_layer_428530_446992 (.out1(out_ui_eq_expr_FU_32_32_32_142_i3_fu_conv_layer_428530_446992),
    .in1(out_reg_30_reg_30),
    .in2(out_reg_6_reg_6));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_446996 (.out1(out_UIdata_converter_FU_51_i0_fu_conv_layer_428530_446996),
    .in1(out_reg_35_reg_35));
  IUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) fu_conv_layer_428530_447001 (.out1(out_IUdata_converter_FU_53_i0_fu_conv_layer_428530_447001),
    .in1(out_max_expr_FU_64_0_64_123_i0_fu_conv_layer_428530_446118));
  UIdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(7)) fu_conv_layer_428530_447004 (.out1(out_UIdata_converter_FU_49_i0_fu_conv_layer_428530_447004),
    .in1(out_reg_26_reg_26));
  UIdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(7)) fu_conv_layer_428530_447008 (.out1(out_UIdata_converter_FU_55_i0_fu_conv_layer_428530_447008),
    .in1(out_UUdata_converter_FU_54_i0_fu_conv_layer_428530_446113));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447010 (.out1(out_ui_eq_expr_FU_32_32_32_142_i4_fu_conv_layer_428530_447010),
    .in1(out_reg_33_reg_33),
    .in2(out_reg_6_reg_6));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447014 (.out1(out_UIdata_converter_FU_46_i0_fu_conv_layer_428530_447014),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i5_fu_conv_layer_428530_446286));
  gt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447016 (.out1(out_gt_expr_FU_32_0_32_121_i0_fu_conv_layer_428530_447016),
    .in1(out_UIdata_converter_FU_46_i0_fu_conv_layer_428530_447014),
    .in2(out_const_5));
  UIdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(8)) fu_conv_layer_428530_447022 (.out1(out_UIdata_converter_FU_34_i0_fu_conv_layer_428530_447022),
    .in1(out_conv_in_port_H_32_7));
  lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447024 (.out1(out_lt_expr_FU_32_32_32_122_i0_fu_conv_layer_428530_447024),
    .in1(out_UIdata_converter_FU_46_i0_fu_conv_layer_428530_447014),
    .in2(out_reg_10_reg_10));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447028 (.out1(out_UIdata_converter_FU_47_i0_fu_conv_layer_428530_447028),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i9_fu_conv_layer_428530_446360));
  gt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447030 (.out1(out_gt_expr_FU_32_0_32_121_i1_fu_conv_layer_428530_447030),
    .in1(out_UIdata_converter_FU_47_i0_fu_conv_layer_428530_447028),
    .in2(out_const_5));
  lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447038 (.out1(out_lt_expr_FU_32_32_32_122_i1_fu_conv_layer_428530_447038),
    .in1(out_UIdata_converter_FU_47_i0_fu_conv_layer_428530_447028),
    .in2(out_reg_10_reg_10));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447042 (.out1(out_UIdata_converter_FU_48_i0_fu_conv_layer_428530_447042),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i2_fu_conv_layer_428530_446429));
  gt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447044 (.out1(out_gt_expr_FU_32_0_32_121_i2_fu_conv_layer_428530_447044),
    .in1(out_UIdata_converter_FU_48_i0_fu_conv_layer_428530_447042),
    .in2(out_const_5));
  lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447052 (.out1(out_lt_expr_FU_32_32_32_122_i2_fu_conv_layer_428530_447052),
    .in1(out_UIdata_converter_FU_48_i0_fu_conv_layer_428530_447042),
    .in2(out_reg_10_reg_10));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447055 (.out1(out_ui_eq_expr_FU_32_32_32_142_i5_fu_conv_layer_428530_447055),
    .in1(out_reg_41_reg_41),
    .in2(out_conv_in_port_cin_32_5));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447059 (.out1(out_UIdata_converter_FU_71_i0_fu_conv_layer_428530_447059),
    .in1(out_reg_52_reg_52));
  gt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447061 (.out1(out_gt_expr_FU_32_0_32_121_i3_fu_conv_layer_428530_447061),
    .in1(out_UIdata_converter_FU_71_i0_fu_conv_layer_428530_447059),
    .in2(out_const_5));
  lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447069 (.out1(out_lt_expr_FU_32_32_32_122_i3_fu_conv_layer_428530_447069),
    .in1(out_UIdata_converter_FU_71_i0_fu_conv_layer_428530_447059),
    .in2(out_reg_10_reg_10));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447072 (.out1(out_ui_eq_expr_FU_32_0_32_141_i0_fu_conv_layer_428530_447072),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i10_fu_conv_layer_428530_446835),
    .in2(out_const_9));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447082 (.out1(out_UIdata_converter_FU_75_i0_fu_conv_layer_428530_447082),
    .in1(out_reg_49_reg_49));
  IUdata_converter_FU #(.BITSIZE_in1(29),
    .BITSIZE_out1(30)) fu_conv_layer_428530_447086 (.out1(out_IUdata_converter_FU_76_i0_fu_conv_layer_428530_447086),
    .in1(out_rshift_expr_FU_32_0_32_128_i0_fu_conv_layer_428530_446193));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447091 (.out1(out_ui_lshift_expr_FU_32_0_32_146_i1_fu_conv_layer_428530_447091),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i1_fu_conv_layer_428530_446188),
    .in2(out_const_6));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447093 (.out1(out_lut_expr_FU_94_i0_fu_conv_layer_428530_447093),
    .in1(out_const_5),
    .in2(out_ui_extract_bit_expr_FU_91_i0_fu_conv_layer_428530_447882),
    .in3(out_ui_extract_bit_expr_FU_92_i0_fu_conv_layer_428530_447886),
    .in4(out_ui_extract_bit_expr_FU_93_i0_fu_conv_layer_428530_447890),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447098 (.out1(out_addr_expr_FU_35_i0_fu_conv_layer_428530_447098),
    .in1(out_conv_out_const_15_15_32));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447117 (.out1(out_lut_expr_FU_97_i0_fu_conv_layer_428530_447117),
    .in1(out_const_5),
    .in2(out_ui_extract_bit_expr_FU_96_i0_fu_conv_layer_428530_447895),
    .in3(1'b0),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447120 (.out1(out_addr_expr_FU_36_i0_fu_conv_layer_428530_447120),
    .in1(out_conv_out_const_14_15_32));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447124 (.out1(out_UIdata_converter_FU_79_i0_fu_conv_layer_428530_447124),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i1_fu_conv_layer_428530_446335));
  IUdata_converter_FU #(.BITSIZE_in1(29),
    .BITSIZE_out1(30)) fu_conv_layer_428530_447127 (.out1(out_IUdata_converter_FU_80_i0_fu_conv_layer_428530_447127),
    .in1(out_rshift_expr_FU_32_0_32_128_i1_fu_conv_layer_428530_446331));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447132 (.out1(out_ui_lshift_expr_FU_32_0_32_146_i2_fu_conv_layer_428530_447132),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i7_fu_conv_layer_428530_446327),
    .in2(out_const_6));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447134 (.out1(out_lut_expr_FU_105_i0_fu_conv_layer_428530_447134),
    .in1(out_const_5),
    .in2(out_ui_extract_bit_expr_FU_102_i0_fu_conv_layer_428530_447903),
    .in3(out_ui_extract_bit_expr_FU_103_i0_fu_conv_layer_428530_447907),
    .in4(out_ui_extract_bit_expr_FU_104_i0_fu_conv_layer_428530_447911),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447157 (.out1(out_lut_expr_FU_108_i0_fu_conv_layer_428530_447157),
    .in1(out_const_5),
    .in2(out_ui_extract_bit_expr_FU_107_i0_fu_conv_layer_428530_447915),
    .in3(1'b0),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_conv_layer_428530_447164 (.out1(out_UIdata_converter_FU_83_i0_fu_conv_layer_428530_447164),
    .in1(out_ui_bit_ior_concat_expr_FU_136_i0_fu_conv_layer_428530_446404));
  IUdata_converter_FU #(.BITSIZE_in1(29),
    .BITSIZE_out1(30)) fu_conv_layer_428530_447167 (.out1(out_IUdata_converter_FU_84_i0_fu_conv_layer_428530_447167),
    .in1(out_rshift_expr_FU_32_0_32_128_i2_fu_conv_layer_428530_446400));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447172 (.out1(out_ui_lshift_expr_FU_32_0_32_146_i3_fu_conv_layer_428530_447172),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i11_fu_conv_layer_428530_446396),
    .in2(out_const_6));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447174 (.out1(out_lut_expr_FU_115_i0_fu_conv_layer_428530_447174),
    .in1(out_const_5),
    .in2(out_ui_extract_bit_expr_FU_112_i0_fu_conv_layer_428530_447923),
    .in3(out_ui_extract_bit_expr_FU_113_i0_fu_conv_layer_428530_447927),
    .in4(out_ui_extract_bit_expr_FU_114_i0_fu_conv_layer_428530_447931),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447191 (.out1(out_lut_expr_FU_118_i0_fu_conv_layer_428530_447191),
    .in1(out_const_5),
    .in2(out_ui_extract_bit_expr_FU_117_i0_fu_conv_layer_428530_447935),
    .in3(1'b0),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_rshift_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_447439 (.out1(out_ui_rshift_expr_FU_8_0_8_169_i0_fu_conv_layer_428530_447439),
    .in1(out_ui_lshift_expr_FU_8_0_8_151_i0_fu_conv_layer_428530_446981),
    .in2(out_const_9));
  ui_rshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(2),
    .PRECISION(32)) fu_conv_layer_428530_447443 (.out1(out_ui_rshift_expr_FU_8_0_8_169_i1_fu_conv_layer_428530_447443),
    .in1(out_conv_in_port_cin_32_5),
    .in2(out_const_9));
  ui_plus_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(6)) fu_conv_layer_428530_447445 (.out1(out_ui_plus_expr_FU_8_8_8_162_i0_fu_conv_layer_428530_447445),
    .in1(out_ui_rshift_expr_FU_8_0_8_169_i0_fu_conv_layer_428530_447439),
    .in2(out_ui_rshift_expr_FU_8_0_8_169_i1_fu_conv_layer_428530_447443));
  ui_lshift_expr_FU #(.BITSIZE_in1(6),
    .BITSIZE_in2(2),
    .BITSIZE_out1(9),
    .PRECISION(32)) fu_conv_layer_428530_447449 (.out1(out_ui_lshift_expr_FU_16_0_16_143_i0_fu_conv_layer_428530_447449),
    .in1(out_ui_plus_expr_FU_8_8_8_162_i0_fu_conv_layer_428530_447445),
    .in2(out_const_9));
  ui_bit_and_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_447454 (.out1(out_ui_bit_and_expr_FU_8_0_8_131_i3_fu_conv_layer_428530_447454),
    .in1(out_conv_in_port_cin_32_5),
    .in2(out_const_11));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_conv_layer_428530_447459 (.out1(out_ui_rshift_expr_FU_32_0_32_165_i0_fu_conv_layer_428530_447459),
    .in1(out_reg_27_reg_27),
    .in2(out_const_9));
  ui_rshift_expr_FU #(.BITSIZE_in1(7),
    .BITSIZE_in2(2),
    .BITSIZE_out1(4),
    .PRECISION(32)) fu_conv_layer_428530_447463 (.out1(out_ui_rshift_expr_FU_8_0_8_169_i2_fu_conv_layer_428530_447463),
    .in1(out_conv_in_port_H_32_7),
    .in2(out_const_9));
  ui_minus_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(4),
    .BITSIZE_out1(29)) fu_conv_layer_428530_447465 (.out1(out_ui_minus_expr_FU_32_32_32_154_i0_fu_conv_layer_428530_447465),
    .in1(out_ui_rshift_expr_FU_32_0_32_165_i0_fu_conv_layer_428530_447459),
    .in2(out_reg_13_reg_13));
  ui_lshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447468 (.out1(out_ui_lshift_expr_FU_32_0_32_148_i0_fu_conv_layer_428530_447468),
    .in1(out_ui_minus_expr_FU_32_32_32_154_i0_fu_conv_layer_428530_447465),
    .in2(out_const_9));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_447471 (.out1(out_ui_bit_and_expr_FU_8_0_8_131_i4_fu_conv_layer_428530_447471),
    .in1(out_reg_27_reg_27),
    .in2(out_const_11));
  ui_plus_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(4),
    .BITSIZE_out1(29)) fu_conv_layer_428530_447480 (.out1(out_ui_plus_expr_FU_32_32_32_161_i14_fu_conv_layer_428530_447480),
    .in1(out_ui_rshift_expr_FU_32_0_32_165_i0_fu_conv_layer_428530_447459),
    .in2(out_reg_13_reg_13));
  ui_lshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447483 (.out1(out_ui_lshift_expr_FU_32_0_32_148_i1_fu_conv_layer_428530_447483),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i14_fu_conv_layer_428530_447480),
    .in2(out_const_9));
  ui_rshift_expr_FU #(.BITSIZE_in1(13),
    .BITSIZE_in2(3),
    .BITSIZE_out1(7),
    .PRECISION(32)) fu_conv_layer_428530_447495 (.out1(out_ui_rshift_expr_FU_16_0_16_164_i0_fu_conv_layer_428530_447495),
    .in1(out_conv_in_port_hw_32_13),
    .in2(out_const_10));
  ui_plus_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(7),
    .BITSIZE_out1(26)) fu_conv_layer_428530_447498 (.out1(out_ui_plus_expr_FU_32_32_32_161_i15_fu_conv_layer_428530_447498),
    .in1(out_ui_rshift_expr_FU_32_0_32_166_i1_fu_conv_layer_428530_447507),
    .in2(out_reg_14_reg_14));
  ui_lshift_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447501 (.out1(out_ui_lshift_expr_FU_32_0_32_149_i0_fu_conv_layer_428530_447501),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i15_fu_conv_layer_428530_447498),
    .in2(out_const_10));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(26),
    .PRECISION(32)) fu_conv_layer_428530_447504 (.out1(out_ui_rshift_expr_FU_32_0_32_166_i0_fu_conv_layer_428530_447504),
    .in1(out_reg_50_reg_50),
    .in2(out_const_10));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(26),
    .PRECISION(32)) fu_conv_layer_428530_447507 (.out1(out_ui_rshift_expr_FU_32_0_32_166_i1_fu_conv_layer_428530_447507),
    .in1(out_reg_38_reg_38),
    .in2(out_const_10));
  ui_plus_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(26),
    .BITSIZE_out1(26)) fu_conv_layer_428530_447509 (.out1(out_ui_plus_expr_FU_32_32_32_161_i16_fu_conv_layer_428530_447509),
    .in1(out_ui_rshift_expr_FU_32_0_32_166_i0_fu_conv_layer_428530_447504),
    .in2(out_reg_53_reg_53));
  ui_lshift_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447512 (.out1(out_ui_lshift_expr_FU_32_0_32_149_i1_fu_conv_layer_428530_447512),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i16_fu_conv_layer_428530_447509),
    .in2(out_const_10));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(6),
    .BITSIZE_out1(6)) fu_conv_layer_428530_447515 (.out1(out_ui_bit_and_expr_FU_8_0_8_133_i0_fu_conv_layer_428530_447515),
    .in1(out_reg_50_reg_50),
    .in2(out_const_12));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_conv_layer_428530_447519 (.out1(out_ui_rshift_expr_FU_32_0_32_165_i1_fu_conv_layer_428530_447519),
    .in1(out_reg_50_reg_50),
    .in2(out_const_9));
  ui_plus_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(4),
    .BITSIZE_out1(29)) fu_conv_layer_428530_447524 (.out1(out_ui_plus_expr_FU_32_32_32_161_i17_fu_conv_layer_428530_447524),
    .in1(out_ui_rshift_expr_FU_32_0_32_165_i1_fu_conv_layer_428530_447519),
    .in2(out_reg_13_reg_13));
  ui_lshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447527 (.out1(out_ui_lshift_expr_FU_32_0_32_148_i2_fu_conv_layer_428530_447527),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i17_fu_conv_layer_428530_447524),
    .in2(out_const_9));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_conv_layer_428530_447530 (.out1(out_ui_bit_and_expr_FU_8_0_8_131_i5_fu_conv_layer_428530_447530),
    .in1(out_reg_50_reg_50),
    .in2(out_const_11));
  ui_rshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(3),
    .PRECISION(32)) fu_conv_layer_428530_447542 (.out1(out_ui_rshift_expr_FU_8_0_8_170_i0_fu_conv_layer_428530_447542),
    .in1(out_ui_lshift_expr_FU_32_0_32_145_i0_fu_conv_layer_428530_446222),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_447546 (.out1(out_ui_lshift_expr_FU_8_0_8_152_i0_fu_conv_layer_428530_447546),
    .in1(out_ui_bit_and_expr_FU_8_0_8_131_i0_fu_conv_layer_428530_446219),
    .in2(out_const_6));
  ui_rshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(3),
    .PRECISION(32)) fu_conv_layer_428530_447572 (.out1(out_ui_rshift_expr_FU_8_0_8_170_i1_fu_conv_layer_428530_447572),
    .in1(out_ui_lshift_expr_FU_32_0_32_145_i1_fu_conv_layer_428530_446340),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_447576 (.out1(out_ui_lshift_expr_FU_8_0_8_152_i1_fu_conv_layer_428530_447576),
    .in1(out_ui_bit_and_expr_FU_8_0_8_131_i1_fu_conv_layer_428530_446337),
    .in2(out_const_6));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_conv_layer_428530_447602 (.out1(out_ui_rshift_expr_FU_32_0_32_167_i0_fu_conv_layer_428530_447602),
    .in1(out_reg_49_reg_49),
    .in2(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31)) fu_conv_layer_428530_447605 (.out1(out_ui_plus_expr_FU_32_0_32_160_i0_fu_conv_layer_428530_447605),
    .in1(out_ui_rshift_expr_FU_32_0_32_167_i0_fu_conv_layer_428530_447602),
    .in2(out_const_5));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_conv_layer_428530_447608 (.out1(out_ui_lshift_expr_FU_32_0_32_147_i1_fu_conv_layer_428530_447608),
    .in1(out_ui_plus_expr_FU_32_0_32_160_i0_fu_conv_layer_428530_447605),
    .in2(out_const_5));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447611 (.out1(out_ui_bit_and_expr_FU_1_0_1_130_i0_fu_conv_layer_428530_447611),
    .in1(out_reg_49_reg_49),
    .in2(out_const_5));
  ui_rshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(3),
    .PRECISION(32)) fu_conv_layer_428530_447615 (.out1(out_ui_rshift_expr_FU_8_0_8_170_i2_fu_conv_layer_428530_447615),
    .in1(out_ui_lshift_expr_FU_32_0_32_145_i2_fu_conv_layer_428530_446409),
    .in2(out_const_6));
  ui_lshift_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_conv_layer_428530_447619 (.out1(out_ui_lshift_expr_FU_8_0_8_152_i2_fu_conv_layer_428530_447619),
    .in1(out_ui_bit_and_expr_FU_8_0_8_131_i2_fu_conv_layer_428530_446406),
    .in2(out_const_6));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447797 (.out1(out_ui_extract_bit_expr_FU_6_i0_fu_conv_layer_428530_447797),
    .in1(out_conv_in_port_pool_32_1),
    .in2(out_const_0));
  lut_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447807 (.out1(out_lut_expr_FU_73_i0_fu_conv_layer_428530_447807),
    .in1(out_const_7),
    .in2(out_lt_expr_FU_32_32_32_122_i3_fu_conv_layer_428530_447069),
    .in3(out_reg_43_reg_43),
    .in4(out_reg_44_reg_44),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447814 (.out1(out_lut_expr_FU_77_i0_fu_conv_layer_428530_447814),
    .in1(out_const_7),
    .in2(out_lt_expr_FU_32_32_32_122_i3_fu_conv_layer_428530_447069),
    .in3(out_reg_45_reg_45),
    .in4(out_reg_46_reg_46),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(1)) fu_conv_layer_428530_447821 (.out1(out_lut_expr_FU_81_i0_fu_conv_layer_428530_447821),
    .in1(out_const_7),
    .in2(out_lt_expr_FU_32_32_32_122_i3_fu_conv_layer_428530_447069),
    .in3(out_reg_47_reg_47),
    .in4(out_reg_48_reg_48),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447882 (.out1(out_ui_extract_bit_expr_FU_91_i0_fu_conv_layer_428530_447882),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447886 (.out1(out_ui_extract_bit_expr_FU_92_i0_fu_conv_layer_428530_447886),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_5));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_conv_layer_428530_447890 (.out1(out_ui_extract_bit_expr_FU_93_i0_fu_conv_layer_428530_447890),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_6));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_conv_layer_428530_447895 (.out1(out_ui_extract_bit_expr_FU_96_i0_fu_conv_layer_428530_447895),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_9));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447903 (.out1(out_ui_extract_bit_expr_FU_102_i0_fu_conv_layer_428530_447903),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447907 (.out1(out_ui_extract_bit_expr_FU_103_i0_fu_conv_layer_428530_447907),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_5));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_conv_layer_428530_447911 (.out1(out_ui_extract_bit_expr_FU_104_i0_fu_conv_layer_428530_447911),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_6));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_conv_layer_428530_447915 (.out1(out_ui_extract_bit_expr_FU_107_i0_fu_conv_layer_428530_447915),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_9));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447923 (.out1(out_ui_extract_bit_expr_FU_112_i0_fu_conv_layer_428530_447923),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_conv_layer_428530_447927 (.out1(out_ui_extract_bit_expr_FU_113_i0_fu_conv_layer_428530_447927),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_5));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_conv_layer_428530_447931 (.out1(out_ui_extract_bit_expr_FU_114_i0_fu_conv_layer_428530_447931),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_6));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_conv_layer_428530_447935 (.out1(out_ui_extract_bit_expr_FU_117_i0_fu_conv_layer_428530_447935),
    .in1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in2(out_const_9));
  register_SE #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_31_i0_fu_conv_layer_428530_446700),
    .wenable(wrenable_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_148_reg_1_0_0_0),
    .wenable(wrenable_reg_1));
  register_SE #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_10 (.out1(out_reg_10_reg_10),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_34_i0_fu_conv_layer_428530_447022),
    .wenable(wrenable_reg_10));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_11 (.out1(out_reg_11_reg_11),
    .clock(clock),
    .reset(reset),
    .in1(out_addr_expr_FU_35_i0_fu_conv_layer_428530_447098),
    .wenable(wrenable_reg_11));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_12 (.out1(out_reg_12_reg_12),
    .clock(clock),
    .reset(reset),
    .in1(out_addr_expr_FU_36_i0_fu_conv_layer_428530_447120),
    .wenable(wrenable_reg_12));
  register_SE #(.BITSIZE_in1(4),
    .BITSIZE_out1(4)) reg_13 (.out1(out_reg_13_reg_13),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_rshift_expr_FU_8_0_8_169_i2_fu_conv_layer_428530_447463),
    .wenable(wrenable_reg_13));
  register_SE #(.BITSIZE_in1(7),
    .BITSIZE_out1(7)) reg_14 (.out1(out_reg_14_reg_14),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_rshift_expr_FU_16_0_16_164_i0_fu_conv_layer_428530_447495),
    .wenable(wrenable_reg_14));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_15 (.out1(out_reg_15_reg_15),
    .clock(clock),
    .reset(reset),
    .in1(out_IIdata_converter_FU_20_i0_fu_conv_layer_428530_446576),
    .wenable(wrenable_reg_15));
  register_SE #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) reg_16 (.out1(out_reg_16_reg_16),
    .clock(clock),
    .reset(reset),
    .in1(out_IIdata_converter_FU_18_i0_fu_conv_layer_428530_446438),
    .wenable(wrenable_reg_16));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_17 (.out1(out_reg_17_reg_17),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i2_fu_conv_layer_428530_446207),
    .wenable(wrenable_reg_17));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_18 (.out1(out_reg_18_reg_18),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_157_reg_18_0_0_0),
    .wenable(wrenable_reg_18));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_19 (.out1(out_reg_19_reg_19),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_158_reg_19_0_0_0),
    .wenable(wrenable_reg_19));
  register_SE #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_8_8_8_153_i0_fu_conv_layer_428530_446263),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_20 (.out1(out_reg_20_reg_20),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_160_reg_20_0_0_0),
    .wenable(wrenable_reg_20));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_21 (.out1(out_reg_21_reg_21),
    .clock(clock),
    .reset(reset),
    .in1(out_reg_19_reg_19),
    .wenable(wrenable_reg_21));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_22 (.out1(out_reg_22_reg_22),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i4_fu_conv_layer_428530_446260),
    .wenable(wrenable_reg_22));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_23 (.out1(out_reg_23_reg_23),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_163_reg_23_0_0_0),
    .wenable(wrenable_reg_23));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_24 (.out1(out_reg_24_reg_24),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_32_32_150_i0_ui_lshift_expr_FU_32_32_32_150_i0),
    .wenable(wrenable_reg_24));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_25 (.out1(out_reg_25_reg_25),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i0_fu_conv_layer_428530_446085),
    .wenable(wrenable_reg_25));
  register_SE #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) reg_26 (.out1(out_reg_26_reg_26),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_166_reg_26_0_0_0),
    .wenable(wrenable_reg_26));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_27 (.out1(out_reg_27_reg_27),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_167_reg_27_0_0_0),
    .wenable(wrenable_reg_27));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_28 (.out1(out_reg_28_reg_28),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_0_32_156_i0_fu_conv_layer_428530_446070),
    .wenable(wrenable_reg_28));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_29 (.out1(out_reg_29_reg_29),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_32_32_150_i0_ui_lshift_expr_FU_32_32_32_150_i0),
    .wenable(wrenable_reg_29));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_30_i0_fu_conv_layer_428530_446266),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_30 (.out1(out_reg_30_reg_30),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_171_reg_30_0_0_0),
    .wenable(wrenable_reg_30));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_31 (.out1(out_reg_31_reg_31),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_172_reg_31_0_0_0),
    .wenable(wrenable_reg_31));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_32 (.out1(out_reg_32_reg_32),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_135_i0_fu_conv_layer_428530_446251),
    .wenable(wrenable_reg_32));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_33 (.out1(out_reg_33_reg_33),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_174_reg_33_0_0_0),
    .wenable(wrenable_reg_33));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_34 (.out1(out_reg_34_reg_34),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_0_32_156_i1_fu_conv_layer_428530_446771),
    .wenable(wrenable_reg_34));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_35 (.out1(out_reg_35_reg_35),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_176_reg_35_0_0_1),
    .wenable(wrenable_reg_35));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_36 (.out1(out_reg_36_reg_36),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_177_reg_36_0_0_0),
    .wenable(wrenable_reg_36));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_37 (.out1(out_reg_37_reg_37),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i5_fu_conv_layer_428530_446286),
    .wenable(wrenable_reg_37));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_38 (.out1(out_reg_38_reg_38),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_179_reg_38_0_0_0),
    .wenable(wrenable_reg_38));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_39 (.out1(out_reg_39_reg_39),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i9_fu_conv_layer_428530_446360),
    .wenable(wrenable_reg_39));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_181_reg_4_0_0_0),
    .wenable(wrenable_reg_4));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_40 (.out1(out_reg_40_reg_40),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_0_32_159_i2_fu_conv_layer_428530_446429),
    .wenable(wrenable_reg_40));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_41 (.out1(out_reg_41_reg_41),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_183_reg_41_0_0_0),
    .wenable(wrenable_reg_41));
  register_SE #(.BITSIZE_in1(7),
    .BITSIZE_out1(7)) reg_42 (.out1(out_reg_42_reg_42),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_49_i0_fu_conv_layer_428530_447004),
    .wenable(wrenable_reg_42));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_43 (.out1(out_reg_43_reg_43),
    .clock(clock),
    .reset(reset),
    .in1(out_gt_expr_FU_32_0_32_121_i0_fu_conv_layer_428530_447016),
    .wenable(wrenable_reg_43));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_44 (.out1(out_reg_44_reg_44),
    .clock(clock),
    .reset(reset),
    .in1(out_lt_expr_FU_32_32_32_122_i0_fu_conv_layer_428530_447024),
    .wenable(wrenable_reg_44));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_45 (.out1(out_reg_45_reg_45),
    .clock(clock),
    .reset(reset),
    .in1(out_gt_expr_FU_32_0_32_121_i1_fu_conv_layer_428530_447030),
    .wenable(wrenable_reg_45));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_46 (.out1(out_reg_46_reg_46),
    .clock(clock),
    .reset(reset),
    .in1(out_lt_expr_FU_32_32_32_122_i1_fu_conv_layer_428530_447038),
    .wenable(wrenable_reg_46));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_47 (.out1(out_reg_47_reg_47),
    .clock(clock),
    .reset(reset),
    .in1(out_gt_expr_FU_32_0_32_121_i2_fu_conv_layer_428530_447044),
    .wenable(wrenable_reg_47));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_48 (.out1(out_reg_48_reg_48),
    .clock(clock),
    .reset(reset),
    .in1(out_lt_expr_FU_32_32_32_122_i2_fu_conv_layer_428530_447052),
    .wenable(wrenable_reg_48));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_49 (.out1(out_reg_49_reg_49),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_191_reg_49_0_0_0),
    .wenable(wrenable_reg_49));
  register_SE #(.BITSIZE_in1(7),
    .BITSIZE_out1(7)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_rshift_expr_FU_8_8_8_171_i0_fu_conv_layer_428530_446738),
    .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_50 (.out1(out_reg_50_reg_50),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_193_reg_50_0_0_0),
    .wenable(wrenable_reg_50));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_51 (.out1(out_reg_51_reg_51),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_194_reg_51_0_0_0),
    .wenable(wrenable_reg_51));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_52 (.out1(out_reg_52_reg_52),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_195_reg_52_0_0_0),
    .wenable(wrenable_reg_52));
  register_SE #(.BITSIZE_in1(26),
    .BITSIZE_out1(26)) reg_53 (.out1(out_reg_53_reg_53),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_rshift_expr_FU_32_0_32_166_i1_fu_conv_layer_428530_447507),
    .wenable(wrenable_reg_53));
  register_SE #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_54 (.out1(out_reg_54_reg_54),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_8_0_8_152_i0_fu_conv_layer_428530_447546),
    .wenable(wrenable_reg_54));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_55 (.out1(out_reg_55_reg_55),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_134_i0_fu_conv_layer_428530_446244),
    .wenable(wrenable_reg_55));
  register_SE #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_56 (.out1(out_reg_56_reg_56),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_8_0_8_152_i1_fu_conv_layer_428530_447576),
    .wenable(wrenable_reg_56));
  register_SE #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_57 (.out1(out_reg_57_reg_57),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_8_0_8_152_i2_fu_conv_layer_428530_447619),
    .wenable(wrenable_reg_57));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_58 (.out1(out_reg_58_reg_58),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_85_i0_fu_conv_layer_428530_446848),
    .wenable(wrenable_reg_58));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_59 (.out1(out_reg_59_reg_59),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_74_i0_fu_conv_layer_428530_446853),
    .wenable(wrenable_reg_59));
  register_SE #(.BITSIZE_in1(2),
    .BITSIZE_out1(2)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_cond_expr_FU_8_8_8_8_140_i0_fu_conv_layer_428530_446758),
    .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_60 (.out1(out_reg_60_reg_60),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_78_i0_fu_conv_layer_428530_446864),
    .wenable(wrenable_reg_60));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_61 (.out1(out_reg_61_reg_61),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_82_i0_fu_conv_layer_428530_446875),
    .wenable(wrenable_reg_61));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_62 (.out1(out_reg_62_reg_62),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_0_32_146_i1_fu_conv_layer_428530_447091),
    .wenable(wrenable_reg_62));
  register_STD #(.BITSIZE_in1(30),
    .BITSIZE_out1(30)) reg_63 (.out1(out_reg_63_reg_63),
    .clock(clock),
    .reset(reset),
    .in1(out_IUdata_converter_FU_80_i0_fu_conv_layer_428530_447127),
    .wenable(wrenable_reg_63));
  register_STD #(.BITSIZE_in1(30),
    .BITSIZE_out1(30)) reg_64 (.out1(out_reg_64_reg_64),
    .clock(clock),
    .reset(reset),
    .in1(out_IUdata_converter_FU_84_i0_fu_conv_layer_428530_447167),
    .wenable(wrenable_reg_64));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_65 (.out1(out_reg_65_reg_65),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i1_fu_conv_layer_428530_446183),
    .wenable(wrenable_reg_65));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_66 (.out1(out_reg_66_reg_66),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i3_fu_conv_layer_428530_446240),
    .wenable(wrenable_reg_66));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_67 (.out1(out_reg_67_reg_67),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i8_fu_conv_layer_428530_446357),
    .wenable(wrenable_reg_67));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_68 (.out1(out_reg_68_reg_68),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_161_i12_fu_conv_layer_428530_446426),
    .wenable(wrenable_reg_68));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_69 (.out1(out_reg_69_reg_69),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_0_32_146_i2_fu_conv_layer_428530_447132),
    .wenable(wrenable_reg_69));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_addr_expr_FU_32_i0_fu_conv_layer_428530_446945),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_70 (.out1(out_reg_70_reg_70),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_0_32_146_i3_fu_conv_layer_428530_447172),
    .wenable(wrenable_reg_70));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_71 (.out1(out_reg_71_reg_71),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i2_fu_conv_layer_428530_446235),
    .wenable(wrenable_reg_71));
  register_SE #(.BITSIZE_in1(3),
    .BITSIZE_out1(3)) reg_72 (.out1(out_reg_72_reg_72),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_xor_expr_FU_8_0_8_138_i0_fu_conv_layer_428530_446294),
    .wenable(wrenable_reg_72));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_73 (.out1(out_reg_73_reg_73),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_97_i0_fu_conv_layer_428530_447117),
    .wenable(wrenable_reg_73));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_74 (.out1(out_reg_74_reg_74),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_219_reg_74_0_0_1),
    .wenable(wrenable_reg_74));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_75 (.out1(out_reg_75_reg_75),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i3_fu_conv_layer_428530_446322),
    .wenable(wrenable_reg_75));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_76 (.out1(out_reg_76_reg_76),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i4_fu_conv_layer_428530_446352),
    .wenable(wrenable_reg_76));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_77 (.out1(out_reg_77_reg_77),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i5_fu_conv_layer_428530_446391),
    .wenable(wrenable_reg_77));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_78 (.out1(out_reg_78_reg_78),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_163_i6_fu_conv_layer_428530_446421),
    .wenable(wrenable_reg_78));
  register_SE #(.BITSIZE_in1(3),
    .BITSIZE_out1(3)) reg_79 (.out1(out_reg_79_reg_79),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_xor_expr_FU_8_0_8_138_i1_fu_conv_layer_428530_446363),
    .wenable(wrenable_reg_79));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_addr_expr_FU_33_i0_fu_conv_layer_428530_446952),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_80 (.out1(out_reg_80_reg_80),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_108_i0_fu_conv_layer_428530_447157),
    .wenable(wrenable_reg_80));
  register_SE #(.BITSIZE_in1(3),
    .BITSIZE_out1(3)) reg_81 (.out1(out_reg_81_reg_81),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_xor_expr_FU_8_0_8_138_i2_fu_conv_layer_428530_446431),
    .wenable(wrenable_reg_81));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_82 (.out1(out_reg_82_reg_82),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_118_i0_fu_conv_layer_428530_447191),
    .wenable(wrenable_reg_82));
  register_STD #(.BITSIZE_in1(49),
    .BITSIZE_out1(49)) reg_83 (.out1(out_reg_83_reg_83),
    .clock(clock),
    .reset(reset),
    .in1(out_min_expr_FU_64_0_64_125_i0_fu_conv_layer_428530_446125),
    .wenable(wrenable_reg_83));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_84 (.out1(out_reg_84_reg_84),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_56_i0_fu_conv_layer_428530_446787),
    .wenable(wrenable_reg_84));
  register_SE #(.BITSIZE_in1(9),
    .BITSIZE_out1(9)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_137_i0_fu_conv_layer_428530_446984),
    .wenable(wrenable_reg_9));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) ui_lshift_expr_FU_32_32_32_150_i0 (.out1(out_ui_lshift_expr_FU_32_32_32_150_i0_ui_lshift_expr_FU_32_32_32_150_i0),
    .in1(out_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0),
    .in2(out_reg_3_reg_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5),
    .BITSIZE_out1(4),
    .PRECISION(32)) ui_rshift_expr_FU_32_32_32_168_i0 (.out1(out_ui_rshift_expr_FU_32_32_32_168_i0_ui_rshift_expr_FU_32_32_32_168_i0),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_440988_0),
    .in2(out_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1));
  // io-signal post fix
  assign OUT_CONDITION_conv_layer_428530_446745 = out_read_cond_FU_22_i0_fu_conv_layer_428530_446745;
  assign OUT_CONDITION_conv_layer_428530_446751 = out_read_cond_FU_25_i0_fu_conv_layer_428530_446751;
  assign OUT_CONDITION_conv_layer_428530_446755 = out_read_cond_FU_28_i0_fu_conv_layer_428530_446755;
  assign OUT_CONDITION_conv_layer_428530_446783 = out_read_cond_FU_43_i0_fu_conv_layer_428530_446783;
  assign OUT_CONDITION_conv_layer_428530_446788 = out_read_cond_FU_58_i0_fu_conv_layer_428530_446788;
  assign OUT_CONDITION_conv_layer_428530_446825 = out_read_cond_FU_65_i0_fu_conv_layer_428530_446825;
  assign OUT_CONDITION_conv_layer_428530_446832 = out_read_cond_FU_86_i0_fu_conv_layer_428530_446832;
  assign OUT_CONDITION_conv_layer_428530_446849 = out_read_cond_FU_88_i0_fu_conv_layer_428530_446849;
  assign OUT_CONDITION_conv_layer_428530_446854 = out_read_cond_FU_89_i0_fu_conv_layer_428530_446854;
  assign OUT_CONDITION_conv_layer_428530_446860 = out_read_cond_FU_98_i0_fu_conv_layer_428530_446860;
  assign OUT_CONDITION_conv_layer_428530_446865 = out_read_cond_FU_99_i0_fu_conv_layer_428530_446865;
  assign OUT_CONDITION_conv_layer_428530_446871 = out_read_cond_FU_109_i0_fu_conv_layer_428530_446871;
  assign OUT_CONDITION_conv_layer_428530_446876 = out_read_cond_FU_110_i0_fu_conv_layer_428530_446876;
  assign OUT_CONDITION_conv_layer_428530_446882 = out_read_cond_FU_119_i0_fu_conv_layer_428530_446882;

endmodule

// FSM based controller description for conv_layer
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_conv_layer(done_port,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE,
  selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0,
  selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1,
  selector_MUX_148_reg_1_0_0_0,
  selector_MUX_157_reg_18_0_0_0,
  selector_MUX_158_reg_19_0_0_0,
  selector_MUX_160_reg_20_0_0_0,
  selector_MUX_163_reg_23_0_0_0,
  selector_MUX_166_reg_26_0_0_0,
  selector_MUX_167_reg_27_0_0_0,
  selector_MUX_171_reg_30_0_0_0,
  selector_MUX_172_reg_31_0_0_0,
  selector_MUX_174_reg_33_0_0_0,
  selector_MUX_176_reg_35_0_0_0,
  selector_MUX_176_reg_35_0_0_1,
  selector_MUX_177_reg_36_0_0_0,
  selector_MUX_179_reg_38_0_0_0,
  selector_MUX_181_reg_4_0_0_0,
  selector_MUX_183_reg_41_0_0_0,
  selector_MUX_191_reg_49_0_0_0,
  selector_MUX_193_reg_50_0_0_0,
  selector_MUX_194_reg_51_0_0_0,
  selector_MUX_195_reg_52_0_0_0,
  selector_MUX_219_reg_74_0_0_0,
  selector_MUX_219_reg_74_0_0_1,
  selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0,
  selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1,
  selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0,
  selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0,
  selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1,
  fuselector_SPROXY_CTRLN_3_i0_LOAD,
  fuselector_SPROXY_CTRLN_3_i0_STORE,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_10,
  wrenable_reg_11,
  wrenable_reg_12,
  wrenable_reg_13,
  wrenable_reg_14,
  wrenable_reg_15,
  wrenable_reg_16,
  wrenable_reg_17,
  wrenable_reg_18,
  wrenable_reg_19,
  wrenable_reg_2,
  wrenable_reg_20,
  wrenable_reg_21,
  wrenable_reg_22,
  wrenable_reg_23,
  wrenable_reg_24,
  wrenable_reg_25,
  wrenable_reg_26,
  wrenable_reg_27,
  wrenable_reg_28,
  wrenable_reg_29,
  wrenable_reg_3,
  wrenable_reg_30,
  wrenable_reg_31,
  wrenable_reg_32,
  wrenable_reg_33,
  wrenable_reg_34,
  wrenable_reg_35,
  wrenable_reg_36,
  wrenable_reg_37,
  wrenable_reg_38,
  wrenable_reg_39,
  wrenable_reg_4,
  wrenable_reg_40,
  wrenable_reg_41,
  wrenable_reg_42,
  wrenable_reg_43,
  wrenable_reg_44,
  wrenable_reg_45,
  wrenable_reg_46,
  wrenable_reg_47,
  wrenable_reg_48,
  wrenable_reg_49,
  wrenable_reg_5,
  wrenable_reg_50,
  wrenable_reg_51,
  wrenable_reg_52,
  wrenable_reg_53,
  wrenable_reg_54,
  wrenable_reg_55,
  wrenable_reg_56,
  wrenable_reg_57,
  wrenable_reg_58,
  wrenable_reg_59,
  wrenable_reg_6,
  wrenable_reg_60,
  wrenable_reg_61,
  wrenable_reg_62,
  wrenable_reg_63,
  wrenable_reg_64,
  wrenable_reg_65,
  wrenable_reg_66,
  wrenable_reg_67,
  wrenable_reg_68,
  wrenable_reg_69,
  wrenable_reg_7,
  wrenable_reg_70,
  wrenable_reg_71,
  wrenable_reg_72,
  wrenable_reg_73,
  wrenable_reg_74,
  wrenable_reg_75,
  wrenable_reg_76,
  wrenable_reg_77,
  wrenable_reg_78,
  wrenable_reg_79,
  wrenable_reg_8,
  wrenable_reg_80,
  wrenable_reg_81,
  wrenable_reg_82,
  wrenable_reg_83,
  wrenable_reg_84,
  wrenable_reg_9,
  OUT_CONDITION_conv_layer_428530_446745,
  OUT_CONDITION_conv_layer_428530_446751,
  OUT_CONDITION_conv_layer_428530_446755,
  OUT_CONDITION_conv_layer_428530_446783,
  OUT_CONDITION_conv_layer_428530_446788,
  OUT_CONDITION_conv_layer_428530_446825,
  OUT_CONDITION_conv_layer_428530_446832,
  OUT_CONDITION_conv_layer_428530_446849,
  OUT_CONDITION_conv_layer_428530_446854,
  OUT_CONDITION_conv_layer_428530_446860,
  OUT_CONDITION_conv_layer_428530_446865,
  OUT_CONDITION_conv_layer_428530_446871,
  OUT_CONDITION_conv_layer_428530_446876,
  OUT_CONDITION_conv_layer_428530_446882,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_conv_layer_428530_446745;
  input OUT_CONDITION_conv_layer_428530_446751;
  input OUT_CONDITION_conv_layer_428530_446755;
  input OUT_CONDITION_conv_layer_428530_446783;
  input OUT_CONDITION_conv_layer_428530_446788;
  input OUT_CONDITION_conv_layer_428530_446825;
  input OUT_CONDITION_conv_layer_428530_446832;
  input OUT_CONDITION_conv_layer_428530_446849;
  input OUT_CONDITION_conv_layer_428530_446854;
  input OUT_CONDITION_conv_layer_428530_446860;
  input OUT_CONDITION_conv_layer_428530_446865;
  input OUT_CONDITION_conv_layer_428530_446871;
  input OUT_CONDITION_conv_layer_428530_446876;
  input OUT_CONDITION_conv_layer_428530_446882;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  output selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  output selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  output selector_MUX_148_reg_1_0_0_0;
  output selector_MUX_157_reg_18_0_0_0;
  output selector_MUX_158_reg_19_0_0_0;
  output selector_MUX_160_reg_20_0_0_0;
  output selector_MUX_163_reg_23_0_0_0;
  output selector_MUX_166_reg_26_0_0_0;
  output selector_MUX_167_reg_27_0_0_0;
  output selector_MUX_171_reg_30_0_0_0;
  output selector_MUX_172_reg_31_0_0_0;
  output selector_MUX_174_reg_33_0_0_0;
  output selector_MUX_176_reg_35_0_0_0;
  output selector_MUX_176_reg_35_0_0_1;
  output selector_MUX_177_reg_36_0_0_0;
  output selector_MUX_179_reg_38_0_0_0;
  output selector_MUX_181_reg_4_0_0_0;
  output selector_MUX_183_reg_41_0_0_0;
  output selector_MUX_191_reg_49_0_0_0;
  output selector_MUX_193_reg_50_0_0_0;
  output selector_MUX_194_reg_51_0_0_0;
  output selector_MUX_195_reg_52_0_0_0;
  output selector_MUX_219_reg_74_0_0_0;
  output selector_MUX_219_reg_74_0_0_1;
  output selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0;
  output selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1;
  output selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0;
  output selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0;
  output selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1;
  output fuselector_SPROXY_CTRLN_3_i0_LOAD;
  output fuselector_SPROXY_CTRLN_3_i0_STORE;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_10;
  output wrenable_reg_11;
  output wrenable_reg_12;
  output wrenable_reg_13;
  output wrenable_reg_14;
  output wrenable_reg_15;
  output wrenable_reg_16;
  output wrenable_reg_17;
  output wrenable_reg_18;
  output wrenable_reg_19;
  output wrenable_reg_2;
  output wrenable_reg_20;
  output wrenable_reg_21;
  output wrenable_reg_22;
  output wrenable_reg_23;
  output wrenable_reg_24;
  output wrenable_reg_25;
  output wrenable_reg_26;
  output wrenable_reg_27;
  output wrenable_reg_28;
  output wrenable_reg_29;
  output wrenable_reg_3;
  output wrenable_reg_30;
  output wrenable_reg_31;
  output wrenable_reg_32;
  output wrenable_reg_33;
  output wrenable_reg_34;
  output wrenable_reg_35;
  output wrenable_reg_36;
  output wrenable_reg_37;
  output wrenable_reg_38;
  output wrenable_reg_39;
  output wrenable_reg_4;
  output wrenable_reg_40;
  output wrenable_reg_41;
  output wrenable_reg_42;
  output wrenable_reg_43;
  output wrenable_reg_44;
  output wrenable_reg_45;
  output wrenable_reg_46;
  output wrenable_reg_47;
  output wrenable_reg_48;
  output wrenable_reg_49;
  output wrenable_reg_5;
  output wrenable_reg_50;
  output wrenable_reg_51;
  output wrenable_reg_52;
  output wrenable_reg_53;
  output wrenable_reg_54;
  output wrenable_reg_55;
  output wrenable_reg_56;
  output wrenable_reg_57;
  output wrenable_reg_58;
  output wrenable_reg_59;
  output wrenable_reg_6;
  output wrenable_reg_60;
  output wrenable_reg_61;
  output wrenable_reg_62;
  output wrenable_reg_63;
  output wrenable_reg_64;
  output wrenable_reg_65;
  output wrenable_reg_66;
  output wrenable_reg_67;
  output wrenable_reg_68;
  output wrenable_reg_69;
  output wrenable_reg_7;
  output wrenable_reg_70;
  output wrenable_reg_71;
  output wrenable_reg_72;
  output wrenable_reg_73;
  output wrenable_reg_74;
  output wrenable_reg_75;
  output wrenable_reg_76;
  output wrenable_reg_77;
  output wrenable_reg_78;
  output wrenable_reg_79;
  output wrenable_reg_8;
  output wrenable_reg_80;
  output wrenable_reg_81;
  output wrenable_reg_82;
  output wrenable_reg_83;
  output wrenable_reg_84;
  output wrenable_reg_9;
  parameter [32:0] S_6 = 33'b000000000000000000000000001000000,
    S_7 = 33'b000000000000000000000000010000000,
    S_2 = 33'b000000000000000000000000000000100,
    S_1 = 33'b000000000000000000000000000000010,
    S_0 = 33'b000000000000000000000000000000001,
    S_9 = 33'b000000000000000000000001000000000,
    S_11 = 33'b000000000000000000000100000000000,
    S_14 = 33'b000000000000000000100000000000000,
    S_16 = 33'b000000000000000010000000000000000,
    S_18 = 33'b000000000000001000000000000000000,
    S_19 = 33'b000000000000010000000000000000000,
    S_20 = 33'b000000000000100000000000000000000,
    S_22 = 33'b000000000010000000000000000000000,
    S_23 = 33'b000000000100000000000000000000000,
    S_21 = 33'b000000000001000000000000000000000,
    S_24 = 33'b000000001000000000000000000000000,
    S_25 = 33'b000000010000000000000000000000000,
    S_27 = 33'b000001000000000000000000000000000,
    S_28 = 33'b000010000000000000000000000000000,
    S_26 = 33'b000000100000000000000000000000000,
    S_29 = 33'b000100000000000000000000000000000,
    S_30 = 33'b001000000000000000000000000000000,
    S_31 = 33'b010000000000000000000000000000000,
    S_32 = 33'b100000000000000000000000000000000,
    S_17 = 33'b000000000000000100000000000000000,
    S_15 = 33'b000000000000000001000000000000000,
    S_12 = 33'b000000000000000000001000000000000,
    S_13 = 33'b000000000000000000010000000000000,
    S_10 = 33'b000000000000000000000010000000000,
    S_5 = 33'b000000000000000000000000000100000,
    S_4 = 33'b000000000000000000000000000010000,
    S_3 = 33'b000000000000000000000000000001000,
    S_8 = 33'b000000000000000000000000100000000;
  reg [32:0] _present_state=S_6, _next_state;
  reg done_port;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  reg selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  reg selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  reg selector_MUX_148_reg_1_0_0_0;
  reg selector_MUX_157_reg_18_0_0_0;
  reg selector_MUX_158_reg_19_0_0_0;
  reg selector_MUX_160_reg_20_0_0_0;
  reg selector_MUX_163_reg_23_0_0_0;
  reg selector_MUX_166_reg_26_0_0_0;
  reg selector_MUX_167_reg_27_0_0_0;
  reg selector_MUX_171_reg_30_0_0_0;
  reg selector_MUX_172_reg_31_0_0_0;
  reg selector_MUX_174_reg_33_0_0_0;
  reg selector_MUX_176_reg_35_0_0_0;
  reg selector_MUX_176_reg_35_0_0_1;
  reg selector_MUX_177_reg_36_0_0_0;
  reg selector_MUX_179_reg_38_0_0_0;
  reg selector_MUX_181_reg_4_0_0_0;
  reg selector_MUX_183_reg_41_0_0_0;
  reg selector_MUX_191_reg_49_0_0_0;
  reg selector_MUX_193_reg_50_0_0_0;
  reg selector_MUX_194_reg_51_0_0_0;
  reg selector_MUX_195_reg_52_0_0_0;
  reg selector_MUX_219_reg_74_0_0_0;
  reg selector_MUX_219_reg_74_0_0_1;
  reg selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0;
  reg selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1;
  reg selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0;
  reg selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0;
  reg selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1;
  reg fuselector_SPROXY_CTRLN_3_i0_LOAD;
  reg fuselector_SPROXY_CTRLN_3_i0_STORE;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_10;
  reg wrenable_reg_11;
  reg wrenable_reg_12;
  reg wrenable_reg_13;
  reg wrenable_reg_14;
  reg wrenable_reg_15;
  reg wrenable_reg_16;
  reg wrenable_reg_17;
  reg wrenable_reg_18;
  reg wrenable_reg_19;
  reg wrenable_reg_2;
  reg wrenable_reg_20;
  reg wrenable_reg_21;
  reg wrenable_reg_22;
  reg wrenable_reg_23;
  reg wrenable_reg_24;
  reg wrenable_reg_25;
  reg wrenable_reg_26;
  reg wrenable_reg_27;
  reg wrenable_reg_28;
  reg wrenable_reg_29;
  reg wrenable_reg_3;
  reg wrenable_reg_30;
  reg wrenable_reg_31;
  reg wrenable_reg_32;
  reg wrenable_reg_33;
  reg wrenable_reg_34;
  reg wrenable_reg_35;
  reg wrenable_reg_36;
  reg wrenable_reg_37;
  reg wrenable_reg_38;
  reg wrenable_reg_39;
  reg wrenable_reg_4;
  reg wrenable_reg_40;
  reg wrenable_reg_41;
  reg wrenable_reg_42;
  reg wrenable_reg_43;
  reg wrenable_reg_44;
  reg wrenable_reg_45;
  reg wrenable_reg_46;
  reg wrenable_reg_47;
  reg wrenable_reg_48;
  reg wrenable_reg_49;
  reg wrenable_reg_5;
  reg wrenable_reg_50;
  reg wrenable_reg_51;
  reg wrenable_reg_52;
  reg wrenable_reg_53;
  reg wrenable_reg_54;
  reg wrenable_reg_55;
  reg wrenable_reg_56;
  reg wrenable_reg_57;
  reg wrenable_reg_58;
  reg wrenable_reg_59;
  reg wrenable_reg_6;
  reg wrenable_reg_60;
  reg wrenable_reg_61;
  reg wrenable_reg_62;
  reg wrenable_reg_63;
  reg wrenable_reg_64;
  reg wrenable_reg_65;
  reg wrenable_reg_66;
  reg wrenable_reg_67;
  reg wrenable_reg_68;
  reg wrenable_reg_69;
  reg wrenable_reg_7;
  reg wrenable_reg_70;
  reg wrenable_reg_71;
  reg wrenable_reg_72;
  reg wrenable_reg_73;
  reg wrenable_reg_74;
  reg wrenable_reg_75;
  reg wrenable_reg_76;
  reg wrenable_reg_77;
  reg wrenable_reg_78;
  reg wrenable_reg_79;
  reg wrenable_reg_8;
  reg wrenable_reg_80;
  reg wrenable_reg_81;
  reg wrenable_reg_82;
  reg wrenable_reg_83;
  reg wrenable_reg_84;
  reg wrenable_reg_9;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_6;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE = 1'b0;
    selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0 = 1'b0;
    selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1 = 1'b0;
    selector_MUX_148_reg_1_0_0_0 = 1'b0;
    selector_MUX_157_reg_18_0_0_0 = 1'b0;
    selector_MUX_158_reg_19_0_0_0 = 1'b0;
    selector_MUX_160_reg_20_0_0_0 = 1'b0;
    selector_MUX_163_reg_23_0_0_0 = 1'b0;
    selector_MUX_166_reg_26_0_0_0 = 1'b0;
    selector_MUX_167_reg_27_0_0_0 = 1'b0;
    selector_MUX_171_reg_30_0_0_0 = 1'b0;
    selector_MUX_172_reg_31_0_0_0 = 1'b0;
    selector_MUX_174_reg_33_0_0_0 = 1'b0;
    selector_MUX_176_reg_35_0_0_0 = 1'b0;
    selector_MUX_176_reg_35_0_0_1 = 1'b0;
    selector_MUX_177_reg_36_0_0_0 = 1'b0;
    selector_MUX_179_reg_38_0_0_0 = 1'b0;
    selector_MUX_181_reg_4_0_0_0 = 1'b0;
    selector_MUX_183_reg_41_0_0_0 = 1'b0;
    selector_MUX_191_reg_49_0_0_0 = 1'b0;
    selector_MUX_193_reg_50_0_0_0 = 1'b0;
    selector_MUX_194_reg_51_0_0_0 = 1'b0;
    selector_MUX_195_reg_52_0_0_0 = 1'b0;
    selector_MUX_219_reg_74_0_0_0 = 1'b0;
    selector_MUX_219_reg_74_0_0_1 = 1'b0;
    selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0 = 1'b0;
    selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1 = 1'b0;
    selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0 = 1'b0;
    selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0 = 1'b0;
    selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1 = 1'b0;
    fuselector_SPROXY_CTRLN_3_i0_LOAD = 1'b0;
    fuselector_SPROXY_CTRLN_3_i0_STORE = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_10 = 1'b0;
    wrenable_reg_11 = 1'b0;
    wrenable_reg_12 = 1'b0;
    wrenable_reg_13 = 1'b0;
    wrenable_reg_14 = 1'b0;
    wrenable_reg_15 = 1'b0;
    wrenable_reg_16 = 1'b0;
    wrenable_reg_17 = 1'b0;
    wrenable_reg_18 = 1'b0;
    wrenable_reg_19 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_20 = 1'b0;
    wrenable_reg_21 = 1'b0;
    wrenable_reg_22 = 1'b0;
    wrenable_reg_23 = 1'b0;
    wrenable_reg_24 = 1'b0;
    wrenable_reg_25 = 1'b0;
    wrenable_reg_26 = 1'b0;
    wrenable_reg_27 = 1'b0;
    wrenable_reg_28 = 1'b0;
    wrenable_reg_29 = 1'b0;
    wrenable_reg_3 = 1'b0;
    wrenable_reg_30 = 1'b0;
    wrenable_reg_31 = 1'b0;
    wrenable_reg_32 = 1'b0;
    wrenable_reg_33 = 1'b0;
    wrenable_reg_34 = 1'b0;
    wrenable_reg_35 = 1'b0;
    wrenable_reg_36 = 1'b0;
    wrenable_reg_37 = 1'b0;
    wrenable_reg_38 = 1'b0;
    wrenable_reg_39 = 1'b0;
    wrenable_reg_4 = 1'b0;
    wrenable_reg_40 = 1'b0;
    wrenable_reg_41 = 1'b0;
    wrenable_reg_42 = 1'b0;
    wrenable_reg_43 = 1'b0;
    wrenable_reg_44 = 1'b0;
    wrenable_reg_45 = 1'b0;
    wrenable_reg_46 = 1'b0;
    wrenable_reg_47 = 1'b0;
    wrenable_reg_48 = 1'b0;
    wrenable_reg_49 = 1'b0;
    wrenable_reg_5 = 1'b0;
    wrenable_reg_50 = 1'b0;
    wrenable_reg_51 = 1'b0;
    wrenable_reg_52 = 1'b0;
    wrenable_reg_53 = 1'b0;
    wrenable_reg_54 = 1'b0;
    wrenable_reg_55 = 1'b0;
    wrenable_reg_56 = 1'b0;
    wrenable_reg_57 = 1'b0;
    wrenable_reg_58 = 1'b0;
    wrenable_reg_59 = 1'b0;
    wrenable_reg_6 = 1'b0;
    wrenable_reg_60 = 1'b0;
    wrenable_reg_61 = 1'b0;
    wrenable_reg_62 = 1'b0;
    wrenable_reg_63 = 1'b0;
    wrenable_reg_64 = 1'b0;
    wrenable_reg_65 = 1'b0;
    wrenable_reg_66 = 1'b0;
    wrenable_reg_67 = 1'b0;
    wrenable_reg_68 = 1'b0;
    wrenable_reg_69 = 1'b0;
    wrenable_reg_7 = 1'b0;
    wrenable_reg_70 = 1'b0;
    wrenable_reg_71 = 1'b0;
    wrenable_reg_72 = 1'b0;
    wrenable_reg_73 = 1'b0;
    wrenable_reg_74 = 1'b0;
    wrenable_reg_75 = 1'b0;
    wrenable_reg_76 = 1'b0;
    wrenable_reg_77 = 1'b0;
    wrenable_reg_78 = 1'b0;
    wrenable_reg_79 = 1'b0;
    wrenable_reg_8 = 1'b0;
    wrenable_reg_80 = 1'b0;
    wrenable_reg_81 = 1'b0;
    wrenable_reg_82 = 1'b0;
    wrenable_reg_83 = 1'b0;
    wrenable_reg_84 = 1'b0;
    wrenable_reg_9 = 1'b0;
    case (_present_state)
      S_6 :
        if(start_port == 1'b1)
        begin
          _next_state = S_7;
        end
        else
        begin
          _next_state = S_6;
        end
      S_7 :
        begin
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_10 = 1'b1;
          wrenable_reg_11 = 1'b1;
          wrenable_reg_12 = 1'b1;
          wrenable_reg_13 = 1'b1;
          wrenable_reg_14 = 1'b1;
          wrenable_reg_19 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          _next_state = S_2;
        end
      S_2 :
        begin
          fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD = 1'b1;
          selector_MUX_181_reg_4_0_0_0 = 1'b1;
          wrenable_reg_15 = 1'b1;
          wrenable_reg_16 = 1'b1;
          wrenable_reg_17 = 1'b1;
          wrenable_reg_18 = 1'b1;
          wrenable_reg_20 = 1'b1;
          wrenable_reg_4 = 1'b1;
          _next_state = S_1;
        end
      S_1 :
        begin
          selector_MUX_160_reg_20_0_0_0 = 1'b1;
          wrenable_reg_20 = 1'b1;
          wrenable_reg_21 = 1'b1;
          wrenable_reg_22 = 1'b1;
          wrenable_reg_23 = 1'b1;
          wrenable_reg_24 = 1'b1;
          _next_state = S_0;
        end
      S_0 :
        begin
          selector_MUX_158_reg_19_0_0_0 = 1'b1;
          selector_MUX_163_reg_23_0_0_0 = 1'b1;
          selector_MUX_167_reg_27_0_0_0 = 1'b1;
          selector_MUX_172_reg_31_0_0_0 = 1'b1;
          selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0 = 1'b1;
          wrenable_reg_19 = 1'b1;
          wrenable_reg_23 = 1'b1;
          wrenable_reg_25 = 1'b1;
          wrenable_reg_26 = 1'b1;
          wrenable_reg_27 = 1'b1;
          wrenable_reg_28 = 1'b1;
          wrenable_reg_29 = 1'b1;
          wrenable_reg_30 = 1'b1;
          wrenable_reg_31 = 1'b1;
          _next_state = S_9;
        end
      S_9 :
        begin
          selector_MUX_171_reg_30_0_0_0 = 1'b1;
          wrenable_reg_27 = 1'b1;
          wrenable_reg_30 = 1'b1;
          wrenable_reg_31 = 1'b1;
          wrenable_reg_32 = 1'b1;
          wrenable_reg_33 = 1'b1;
          wrenable_reg_34 = 1'b1;
          _next_state = S_11;
        end
      S_11 :
        begin
          selector_MUX_174_reg_33_0_0_0 = 1'b1;
          selector_MUX_176_reg_35_0_0_1 = 1'b1;
          selector_MUX_177_reg_36_0_0_0 = 1'b1;
          wrenable_reg_33 = 1'b1;
          wrenable_reg_35 = 1'b1;
          wrenable_reg_36 = 1'b1;
          wrenable_reg_37 = 1'b1;
          wrenable_reg_38 = 1'b1;
          wrenable_reg_39 = 1'b1;
          wrenable_reg_40 = 1'b1;
          wrenable_reg_41 = 1'b1;
          wrenable_reg_42 = 1'b1;
          wrenable_reg_43 = 1'b1;
          wrenable_reg_44 = 1'b1;
          wrenable_reg_45 = 1'b1;
          wrenable_reg_46 = 1'b1;
          wrenable_reg_47 = 1'b1;
          wrenable_reg_48 = 1'b1;
          _next_state = S_14;
        end
      S_14 :
        begin
          selector_MUX_179_reg_38_0_0_0 = 1'b1;
          selector_MUX_183_reg_41_0_0_0 = 1'b1;
          selector_MUX_191_reg_49_0_0_0 = 1'b1;
          selector_MUX_193_reg_50_0_0_0 = 1'b1;
          selector_MUX_195_reg_52_0_0_0 = 1'b1;
          wrenable_reg_36 = 1'b1;
          wrenable_reg_38 = 1'b1;
          wrenable_reg_41 = 1'b1;
          wrenable_reg_49 = 1'b1;
          wrenable_reg_50 = 1'b1;
          wrenable_reg_51 = 1'b1;
          wrenable_reg_52 = 1'b1;
          wrenable_reg_53 = 1'b1;
          _next_state = S_16;
        end
      S_16 :
        begin
          selector_MUX_194_reg_51_0_0_0 = 1'b1;
          wrenable_reg_49 = 1'b1;
          wrenable_reg_50 = 1'b1;
          wrenable_reg_51 = 1'b1;
          wrenable_reg_52 = 1'b1;
          wrenable_reg_54 = 1'b1;
          wrenable_reg_55 = 1'b1;
          wrenable_reg_56 = 1'b1;
          wrenable_reg_57 = 1'b1;
          wrenable_reg_58 = 1'b1;
          wrenable_reg_59 = 1'b1;
          wrenable_reg_60 = 1'b1;
          wrenable_reg_61 = 1'b1;
          wrenable_reg_62 = 1'b1;
          wrenable_reg_63 = 1'b1;
          wrenable_reg_64 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446832 == 1'b1)
            begin
              _next_state = S_18;
            end
          else
            begin
              _next_state = S_17;
              wrenable_reg_54 = 1'b0;
              wrenable_reg_55 = 1'b0;
              wrenable_reg_56 = 1'b0;
              wrenable_reg_57 = 1'b0;
              wrenable_reg_59 = 1'b0;
              wrenable_reg_60 = 1'b0;
              wrenable_reg_61 = 1'b0;
              wrenable_reg_62 = 1'b0;
              wrenable_reg_63 = 1'b0;
              wrenable_reg_64 = 1'b0;
            end
        end
      S_18 :
        begin
          selector_MUX_219_reg_74_0_0_0 = 1'b1;
          wrenable_reg_65 = 1'b1;
          wrenable_reg_66 = 1'b1;
          wrenable_reg_67 = 1'b1;
          wrenable_reg_68 = 1'b1;
          wrenable_reg_69 = 1'b1;
          wrenable_reg_70 = 1'b1;
          wrenable_reg_74 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446854 == 1'b1)
            begin
              _next_state = S_19;
              selector_MUX_219_reg_74_0_0_0 = 1'b0;
              wrenable_reg_74 = 1'b0;
            end
          else
            begin
              _next_state = S_21;
              wrenable_reg_65 = 1'b0;
              wrenable_reg_66 = 1'b0;
            end
        end
      S_19 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1 = 1'b1;
          wrenable_reg_71 = 1'b1;
          _next_state = S_20;
        end
      S_20 :
        begin
          selector_MUX_219_reg_74_0_0_0 = 1'b1;
          selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1 = 1'b1;
          wrenable_reg_72 = 1'b1;
          wrenable_reg_73 = 1'b1;
          wrenable_reg_74 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446860 == 1'b1)
            begin
              _next_state = S_21;
              wrenable_reg_72 = 1'b0;
              wrenable_reg_73 = 1'b0;
            end
          else
            begin
              _next_state = S_22;
              selector_MUX_219_reg_74_0_0_0 = 1'b0;
              wrenable_reg_74 = 1'b0;
            end
        end
      S_22 :
        begin
          selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1 = 1'b1;
          fuselector_SPROXY_CTRLN_3_i0_LOAD = 1'b1;
          _next_state = S_23;
        end
      S_23 :
        begin
          wrenable_reg_74 = 1'b1;
          _next_state = S_21;
        end
      S_21 :
        begin
          wrenable_reg_75 = 1'b1;
          wrenable_reg_76 = 1'b1;
          wrenable_reg_77 = 1'b1;
          wrenable_reg_78 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446865 == 1'b1)
            begin
              _next_state = S_24;
            end
          else
            begin
              _next_state = S_26;
              wrenable_reg_75 = 1'b0;
              wrenable_reg_76 = 1'b0;
            end
        end
      S_24 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          _next_state = S_25;
        end
      S_25 :
        begin
          wrenable_reg_79 = 1'b1;
          wrenable_reg_80 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446871 == 1'b1)
            begin
              _next_state = S_26;
              wrenable_reg_79 = 1'b0;
              wrenable_reg_80 = 1'b0;
            end
          else
            begin
              _next_state = S_27;
            end
        end
      S_27 :
        begin
          fuselector_SPROXY_CTRLN_3_i0_LOAD = 1'b1;
          _next_state = S_28;
        end
      S_28 :
        begin
          selector_MUX_219_reg_74_0_0_1 = 1'b1;
          wrenable_reg_74 = 1'b1;
          _next_state = S_26;
        end
      S_26 :
        begin
          selector_MUX_176_reg_35_0_0_0 = 1'b1;
          wrenable_reg_35 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446876 == 1'b1)
            begin
              _next_state = S_29;
              selector_MUX_176_reg_35_0_0_0 = 1'b0;
              wrenable_reg_35 = 1'b0;
            end
          else
            begin
              _next_state = S_17;
            end
        end
      S_29 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0 = 1'b1;
          _next_state = S_30;
        end
      S_30 :
        begin
          selector_MUX_176_reg_35_0_0_0 = 1'b1;
          selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0 = 1'b1;
          wrenable_reg_35 = 1'b1;
          wrenable_reg_81 = 1'b1;
          wrenable_reg_82 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446882 == 1'b1)
            begin
              _next_state = S_17;
              wrenable_reg_81 = 1'b0;
              wrenable_reg_82 = 1'b0;
            end
          else
            begin
              _next_state = S_31;
              selector_MUX_176_reg_35_0_0_0 = 1'b0;
              wrenable_reg_35 = 1'b0;
            end
        end
      S_31 :
        begin
          selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0 = 1'b1;
          fuselector_SPROXY_CTRLN_3_i0_LOAD = 1'b1;
          _next_state = S_32;
        end
      S_32 :
        begin
          wrenable_reg_35 = 1'b1;
          _next_state = S_17;
        end
      S_17 :
        begin
          if (OUT_CONDITION_conv_layer_428530_446849 == 1'b1)
            begin
              _next_state = S_15;
            end
          else
            begin
              _next_state = S_16;
            end
        end
      S_15 :
        begin
          if (OUT_CONDITION_conv_layer_428530_446825 == 1'b1)
            begin
              _next_state = S_12;
            end
          else
            begin
              _next_state = S_14;
            end
        end
      S_12 :
        begin
          wrenable_reg_83 = 1'b1;
          wrenable_reg_84 = 1'b1;
          _next_state = S_13;
        end
      S_13 :
        begin
          selector_MUX_166_reg_26_0_0_0 = 1'b1;
          wrenable_reg_26 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446788 == 1'b1)
            begin
              _next_state = S_10;
            end
          else
            begin
              _next_state = S_11;
            end
        end
      S_10 :
        begin
          if (OUT_CONDITION_conv_layer_428530_446783 == 1'b1)
            begin
              _next_state = S_5;
            end
          else
            begin
              _next_state = S_9;
            end
        end
      S_5 :
        begin
          fuselector_SPROXY_CTRLN_3_i0_STORE = 1'b1;
          wrenable_reg_21 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446755 == 1'b1)
            begin
              _next_state = S_4;
              wrenable_reg_21 = 1'b0;
            end
          else
            begin
              _next_state = S_0;
            end
        end
      S_4 :
        begin
          selector_MUX_157_reg_18_0_0_0 = 1'b1;
          wrenable_reg_18 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446751 == 1'b1)
            begin
              _next_state = S_3;
              selector_MUX_157_reg_18_0_0_0 = 1'b0;
              wrenable_reg_18 = 1'b0;
            end
          else
            begin
              _next_state = S_1;
            end
        end
      S_3 :
        begin
          selector_MUX_148_reg_1_0_0_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          if (OUT_CONDITION_conv_layer_428530_446745 == 1'b1)
            begin
              _next_state = S_8;
              done_port = 1'b1;
              selector_MUX_148_reg_1_0_0_0 = 1'b0;
              wrenable_reg_1 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
            end
        end
      S_8 :
        begin
          _next_state = S_6;
        end
      default :
        begin
          _next_state = S_6;
        end
    endcase
  end
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Marco Lattuada <marco.lattuada@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module flipflop_AR(clock,
  reset,
  in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input in1;
  // OUT
  output out1;
  
  reg reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock or negedge reset)
    if (reset == 1'b0)
      reg_out1 <= {BITSIZE_out1{1'b0}};
    else
      reg_out1 <= in1;
endmodule

// Top component for conv_layer
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module conv_layer(clock,
  reset,
  start_port,
  done_port,
  in_off,
  out_off,
  w_off,
  m_off,
  cin,
  cout,
  H,
  hw,
  sh,
  pool,
  proxy_out1_428598,
  proxy_in1_428598,
  proxy_in2r_428598,
  proxy_in2w_428598,
  proxy_in3r_428598,
  proxy_in3w_428598,
  proxy_in4r_428598,
  proxy_in4w_428598,
  proxy_sel_LOAD_428598,
  proxy_sel_STORE_428598);
  parameter MEM_var_428598_428531=16384,
    MEM_var_440988_428530=16384,
    MEM_var_446454_428530=16384,
    MEM_var_446587_428530=16384;
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] in_off;
  input [31:0] out_off;
  input [31:0] w_off;
  input [31:0] m_off;
  input [31:0] cin;
  input [31:0] cout;
  input [31:0] H;
  input [31:0] hw;
  input [31:0] sh;
  input [31:0] pool;
  input [63:0] proxy_out1_428598;
  // OUT
  output done_port;
  output [63:0] proxy_in1_428598;
  output [63:0] proxy_in2r_428598;
  output [63:0] proxy_in2w_428598;
  output [11:0] proxy_in3r_428598;
  output [11:0] proxy_in3w_428598;
  output [1:0] proxy_in4r_428598;
  output [1:0] proxy_in4w_428598;
  output [1:0] proxy_sel_LOAD_428598;
  output [1:0] proxy_sel_STORE_428598;
  // Component and signal declarations
  wire OUT_CONDITION_conv_layer_428530_446745;
  wire OUT_CONDITION_conv_layer_428530_446751;
  wire OUT_CONDITION_conv_layer_428530_446755;
  wire OUT_CONDITION_conv_layer_428530_446783;
  wire OUT_CONDITION_conv_layer_428530_446788;
  wire OUT_CONDITION_conv_layer_428530_446825;
  wire OUT_CONDITION_conv_layer_428530_446832;
  wire OUT_CONDITION_conv_layer_428530_446849;
  wire OUT_CONDITION_conv_layer_428530_446854;
  wire OUT_CONDITION_conv_layer_428530_446860;
  wire OUT_CONDITION_conv_layer_428530_446865;
  wire OUT_CONDITION_conv_layer_428530_446871;
  wire OUT_CONDITION_conv_layer_428530_446876;
  wire OUT_CONDITION_conv_layer_428530_446882;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  wire fuselector_SPROXY_CTRLN_3_i0_LOAD;
  wire fuselector_SPROXY_CTRLN_3_i0_STORE;
  wire [31:0] in_port_H_SIGI1;
  wire [31:0] in_port_H_SIGI2;
  wire [31:0] in_port_cin_SIGI1;
  wire [31:0] in_port_cin_SIGI2;
  wire [31:0] in_port_cout_SIGI1;
  wire [31:0] in_port_cout_SIGI2;
  wire [31:0] in_port_hw_SIGI1;
  wire [31:0] in_port_hw_SIGI2;
  wire [31:0] in_port_in_off_SIGI1;
  wire [31:0] in_port_in_off_SIGI2;
  wire [31:0] in_port_m_off_SIGI1;
  wire [31:0] in_port_m_off_SIGI2;
  wire [31:0] in_port_out_off_SIGI1;
  wire [31:0] in_port_out_off_SIGI2;
  wire [31:0] in_port_pool_SIGI1;
  wire [31:0] in_port_pool_SIGI2;
  wire [31:0] in_port_sh_SIGI1;
  wire [31:0] in_port_sh_SIGI2;
  wire [31:0] in_port_w_off_SIGI1;
  wire [31:0] in_port_w_off_SIGI2;
  wire selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  wire selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  wire selector_MUX_148_reg_1_0_0_0;
  wire selector_MUX_157_reg_18_0_0_0;
  wire selector_MUX_158_reg_19_0_0_0;
  wire selector_MUX_160_reg_20_0_0_0;
  wire selector_MUX_163_reg_23_0_0_0;
  wire selector_MUX_166_reg_26_0_0_0;
  wire selector_MUX_167_reg_27_0_0_0;
  wire selector_MUX_171_reg_30_0_0_0;
  wire selector_MUX_172_reg_31_0_0_0;
  wire selector_MUX_174_reg_33_0_0_0;
  wire selector_MUX_176_reg_35_0_0_0;
  wire selector_MUX_176_reg_35_0_0_1;
  wire selector_MUX_177_reg_36_0_0_0;
  wire selector_MUX_179_reg_38_0_0_0;
  wire selector_MUX_181_reg_4_0_0_0;
  wire selector_MUX_183_reg_41_0_0_0;
  wire selector_MUX_191_reg_49_0_0_0;
  wire selector_MUX_193_reg_50_0_0_0;
  wire selector_MUX_194_reg_51_0_0_0;
  wire selector_MUX_195_reg_52_0_0_0;
  wire selector_MUX_219_reg_74_0_0_0;
  wire selector_MUX_219_reg_74_0_0_1;
  wire selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0;
  wire selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1;
  wire selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0;
  wire selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0;
  wire selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_10;
  wire wrenable_reg_11;
  wire wrenable_reg_12;
  wire wrenable_reg_13;
  wire wrenable_reg_14;
  wire wrenable_reg_15;
  wire wrenable_reg_16;
  wire wrenable_reg_17;
  wire wrenable_reg_18;
  wire wrenable_reg_19;
  wire wrenable_reg_2;
  wire wrenable_reg_20;
  wire wrenable_reg_21;
  wire wrenable_reg_22;
  wire wrenable_reg_23;
  wire wrenable_reg_24;
  wire wrenable_reg_25;
  wire wrenable_reg_26;
  wire wrenable_reg_27;
  wire wrenable_reg_28;
  wire wrenable_reg_29;
  wire wrenable_reg_3;
  wire wrenable_reg_30;
  wire wrenable_reg_31;
  wire wrenable_reg_32;
  wire wrenable_reg_33;
  wire wrenable_reg_34;
  wire wrenable_reg_35;
  wire wrenable_reg_36;
  wire wrenable_reg_37;
  wire wrenable_reg_38;
  wire wrenable_reg_39;
  wire wrenable_reg_4;
  wire wrenable_reg_40;
  wire wrenable_reg_41;
  wire wrenable_reg_42;
  wire wrenable_reg_43;
  wire wrenable_reg_44;
  wire wrenable_reg_45;
  wire wrenable_reg_46;
  wire wrenable_reg_47;
  wire wrenable_reg_48;
  wire wrenable_reg_49;
  wire wrenable_reg_5;
  wire wrenable_reg_50;
  wire wrenable_reg_51;
  wire wrenable_reg_52;
  wire wrenable_reg_53;
  wire wrenable_reg_54;
  wire wrenable_reg_55;
  wire wrenable_reg_56;
  wire wrenable_reg_57;
  wire wrenable_reg_58;
  wire wrenable_reg_59;
  wire wrenable_reg_6;
  wire wrenable_reg_60;
  wire wrenable_reg_61;
  wire wrenable_reg_62;
  wire wrenable_reg_63;
  wire wrenable_reg_64;
  wire wrenable_reg_65;
  wire wrenable_reg_66;
  wire wrenable_reg_67;
  wire wrenable_reg_68;
  wire wrenable_reg_69;
  wire wrenable_reg_7;
  wire wrenable_reg_70;
  wire wrenable_reg_71;
  wire wrenable_reg_72;
  wire wrenable_reg_73;
  wire wrenable_reg_74;
  wire wrenable_reg_75;
  wire wrenable_reg_76;
  wire wrenable_reg_77;
  wire wrenable_reg_78;
  wire wrenable_reg_79;
  wire wrenable_reg_8;
  wire wrenable_reg_80;
  wire wrenable_reg_81;
  wire wrenable_reg_82;
  wire wrenable_reg_83;
  wire wrenable_reg_84;
  wire wrenable_reg_9;
  
  controller_conv_layer Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE),
    .selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .selector_MUX_148_reg_1_0_0_0(selector_MUX_148_reg_1_0_0_0),
    .selector_MUX_157_reg_18_0_0_0(selector_MUX_157_reg_18_0_0_0),
    .selector_MUX_158_reg_19_0_0_0(selector_MUX_158_reg_19_0_0_0),
    .selector_MUX_160_reg_20_0_0_0(selector_MUX_160_reg_20_0_0_0),
    .selector_MUX_163_reg_23_0_0_0(selector_MUX_163_reg_23_0_0_0),
    .selector_MUX_166_reg_26_0_0_0(selector_MUX_166_reg_26_0_0_0),
    .selector_MUX_167_reg_27_0_0_0(selector_MUX_167_reg_27_0_0_0),
    .selector_MUX_171_reg_30_0_0_0(selector_MUX_171_reg_30_0_0_0),
    .selector_MUX_172_reg_31_0_0_0(selector_MUX_172_reg_31_0_0_0),
    .selector_MUX_174_reg_33_0_0_0(selector_MUX_174_reg_33_0_0_0),
    .selector_MUX_176_reg_35_0_0_0(selector_MUX_176_reg_35_0_0_0),
    .selector_MUX_176_reg_35_0_0_1(selector_MUX_176_reg_35_0_0_1),
    .selector_MUX_177_reg_36_0_0_0(selector_MUX_177_reg_36_0_0_0),
    .selector_MUX_179_reg_38_0_0_0(selector_MUX_179_reg_38_0_0_0),
    .selector_MUX_181_reg_4_0_0_0(selector_MUX_181_reg_4_0_0_0),
    .selector_MUX_183_reg_41_0_0_0(selector_MUX_183_reg_41_0_0_0),
    .selector_MUX_191_reg_49_0_0_0(selector_MUX_191_reg_49_0_0_0),
    .selector_MUX_193_reg_50_0_0_0(selector_MUX_193_reg_50_0_0_0),
    .selector_MUX_194_reg_51_0_0_0(selector_MUX_194_reg_51_0_0_0),
    .selector_MUX_195_reg_52_0_0_0(selector_MUX_195_reg_52_0_0_0),
    .selector_MUX_219_reg_74_0_0_0(selector_MUX_219_reg_74_0_0_0),
    .selector_MUX_219_reg_74_0_0_1(selector_MUX_219_reg_74_0_0_1),
    .selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0(selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0),
    .selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1(selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1),
    .selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0(selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0),
    .selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0(selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0),
    .selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1(selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1),
    .fuselector_SPROXY_CTRLN_3_i0_LOAD(fuselector_SPROXY_CTRLN_3_i0_LOAD),
    .fuselector_SPROXY_CTRLN_3_i0_STORE(fuselector_SPROXY_CTRLN_3_i0_STORE),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_10(wrenable_reg_10),
    .wrenable_reg_11(wrenable_reg_11),
    .wrenable_reg_12(wrenable_reg_12),
    .wrenable_reg_13(wrenable_reg_13),
    .wrenable_reg_14(wrenable_reg_14),
    .wrenable_reg_15(wrenable_reg_15),
    .wrenable_reg_16(wrenable_reg_16),
    .wrenable_reg_17(wrenable_reg_17),
    .wrenable_reg_18(wrenable_reg_18),
    .wrenable_reg_19(wrenable_reg_19),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_20(wrenable_reg_20),
    .wrenable_reg_21(wrenable_reg_21),
    .wrenable_reg_22(wrenable_reg_22),
    .wrenable_reg_23(wrenable_reg_23),
    .wrenable_reg_24(wrenable_reg_24),
    .wrenable_reg_25(wrenable_reg_25),
    .wrenable_reg_26(wrenable_reg_26),
    .wrenable_reg_27(wrenable_reg_27),
    .wrenable_reg_28(wrenable_reg_28),
    .wrenable_reg_29(wrenable_reg_29),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_30(wrenable_reg_30),
    .wrenable_reg_31(wrenable_reg_31),
    .wrenable_reg_32(wrenable_reg_32),
    .wrenable_reg_33(wrenable_reg_33),
    .wrenable_reg_34(wrenable_reg_34),
    .wrenable_reg_35(wrenable_reg_35),
    .wrenable_reg_36(wrenable_reg_36),
    .wrenable_reg_37(wrenable_reg_37),
    .wrenable_reg_38(wrenable_reg_38),
    .wrenable_reg_39(wrenable_reg_39),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_40(wrenable_reg_40),
    .wrenable_reg_41(wrenable_reg_41),
    .wrenable_reg_42(wrenable_reg_42),
    .wrenable_reg_43(wrenable_reg_43),
    .wrenable_reg_44(wrenable_reg_44),
    .wrenable_reg_45(wrenable_reg_45),
    .wrenable_reg_46(wrenable_reg_46),
    .wrenable_reg_47(wrenable_reg_47),
    .wrenable_reg_48(wrenable_reg_48),
    .wrenable_reg_49(wrenable_reg_49),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_50(wrenable_reg_50),
    .wrenable_reg_51(wrenable_reg_51),
    .wrenable_reg_52(wrenable_reg_52),
    .wrenable_reg_53(wrenable_reg_53),
    .wrenable_reg_54(wrenable_reg_54),
    .wrenable_reg_55(wrenable_reg_55),
    .wrenable_reg_56(wrenable_reg_56),
    .wrenable_reg_57(wrenable_reg_57),
    .wrenable_reg_58(wrenable_reg_58),
    .wrenable_reg_59(wrenable_reg_59),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_60(wrenable_reg_60),
    .wrenable_reg_61(wrenable_reg_61),
    .wrenable_reg_62(wrenable_reg_62),
    .wrenable_reg_63(wrenable_reg_63),
    .wrenable_reg_64(wrenable_reg_64),
    .wrenable_reg_65(wrenable_reg_65),
    .wrenable_reg_66(wrenable_reg_66),
    .wrenable_reg_67(wrenable_reg_67),
    .wrenable_reg_68(wrenable_reg_68),
    .wrenable_reg_69(wrenable_reg_69),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_70(wrenable_reg_70),
    .wrenable_reg_71(wrenable_reg_71),
    .wrenable_reg_72(wrenable_reg_72),
    .wrenable_reg_73(wrenable_reg_73),
    .wrenable_reg_74(wrenable_reg_74),
    .wrenable_reg_75(wrenable_reg_75),
    .wrenable_reg_76(wrenable_reg_76),
    .wrenable_reg_77(wrenable_reg_77),
    .wrenable_reg_78(wrenable_reg_78),
    .wrenable_reg_79(wrenable_reg_79),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_80(wrenable_reg_80),
    .wrenable_reg_81(wrenable_reg_81),
    .wrenable_reg_82(wrenable_reg_82),
    .wrenable_reg_83(wrenable_reg_83),
    .wrenable_reg_84(wrenable_reg_84),
    .wrenable_reg_9(wrenable_reg_9),
    .OUT_CONDITION_conv_layer_428530_446745(OUT_CONDITION_conv_layer_428530_446745),
    .OUT_CONDITION_conv_layer_428530_446751(OUT_CONDITION_conv_layer_428530_446751),
    .OUT_CONDITION_conv_layer_428530_446755(OUT_CONDITION_conv_layer_428530_446755),
    .OUT_CONDITION_conv_layer_428530_446783(OUT_CONDITION_conv_layer_428530_446783),
    .OUT_CONDITION_conv_layer_428530_446788(OUT_CONDITION_conv_layer_428530_446788),
    .OUT_CONDITION_conv_layer_428530_446825(OUT_CONDITION_conv_layer_428530_446825),
    .OUT_CONDITION_conv_layer_428530_446832(OUT_CONDITION_conv_layer_428530_446832),
    .OUT_CONDITION_conv_layer_428530_446849(OUT_CONDITION_conv_layer_428530_446849),
    .OUT_CONDITION_conv_layer_428530_446854(OUT_CONDITION_conv_layer_428530_446854),
    .OUT_CONDITION_conv_layer_428530_446860(OUT_CONDITION_conv_layer_428530_446860),
    .OUT_CONDITION_conv_layer_428530_446865(OUT_CONDITION_conv_layer_428530_446865),
    .OUT_CONDITION_conv_layer_428530_446871(OUT_CONDITION_conv_layer_428530_446871),
    .OUT_CONDITION_conv_layer_428530_446876(OUT_CONDITION_conv_layer_428530_446876),
    .OUT_CONDITION_conv_layer_428530_446882(OUT_CONDITION_conv_layer_428530_446882),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_conv_layer #(.MEM_var_428598_428531(MEM_var_428598_428531),
    .MEM_var_440988_428530(MEM_var_440988_428530),
    .MEM_var_446454_428530(MEM_var_446454_428530),
    .MEM_var_446587_428530(MEM_var_446587_428530)) Datapath_i (.proxy_in1_428598(proxy_in1_428598),
    .proxy_in2r_428598(proxy_in2r_428598),
    .proxy_in2w_428598(proxy_in2w_428598),
    .proxy_in3r_428598(proxy_in3r_428598),
    .proxy_in3w_428598(proxy_in3w_428598),
    .proxy_in4r_428598(proxy_in4r_428598),
    .proxy_in4w_428598(proxy_in4w_428598),
    .proxy_sel_LOAD_428598(proxy_sel_LOAD_428598),
    .proxy_sel_STORE_428598(proxy_sel_STORE_428598),
    .OUT_CONDITION_conv_layer_428530_446745(OUT_CONDITION_conv_layer_428530_446745),
    .OUT_CONDITION_conv_layer_428530_446751(OUT_CONDITION_conv_layer_428530_446751),
    .OUT_CONDITION_conv_layer_428530_446755(OUT_CONDITION_conv_layer_428530_446755),
    .OUT_CONDITION_conv_layer_428530_446783(OUT_CONDITION_conv_layer_428530_446783),
    .OUT_CONDITION_conv_layer_428530_446788(OUT_CONDITION_conv_layer_428530_446788),
    .OUT_CONDITION_conv_layer_428530_446825(OUT_CONDITION_conv_layer_428530_446825),
    .OUT_CONDITION_conv_layer_428530_446832(OUT_CONDITION_conv_layer_428530_446832),
    .OUT_CONDITION_conv_layer_428530_446849(OUT_CONDITION_conv_layer_428530_446849),
    .OUT_CONDITION_conv_layer_428530_446854(OUT_CONDITION_conv_layer_428530_446854),
    .OUT_CONDITION_conv_layer_428530_446860(OUT_CONDITION_conv_layer_428530_446860),
    .OUT_CONDITION_conv_layer_428530_446865(OUT_CONDITION_conv_layer_428530_446865),
    .OUT_CONDITION_conv_layer_428530_446871(OUT_CONDITION_conv_layer_428530_446871),
    .OUT_CONDITION_conv_layer_428530_446876(OUT_CONDITION_conv_layer_428530_446876),
    .OUT_CONDITION_conv_layer_428530_446882(OUT_CONDITION_conv_layer_428530_446882),
    .clock(clock),
    .reset(reset),
    .in_port_in_off(in_port_in_off_SIGI2),
    .in_port_out_off(in_port_out_off_SIGI2),
    .in_port_w_off(in_port_w_off_SIGI2),
    .in_port_m_off(in_port_m_off_SIGI2),
    .in_port_cin(in_port_cin_SIGI2),
    .in_port_cout(in_port_cout_SIGI2),
    .in_port_H(in_port_H_SIGI2),
    .in_port_hw(in_port_hw_SIGI2),
    .in_port_sh(in_port_sh_SIGI2),
    .in_port_pool(in_port_pool_SIGI2),
    .proxy_out1_428598(proxy_out1_428598),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE),
    .selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .selector_MUX_148_reg_1_0_0_0(selector_MUX_148_reg_1_0_0_0),
    .selector_MUX_157_reg_18_0_0_0(selector_MUX_157_reg_18_0_0_0),
    .selector_MUX_158_reg_19_0_0_0(selector_MUX_158_reg_19_0_0_0),
    .selector_MUX_160_reg_20_0_0_0(selector_MUX_160_reg_20_0_0_0),
    .selector_MUX_163_reg_23_0_0_0(selector_MUX_163_reg_23_0_0_0),
    .selector_MUX_166_reg_26_0_0_0(selector_MUX_166_reg_26_0_0_0),
    .selector_MUX_167_reg_27_0_0_0(selector_MUX_167_reg_27_0_0_0),
    .selector_MUX_171_reg_30_0_0_0(selector_MUX_171_reg_30_0_0_0),
    .selector_MUX_172_reg_31_0_0_0(selector_MUX_172_reg_31_0_0_0),
    .selector_MUX_174_reg_33_0_0_0(selector_MUX_174_reg_33_0_0_0),
    .selector_MUX_176_reg_35_0_0_0(selector_MUX_176_reg_35_0_0_0),
    .selector_MUX_176_reg_35_0_0_1(selector_MUX_176_reg_35_0_0_1),
    .selector_MUX_177_reg_36_0_0_0(selector_MUX_177_reg_36_0_0_0),
    .selector_MUX_179_reg_38_0_0_0(selector_MUX_179_reg_38_0_0_0),
    .selector_MUX_181_reg_4_0_0_0(selector_MUX_181_reg_4_0_0_0),
    .selector_MUX_183_reg_41_0_0_0(selector_MUX_183_reg_41_0_0_0),
    .selector_MUX_191_reg_49_0_0_0(selector_MUX_191_reg_49_0_0_0),
    .selector_MUX_193_reg_50_0_0_0(selector_MUX_193_reg_50_0_0_0),
    .selector_MUX_194_reg_51_0_0_0(selector_MUX_194_reg_51_0_0_0),
    .selector_MUX_195_reg_52_0_0_0(selector_MUX_195_reg_52_0_0_0),
    .selector_MUX_219_reg_74_0_0_0(selector_MUX_219_reg_74_0_0_0),
    .selector_MUX_219_reg_74_0_0_1(selector_MUX_219_reg_74_0_0_1),
    .selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0(selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_0),
    .selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1(selector_MUX_32_SPROXY_CTRLN_3_i0_1_0_1),
    .selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0(selector_MUX_374_ui_lshift_expr_FU_32_32_32_150_i0_0_0_0),
    .selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0(selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_0),
    .selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1(selector_MUX_494_ui_rshift_expr_FU_32_32_32_168_i0_1_0_1),
    .fuselector_SPROXY_CTRLN_3_i0_LOAD(fuselector_SPROXY_CTRLN_3_i0_LOAD),
    .fuselector_SPROXY_CTRLN_3_i0_STORE(fuselector_SPROXY_CTRLN_3_i0_STORE),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_10(wrenable_reg_10),
    .wrenable_reg_11(wrenable_reg_11),
    .wrenable_reg_12(wrenable_reg_12),
    .wrenable_reg_13(wrenable_reg_13),
    .wrenable_reg_14(wrenable_reg_14),
    .wrenable_reg_15(wrenable_reg_15),
    .wrenable_reg_16(wrenable_reg_16),
    .wrenable_reg_17(wrenable_reg_17),
    .wrenable_reg_18(wrenable_reg_18),
    .wrenable_reg_19(wrenable_reg_19),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_20(wrenable_reg_20),
    .wrenable_reg_21(wrenable_reg_21),
    .wrenable_reg_22(wrenable_reg_22),
    .wrenable_reg_23(wrenable_reg_23),
    .wrenable_reg_24(wrenable_reg_24),
    .wrenable_reg_25(wrenable_reg_25),
    .wrenable_reg_26(wrenable_reg_26),
    .wrenable_reg_27(wrenable_reg_27),
    .wrenable_reg_28(wrenable_reg_28),
    .wrenable_reg_29(wrenable_reg_29),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_30(wrenable_reg_30),
    .wrenable_reg_31(wrenable_reg_31),
    .wrenable_reg_32(wrenable_reg_32),
    .wrenable_reg_33(wrenable_reg_33),
    .wrenable_reg_34(wrenable_reg_34),
    .wrenable_reg_35(wrenable_reg_35),
    .wrenable_reg_36(wrenable_reg_36),
    .wrenable_reg_37(wrenable_reg_37),
    .wrenable_reg_38(wrenable_reg_38),
    .wrenable_reg_39(wrenable_reg_39),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_40(wrenable_reg_40),
    .wrenable_reg_41(wrenable_reg_41),
    .wrenable_reg_42(wrenable_reg_42),
    .wrenable_reg_43(wrenable_reg_43),
    .wrenable_reg_44(wrenable_reg_44),
    .wrenable_reg_45(wrenable_reg_45),
    .wrenable_reg_46(wrenable_reg_46),
    .wrenable_reg_47(wrenable_reg_47),
    .wrenable_reg_48(wrenable_reg_48),
    .wrenable_reg_49(wrenable_reg_49),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_50(wrenable_reg_50),
    .wrenable_reg_51(wrenable_reg_51),
    .wrenable_reg_52(wrenable_reg_52),
    .wrenable_reg_53(wrenable_reg_53),
    .wrenable_reg_54(wrenable_reg_54),
    .wrenable_reg_55(wrenable_reg_55),
    .wrenable_reg_56(wrenable_reg_56),
    .wrenable_reg_57(wrenable_reg_57),
    .wrenable_reg_58(wrenable_reg_58),
    .wrenable_reg_59(wrenable_reg_59),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_60(wrenable_reg_60),
    .wrenable_reg_61(wrenable_reg_61),
    .wrenable_reg_62(wrenable_reg_62),
    .wrenable_reg_63(wrenable_reg_63),
    .wrenable_reg_64(wrenable_reg_64),
    .wrenable_reg_65(wrenable_reg_65),
    .wrenable_reg_66(wrenable_reg_66),
    .wrenable_reg_67(wrenable_reg_67),
    .wrenable_reg_68(wrenable_reg_68),
    .wrenable_reg_69(wrenable_reg_69),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_70(wrenable_reg_70),
    .wrenable_reg_71(wrenable_reg_71),
    .wrenable_reg_72(wrenable_reg_72),
    .wrenable_reg_73(wrenable_reg_73),
    .wrenable_reg_74(wrenable_reg_74),
    .wrenable_reg_75(wrenable_reg_75),
    .wrenable_reg_76(wrenable_reg_76),
    .wrenable_reg_77(wrenable_reg_77),
    .wrenable_reg_78(wrenable_reg_78),
    .wrenable_reg_79(wrenable_reg_79),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_80(wrenable_reg_80),
    .wrenable_reg_81(wrenable_reg_81),
    .wrenable_reg_82(wrenable_reg_82),
    .wrenable_reg_83(wrenable_reg_83),
    .wrenable_reg_84(wrenable_reg_84),
    .wrenable_reg_9(wrenable_reg_9));
  flipflop_AR #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out),
    .clock(clock),
    .reset(reset),
    .in1(done_delayed_REG_signal_in));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_H_REG (.out1(in_port_H_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_H_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_cin_REG (.out1(in_port_cin_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_cin_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_cout_REG (.out1(in_port_cout_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_cout_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_hw_REG (.out1(in_port_hw_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_hw_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_in_off_REG (.out1(in_port_in_off_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_in_off_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_m_off_REG (.out1(in_port_m_off_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_m_off_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_out_off_REG (.out1(in_port_out_off_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_out_off_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_pool_REG (.out1(in_port_pool_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_pool_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_sh_REG (.out1(in_port_sh_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_sh_SIGI1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) in_port_w_off_REG (.out1(in_port_w_off_SIGI2),
    .clock(clock),
    .reset(reset),
    .in1(in_port_w_off_SIGI1));
  // io-signal post fix
  assign in_port_in_off_SIGI1 = in_off;
  assign in_port_out_off_SIGI1 = out_off;
  assign in_port_w_off_SIGI1 = w_off;
  assign in_port_m_off_SIGI1 = m_off;
  assign in_port_cin_SIGI1 = cin;
  assign in_port_cout_SIGI1 = cout;
  assign in_port_H_SIGI1 = H;
  assign in_port_hw_SIGI1 = hw;
  assign in_port_sh_SIGI1 = sh;
  assign in_port_pool_SIGI1 = pool;
  assign done_port = done_delayed_REG_signal_out;

endmodule

// Datapath RTL description for cnn_top
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_cnn_top(clock,
  reset,
  in_port_img,
  return_port,
  M_Rdata_ram,
  M_DataRdy,
  Min_oe_ram,
  Min_we_ram,
  Min_addr_ram,
  Min_Wdata_ram,
  Min_data_ram_size,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE,
  fuselector_BMEMORY_CTRLN_53_i0_LOAD,
  fuselector_BMEMORY_CTRLN_53_i0_STORE,
  fuselector_BMEMORY_CTRLN_53_i1_LOAD,
  fuselector_BMEMORY_CTRLN_53_i1_STORE,
  selector_IN_UNBOUNDED_cnn_top_428531_440934,
  selector_IN_UNBOUNDED_cnn_top_428531_440935,
  selector_IN_UNBOUNDED_cnn_top_428531_440936,
  selector_IN_UNBOUNDED_cnn_top_428531_440937,
  selector_IN_UNBOUNDED_cnn_top_428531_440938,
  selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0,
  selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0,
  selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0,
  selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0,
  selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1,
  selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0,
  selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0,
  selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0,
  selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0,
  selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0,
  selector_MUX_44_conv_layer_93_i0_0_0_0,
  selector_MUX_45_conv_layer_93_i0_1_0_0,
  selector_MUX_46_conv_layer_93_i0_2_0_0,
  selector_MUX_46_conv_layer_93_i0_2_0_1,
  selector_MUX_46_conv_layer_93_i0_2_0_2,
  selector_MUX_46_conv_layer_93_i0_2_1_0,
  selector_MUX_47_conv_layer_93_i0_3_0_0,
  selector_MUX_47_conv_layer_93_i0_3_0_1,
  selector_MUX_47_conv_layer_93_i0_3_0_2,
  selector_MUX_47_conv_layer_93_i0_3_1_0,
  selector_MUX_48_conv_layer_93_i0_4_0_0,
  selector_MUX_48_conv_layer_93_i0_4_0_1,
  selector_MUX_48_conv_layer_93_i0_4_0_2,
  selector_MUX_48_conv_layer_93_i0_4_1_0,
  selector_MUX_49_conv_layer_93_i0_5_0_0,
  selector_MUX_49_conv_layer_93_i0_5_0_1,
  selector_MUX_49_conv_layer_93_i0_5_0_2,
  selector_MUX_49_conv_layer_93_i0_5_1_0,
  selector_MUX_50_conv_layer_93_i0_6_0_0,
  selector_MUX_50_conv_layer_93_i0_6_0_1,
  selector_MUX_50_conv_layer_93_i0_6_1_0,
  selector_MUX_51_conv_layer_93_i0_7_0_0,
  selector_MUX_51_conv_layer_93_i0_7_0_1,
  selector_MUX_51_conv_layer_93_i0_7_1_0,
  selector_MUX_52_conv_layer_93_i0_8_0_0,
  selector_MUX_52_conv_layer_93_i0_8_0_1,
  selector_MUX_52_conv_layer_93_i0_8_1_0,
  selector_MUX_53_conv_layer_93_i0_9_0_0,
  selector_MUX_72_reg_0_0_0_0,
  selector_MUX_76_reg_12_0_0_0,
  selector_MUX_77_reg_13_0_0_0,
  selector_MUX_78_reg_14_0_0_0,
  selector_MUX_79_reg_15_0_0_0,
  selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0,
  selector_MUX_80_reg_16_0_0_0,
  selector_MUX_81_reg_17_0_0_0,
  selector_MUX_83_reg_19_0_0_0,
  selector_MUX_85_reg_20_0_0_0,
  selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0,
  selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1,
  selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0,
  selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_10,
  wrenable_reg_11,
  wrenable_reg_12,
  wrenable_reg_13,
  wrenable_reg_14,
  wrenable_reg_15,
  wrenable_reg_16,
  wrenable_reg_17,
  wrenable_reg_18,
  wrenable_reg_19,
  wrenable_reg_2,
  wrenable_reg_20,
  wrenable_reg_21,
  wrenable_reg_22,
  wrenable_reg_23,
  wrenable_reg_24,
  wrenable_reg_25,
  wrenable_reg_26,
  wrenable_reg_27,
  wrenable_reg_28,
  wrenable_reg_29,
  wrenable_reg_3,
  wrenable_reg_30,
  wrenable_reg_31,
  wrenable_reg_32,
  wrenable_reg_33,
  wrenable_reg_34,
  wrenable_reg_35,
  wrenable_reg_36,
  wrenable_reg_37,
  wrenable_reg_38,
  wrenable_reg_39,
  wrenable_reg_4,
  wrenable_reg_40,
  wrenable_reg_41,
  wrenable_reg_42,
  wrenable_reg_43,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_cnn_top_428531_428575,
  OUT_CONDITION_cnn_top_428531_446010,
  OUT_CONDITION_cnn_top_428531_446014,
  OUT_CONDITION_cnn_top_428531_446026,
  OUT_CONDITION_cnn_top_428531_446030,
  OUT_UNBOUNDED_cnn_top_428531_440934,
  OUT_UNBOUNDED_cnn_top_428531_440935,
  OUT_UNBOUNDED_cnn_top_428531_440936,
  OUT_UNBOUNDED_cnn_top_428531_440937,
  OUT_UNBOUNDED_cnn_top_428531_440938);
  parameter MEM_var_428598_428531=16384,
    MEM_var_440988_428530=16384,
    MEM_var_446454_428530=16384,
    MEM_var_446587_428530=16384;
  // IN
  input clock;
  input reset;
  input [31:0] in_port_img;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  input [1:0] Min_oe_ram;
  input [1:0] Min_we_ram;
  input [63:0] Min_addr_ram;
  input [63:0] Min_Wdata_ram;
  input [11:0] Min_data_ram_size;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE;
  input fuselector_BMEMORY_CTRLN_53_i0_LOAD;
  input fuselector_BMEMORY_CTRLN_53_i0_STORE;
  input fuselector_BMEMORY_CTRLN_53_i1_LOAD;
  input fuselector_BMEMORY_CTRLN_53_i1_STORE;
  input selector_IN_UNBOUNDED_cnn_top_428531_440934;
  input selector_IN_UNBOUNDED_cnn_top_428531_440935;
  input selector_IN_UNBOUNDED_cnn_top_428531_440936;
  input selector_IN_UNBOUNDED_cnn_top_428531_440937;
  input selector_IN_UNBOUNDED_cnn_top_428531_440938;
  input selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0;
  input selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0;
  input selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0;
  input selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  input selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  input selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0;
  input selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0;
  input selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0;
  input selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0;
  input selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0;
  input selector_MUX_44_conv_layer_93_i0_0_0_0;
  input selector_MUX_45_conv_layer_93_i0_1_0_0;
  input selector_MUX_46_conv_layer_93_i0_2_0_0;
  input selector_MUX_46_conv_layer_93_i0_2_0_1;
  input selector_MUX_46_conv_layer_93_i0_2_0_2;
  input selector_MUX_46_conv_layer_93_i0_2_1_0;
  input selector_MUX_47_conv_layer_93_i0_3_0_0;
  input selector_MUX_47_conv_layer_93_i0_3_0_1;
  input selector_MUX_47_conv_layer_93_i0_3_0_2;
  input selector_MUX_47_conv_layer_93_i0_3_1_0;
  input selector_MUX_48_conv_layer_93_i0_4_0_0;
  input selector_MUX_48_conv_layer_93_i0_4_0_1;
  input selector_MUX_48_conv_layer_93_i0_4_0_2;
  input selector_MUX_48_conv_layer_93_i0_4_1_0;
  input selector_MUX_49_conv_layer_93_i0_5_0_0;
  input selector_MUX_49_conv_layer_93_i0_5_0_1;
  input selector_MUX_49_conv_layer_93_i0_5_0_2;
  input selector_MUX_49_conv_layer_93_i0_5_1_0;
  input selector_MUX_50_conv_layer_93_i0_6_0_0;
  input selector_MUX_50_conv_layer_93_i0_6_0_1;
  input selector_MUX_50_conv_layer_93_i0_6_1_0;
  input selector_MUX_51_conv_layer_93_i0_7_0_0;
  input selector_MUX_51_conv_layer_93_i0_7_0_1;
  input selector_MUX_51_conv_layer_93_i0_7_1_0;
  input selector_MUX_52_conv_layer_93_i0_8_0_0;
  input selector_MUX_52_conv_layer_93_i0_8_0_1;
  input selector_MUX_52_conv_layer_93_i0_8_1_0;
  input selector_MUX_53_conv_layer_93_i0_9_0_0;
  input selector_MUX_72_reg_0_0_0_0;
  input selector_MUX_76_reg_12_0_0_0;
  input selector_MUX_77_reg_13_0_0_0;
  input selector_MUX_78_reg_14_0_0_0;
  input selector_MUX_79_reg_15_0_0_0;
  input selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0;
  input selector_MUX_80_reg_16_0_0_0;
  input selector_MUX_81_reg_17_0_0_0;
  input selector_MUX_83_reg_19_0_0_0;
  input selector_MUX_85_reg_20_0_0_0;
  input selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0;
  input selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1;
  input selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0;
  input selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_10;
  input wrenable_reg_11;
  input wrenable_reg_12;
  input wrenable_reg_13;
  input wrenable_reg_14;
  input wrenable_reg_15;
  input wrenable_reg_16;
  input wrenable_reg_17;
  input wrenable_reg_18;
  input wrenable_reg_19;
  input wrenable_reg_2;
  input wrenable_reg_20;
  input wrenable_reg_21;
  input wrenable_reg_22;
  input wrenable_reg_23;
  input wrenable_reg_24;
  input wrenable_reg_25;
  input wrenable_reg_26;
  input wrenable_reg_27;
  input wrenable_reg_28;
  input wrenable_reg_29;
  input wrenable_reg_3;
  input wrenable_reg_30;
  input wrenable_reg_31;
  input wrenable_reg_32;
  input wrenable_reg_33;
  input wrenable_reg_34;
  input wrenable_reg_35;
  input wrenable_reg_36;
  input wrenable_reg_37;
  input wrenable_reg_38;
  input wrenable_reg_39;
  input wrenable_reg_4;
  input wrenable_reg_40;
  input wrenable_reg_41;
  input wrenable_reg_42;
  input wrenable_reg_43;
  input wrenable_reg_5;
  input wrenable_reg_6;
  input wrenable_reg_7;
  input wrenable_reg_8;
  input wrenable_reg_9;
  // OUT
  output [31:0] return_port;
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  output OUT_CONDITION_cnn_top_428531_428575;
  output OUT_CONDITION_cnn_top_428531_446010;
  output OUT_CONDITION_cnn_top_428531_446014;
  output OUT_CONDITION_cnn_top_428531_446026;
  output OUT_CONDITION_cnn_top_428531_446030;
  output OUT_UNBOUNDED_cnn_top_428531_440934;
  output OUT_UNBOUNDED_cnn_top_428531_440935;
  output OUT_UNBOUNDED_cnn_top_428531_440936;
  output OUT_UNBOUNDED_cnn_top_428531_440937;
  output OUT_UNBOUNDED_cnn_top_428531_440938;
  // Component and signal declarations
  wire [63:0] Sproxy_out1_428598;
  wire null_out_signal_array_428598_0_Sout_DataRdy_0;
  wire null_out_signal_array_428598_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_428598_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_428598_0_Sout_Rdata_ram_1;
  wire null_out_signal_array_440988_0_Sout_DataRdy_0;
  wire null_out_signal_array_440988_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_440988_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_440988_0_Sout_Rdata_ram_1;
  wire [31:0] null_out_signal_array_440988_0_out1_1;
  wire [31:0] null_out_signal_array_440988_0_proxy_out1_0;
  wire [31:0] null_out_signal_array_440988_0_proxy_out1_1;
  wire [7:0] out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_428598_0;
  wire [7:0] out_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_array_428598_0;
  wire [31:0] out_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_array_440988_0;
  wire [7:0] out_BMEMORY_CTRLN_53_i0_BMEMORY_CTRLN_53_i0;
  wire [7:0] out_BMEMORY_CTRLN_53_i1_BMEMORY_CTRLN_53_i0;
  wire [7:0] out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0;
  wire [31:0] out_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0;
  wire [31:0] out_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0;
  wire [31:0] out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  wire [31:0] out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  wire [31:0] out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0;
  wire [2:0] out_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0;
  wire [31:0] out_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0;
  wire [4:0] out_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0;
  wire [31:0] out_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0;
  wire [31:0] out_MUX_44_conv_layer_93_i0_0_0_0;
  wire [31:0] out_MUX_45_conv_layer_93_i0_1_0_0;
  wire [31:0] out_MUX_46_conv_layer_93_i0_2_0_0;
  wire [31:0] out_MUX_46_conv_layer_93_i0_2_0_1;
  wire [31:0] out_MUX_46_conv_layer_93_i0_2_0_2;
  wire [31:0] out_MUX_46_conv_layer_93_i0_2_1_0;
  wire [31:0] out_MUX_47_conv_layer_93_i0_3_0_0;
  wire [31:0] out_MUX_47_conv_layer_93_i0_3_0_1;
  wire [31:0] out_MUX_47_conv_layer_93_i0_3_0_2;
  wire [31:0] out_MUX_47_conv_layer_93_i0_3_1_0;
  wire [31:0] out_MUX_48_conv_layer_93_i0_4_0_0;
  wire [31:0] out_MUX_48_conv_layer_93_i0_4_0_1;
  wire [31:0] out_MUX_48_conv_layer_93_i0_4_0_2;
  wire [31:0] out_MUX_48_conv_layer_93_i0_4_1_0;
  wire [31:0] out_MUX_49_conv_layer_93_i0_5_0_0;
  wire [31:0] out_MUX_49_conv_layer_93_i0_5_0_1;
  wire [31:0] out_MUX_49_conv_layer_93_i0_5_0_2;
  wire [31:0] out_MUX_49_conv_layer_93_i0_5_1_0;
  wire [31:0] out_MUX_50_conv_layer_93_i0_6_0_0;
  wire [31:0] out_MUX_50_conv_layer_93_i0_6_0_1;
  wire [31:0] out_MUX_50_conv_layer_93_i0_6_1_0;
  wire [31:0] out_MUX_51_conv_layer_93_i0_7_0_0;
  wire [31:0] out_MUX_51_conv_layer_93_i0_7_0_1;
  wire [31:0] out_MUX_51_conv_layer_93_i0_7_1_0;
  wire [31:0] out_MUX_52_conv_layer_93_i0_8_0_0;
  wire [31:0] out_MUX_52_conv_layer_93_i0_8_0_1;
  wire [31:0] out_MUX_52_conv_layer_93_i0_8_1_0;
  wire [31:0] out_MUX_53_conv_layer_93_i0_9_0_0;
  wire [31:0] out_MUX_72_reg_0_0_0_0;
  wire [31:0] out_MUX_76_reg_12_0_0_0;
  wire [31:0] out_MUX_77_reg_13_0_0_0;
  wire [31:0] out_MUX_78_reg_14_0_0_0;
  wire [31:0] out_MUX_79_reg_15_0_0_0;
  wire [7:0] out_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0;
  wire [31:0] out_MUX_80_reg_16_0_0_0;
  wire [31:0] out_MUX_81_reg_17_0_0_0;
  wire [15:0] out_MUX_83_reg_19_0_0_0;
  wire [31:0] out_MUX_85_reg_20_0_0_0;
  wire [31:0] out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0;
  wire [31:0] out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1;
  wire [31:0] out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0;
  wire [31:0] out_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0;
  wire out_UUdata_converter_FU_10_i0_fu_cnn_top_428531_428574;
  wire out_UUdata_converter_FU_19_i0_fu_cnn_top_428531_446009;
  wire [7:0] out_UUdata_converter_FU_24_i0_fu_cnn_top_428531_445814;
  wire [7:0] out_UUdata_converter_FU_25_i0_fu_cnn_top_428531_445925;
  wire [7:0] out_UUdata_converter_FU_26_i0_fu_cnn_top_428531_445831;
  wire [7:0] out_UUdata_converter_FU_27_i0_fu_cnn_top_428531_445848;
  wire [7:0] out_UUdata_converter_FU_28_i0_fu_cnn_top_428531_445895;
  wire [7:0] out_UUdata_converter_FU_29_i0_fu_cnn_top_428531_445861;
  wire [7:0] out_UUdata_converter_FU_30_i0_fu_cnn_top_428531_445882;
  wire [7:0] out_UUdata_converter_FU_31_i0_fu_cnn_top_428531_445912;
  wire out_UUdata_converter_FU_32_i0_fu_cnn_top_428531_446013;
  wire out_UUdata_converter_FU_39_i0_fu_cnn_top_428531_446025;
  wire [15:0] out_UUdata_converter_FU_40_i0_fu_cnn_top_428531_445786;
  wire out_UUdata_converter_FU_49_i0_fu_cnn_top_428531_446029;
  wire [31:0] out_addr_expr_FU_12_i0_fu_cnn_top_428531_447331;
  wire [31:0] out_addr_expr_FU_4_i0_fu_cnn_top_428531_447229;
  wire out_const_0;
  wire [4:0] out_const_1;
  wire [8:0] out_const_10;
  wire [10:0] out_const_11;
  wire [12:0] out_const_12;
  wire [12:0] out_const_13;
  wire [9:0] out_const_14;
  wire [3:0] out_const_15;
  wire [10:0] out_const_16;
  wire [4:0] out_const_17;
  wire [7:0] out_const_18;
  wire [6:0] out_const_19;
  wire [6:0] out_const_2;
  wire [2:0] out_const_20;
  wire [4:0] out_const_21;
  wire [10:0] out_const_22;
  wire [4:0] out_const_23;
  wire [4:0] out_const_24;
  wire [5:0] out_const_25;
  wire [1:0] out_const_26;
  wire [2:0] out_const_27;
  wire [4:0] out_const_28;
  wire [2:0] out_const_29;
  wire out_const_3;
  wire [4:0] out_const_30;
  wire [4:0] out_const_31;
  wire [14:0] out_const_32;
  wire [14:0] out_const_33;
  wire [1:0] out_const_4;
  wire [2:0] out_const_5;
  wire [3:0] out_const_6;
  wire [4:0] out_const_7;
  wire [5:0] out_const_8;
  wire [6:0] out_const_9;
  wire [15:0] out_conv_out_const_0_1_16;
  wire [31:0] out_conv_out_const_0_1_32;
  wire [31:0] out_conv_out_const_10_9_32;
  wire [31:0] out_conv_out_const_11_11_32;
  wire [31:0] out_conv_out_const_12_13_32;
  wire [31:0] out_conv_out_const_13_13_32;
  wire [31:0] out_conv_out_const_14_10_32;
  wire [31:0] out_conv_out_const_15_4_32;
  wire [31:0] out_conv_out_const_17_5_32;
  wire [31:0] out_conv_out_const_18_8_32;
  wire [31:0] out_conv_out_const_19_7_32;
  wire [5:0] out_conv_out_const_1_5_6;
  wire [31:0] out_conv_out_const_21_5_32;
  wire [31:0] out_conv_out_const_22_11_32;
  wire [31:0] out_conv_out_const_23_5_32;
  wire [31:0] out_conv_out_const_24_5_32;
  wire [31:0] out_conv_out_const_25_6_32;
  wire [31:0] out_conv_out_const_28_5_32;
  wire [5:0] out_conv_out_const_2_7_6;
  wire [31:0] out_conv_out_const_30_5_32;
  wire [31:0] out_conv_out_const_31_5_32;
  wire [31:0] out_conv_out_const_32_15_32;
  wire [31:0] out_conv_out_const_33_15_32;
  wire [31:0] out_conv_out_const_3_1_32;
  wire [31:0] out_conv_out_const_6_4_32;
  wire [31:0] out_conv_out_const_7_5_32;
  wire [31:0] out_conv_out_const_8_6_32;
  wire [31:0] out_conv_out_const_9_7_32;
  wire out_lut_expr_FU_38_i0_fu_cnn_top_428531_447327;
  wire out_lut_expr_FU_42_i0_fu_cnn_top_428531_447352;
  wire out_lut_expr_FU_48_i0_fu_cnn_top_428531_447340;
  wire out_lut_expr_FU_51_i0_fu_cnn_top_428531_447358;
  wire out_read_cond_FU_11_i0_fu_cnn_top_428531_428575;
  wire out_read_cond_FU_22_i0_fu_cnn_top_428531_446010;
  wire out_read_cond_FU_33_i0_fu_cnn_top_428531_446014;
  wire out_read_cond_FU_43_i0_fu_cnn_top_428531_446026;
  wire out_read_cond_FU_52_i0_fu_cnn_top_428531_446030;
  wire [31:0] out_reg_0_reg_0;
  wire [7:0] out_reg_10_reg_10;
  wire [7:0] out_reg_11_reg_11;
  wire [31:0] out_reg_12_reg_12;
  wire [31:0] out_reg_13_reg_13;
  wire [31:0] out_reg_14_reg_14;
  wire [31:0] out_reg_15_reg_15;
  wire [31:0] out_reg_16_reg_16;
  wire [31:0] out_reg_17_reg_17;
  wire [4:0] out_reg_18_reg_18;
  wire [15:0] out_reg_19_reg_19;
  wire [31:0] out_reg_1_reg_1;
  wire [31:0] out_reg_20_reg_20;
  wire [4:0] out_reg_21_reg_21;
  wire out_reg_22_reg_22;
  wire [31:0] out_reg_23_reg_23;
  wire [31:0] out_reg_24_reg_24;
  wire [28:0] out_reg_25_reg_25;
  wire [31:0] out_reg_26_reg_26;
  wire [31:0] out_reg_27_reg_27;
  wire [31:0] out_reg_28_reg_28;
  wire [31:0] out_reg_29_reg_29;
  wire [31:0] out_reg_2_reg_2;
  wire [31:0] out_reg_30_reg_30;
  wire [31:0] out_reg_31_reg_31;
  wire out_reg_32_reg_32;
  wire [7:0] out_reg_33_reg_33;
  wire [7:0] out_reg_34_reg_34;
  wire [9:0] out_reg_35_reg_35;
  wire [7:0] out_reg_36_reg_36;
  wire [7:0] out_reg_37_reg_37;
  wire [15:0] out_reg_38_reg_38;
  wire [31:0] out_reg_39_reg_39;
  wire [31:0] out_reg_3_reg_3;
  wire [2:0] out_reg_40_reg_40;
  wire out_reg_41_reg_41;
  wire [2:0] out_reg_42_reg_42;
  wire out_reg_43_reg_43;
  wire [31:0] out_reg_4_reg_4;
  wire [31:0] out_reg_5_reg_5;
  wire [31:0] out_reg_6_reg_6;
  wire [31:0] out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire out_reg_9_reg_9;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_54_i0_fu_cnn_top_428531_447721;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_54_i1_fu_cnn_top_428531_447740;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_55_i0_fu_cnn_top_428531_445775;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_55_i1_fu_cnn_top_428531_445982;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_56_i0_fu_cnn_top_428531_445942;
  wire [2:0] out_ui_bit_and_expr_FU_8_0_8_56_i1_fu_cnn_top_428531_445996;
  wire [29:0] out_ui_bit_ior_concat_expr_FU_57_i0_fu_cnn_top_428531_445767;
  wire [29:0] out_ui_bit_ior_concat_expr_FU_57_i1_fu_cnn_top_428531_445976;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_58_i0_fu_cnn_top_428531_428558;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_58_i1_fu_cnn_top_428531_445936;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_59_i0_fu_cnn_top_428531_428563;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_59_i1_fu_cnn_top_428531_445842;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_60_i0_fu_cnn_top_428531_428568;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_60_i1_fu_cnn_top_428531_445859;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_61_i0_fu_cnn_top_428531_445872;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_62_i0_fu_cnn_top_428531_445893;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_63_i0_fu_cnn_top_428531_445906;
  wire [31:0] out_ui_bit_ior_expr_FU_32_0_32_64_i0_fu_cnn_top_428531_445923;
  wire [2:0] out_ui_bit_xor_expr_FU_8_0_8_65_i0_fu_cnn_top_428531_445939;
  wire [2:0] out_ui_bit_xor_expr_FU_8_0_8_65_i1_fu_cnn_top_428531_445993;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_66_i0_fu_cnn_top_428531_440966;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_66_i1_fu_cnn_top_428531_445953;
  wire out_ui_eq_expr_FU_32_0_32_67_i0_fu_cnn_top_428531_447225;
  wire out_ui_eq_expr_FU_32_0_32_68_i0_fu_cnn_top_428531_447244;
  wire out_ui_eq_expr_FU_32_32_32_69_i0_fu_cnn_top_428531_447287;
  wire out_ui_extract_bit_expr_FU_35_i0_fu_cnn_top_428531_448000;
  wire out_ui_extract_bit_expr_FU_36_i0_fu_cnn_top_428531_448004;
  wire out_ui_extract_bit_expr_FU_37_i0_fu_cnn_top_428531_448008;
  wire out_ui_extract_bit_expr_FU_41_i0_fu_cnn_top_428531_448012;
  wire out_ui_extract_bit_expr_FU_45_i0_fu_cnn_top_428531_448020;
  wire out_ui_extract_bit_expr_FU_46_i0_fu_cnn_top_428531_448024;
  wire out_ui_extract_bit_expr_FU_47_i0_fu_cnn_top_428531_448028;
  wire out_ui_extract_bit_expr_FU_50_i0_fu_cnn_top_428531_448032;
  wire [4:0] out_ui_lshift_expr_FU_32_0_32_70_i0_fu_cnn_top_428531_445778;
  wire [4:0] out_ui_lshift_expr_FU_32_0_32_70_i1_fu_cnn_top_428531_445985;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_71_i0_fu_cnn_top_428531_447325;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_71_i1_fu_cnn_top_428531_447338;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_71_i2_fu_cnn_top_428531_447674;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_72_i0_fu_cnn_top_428531_447686;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_72_i1_fu_cnn_top_428531_447708;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_73_i0_fu_cnn_top_428531_447694;
  wire [29:0] out_ui_lshift_expr_FU_32_0_32_74_i0_fu_cnn_top_428531_447718;
  wire [29:0] out_ui_lshift_expr_FU_32_0_32_74_i1_fu_cnn_top_428531_447737;
  wire [22:0] out_ui_lshift_expr_FU_32_32_32_75_i0_ui_lshift_expr_FU_32_32_32_75_i0;
  wire [4:0] out_ui_lshift_expr_FU_8_0_8_76_i0_fu_cnn_top_428531_447729;
  wire [4:0] out_ui_lshift_expr_FU_8_0_8_76_i1_fu_cnn_top_428531_447748;
  wire [31:0] out_ui_minus_expr_FU_32_32_32_77_i0_fu_cnn_top_428531_446019;
  wire [31:0] out_ui_negate_expr_FU_32_32_78_i0_fu_cnn_top_428531_445944;
  wire [31:0] out_ui_negate_expr_FU_32_32_78_i1_fu_cnn_top_428531_445998;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_79_i0_fu_cnn_top_428531_446004;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_79_i1_fu_cnn_top_428531_446007;
  wire [29:0] out_ui_plus_expr_FU_32_0_32_80_i0_fu_cnn_top_428531_447671;
  wire [25:0] out_ui_plus_expr_FU_32_0_32_80_i1_fu_cnn_top_428531_447683;
  wire [28:0] out_ui_plus_expr_FU_32_0_32_80_i2_fu_cnn_top_428531_447691;
  wire [25:0] out_ui_plus_expr_FU_32_0_32_80_i3_fu_cnn_top_428531_447705;
  wire [28:0] out_ui_plus_expr_FU_32_0_32_81_i0_fu_cnn_top_428531_447715;
  wire [28:0] out_ui_plus_expr_FU_32_0_32_81_i1_fu_cnn_top_428531_447734;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_82_i0_fu_cnn_top_428531_440963;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_82_i1_fu_cnn_top_428531_445950;
  wire [8:0] out_ui_plus_expr_FU_8_8_8_83_i0_fu_cnn_top_428531_445844;
  wire [8:0] out_ui_plus_expr_FU_8_8_8_83_i1_fu_cnn_top_428531_445908;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i0_fu_cnn_top_428531_428554;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i10_fu_cnn_top_428531_445837;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i11_fu_cnn_top_428531_445854;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i12_fu_cnn_top_428531_445867;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i13_fu_cnn_top_428531_445888;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i14_fu_cnn_top_428531_445901;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i15_fu_cnn_top_428531_445918;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i16_fu_cnn_top_428531_445931;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i17_fu_cnn_top_428531_445971;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i1_fu_cnn_top_428531_428556;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i2_fu_cnn_top_428531_428559;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i3_fu_cnn_top_428531_428561;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i4_fu_cnn_top_428531_428564;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i5_fu_cnn_top_428531_428566;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i6_fu_cnn_top_428531_428569;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i7_fu_cnn_top_428531_428571;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i8_fu_cnn_top_428531_440984;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_84_i9_fu_cnn_top_428531_445821;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_85_i0_fu_cnn_top_428531_445771;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_85_i1_fu_cnn_top_428531_445979;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_86_i0_fu_cnn_top_428531_447668;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_86_i1_fu_cnn_top_428531_447677;
  wire [25:0] out_ui_rshift_expr_FU_32_0_32_87_i0_fu_cnn_top_428531_447681;
  wire [25:0] out_ui_rshift_expr_FU_32_0_32_87_i1_fu_cnn_top_428531_447703;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_88_i0_fu_cnn_top_428531_447689;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_88_i1_fu_cnn_top_428531_447697;
  wire [28:0] out_ui_rshift_expr_FU_32_0_32_88_i2_fu_cnn_top_428531_447700;
  wire [27:0] out_ui_rshift_expr_FU_32_0_32_89_i0_fu_cnn_top_428531_447711;
  wire [27:0] out_ui_rshift_expr_FU_32_0_32_89_i1_fu_cnn_top_428531_447732;
  wire [3:0] out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0;
  wire [2:0] out_ui_rshift_expr_FU_8_0_8_91_i0_fu_cnn_top_428531_447725;
  wire [2:0] out_ui_rshift_expr_FU_8_0_8_91_i1_fu_cnn_top_428531_447744;
  wire [15:0] out_ui_ternary_plus_expr_FU_16_16_16_16_92_i0_fu_cnn_top_428531_445795;
  wire [9:0] out_ui_ternary_plus_expr_FU_16_16_16_16_92_i1_fu_cnn_top_428531_445804;
  wire [9:0] out_ui_ternary_plus_expr_FU_16_16_16_16_92_i2_fu_cnn_top_428531_445874;
  wire [31:0] out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0;
  wire [7:0] out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1;
  wire [7:0] out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2;
  wire [7:0] out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3;
  wire [7:0] out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4;
  wire [31:0] out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5;
  wire [31:0] out_uu_conv_conn_obj_6_UUdata_converter_FU_uu_conv_6;
  wire [31:0] out_uu_conv_conn_obj_7_UUdata_converter_FU_uu_conv_7;
  wire [15:0] out_uu_conv_conn_obj_8_UUdata_converter_FU_uu_conv_8;
  wire s_conv_layer_93_i00;
  wire s_done_conv_layer_93_i0;
  wire [63:0] sig_out_vector_bus_mergerproxy_in15_;
  wire [63:0] sig_out_vector_bus_mergerproxy_in2r6_;
  wire [63:0] sig_out_vector_bus_mergerproxy_in2w7_;
  wire [11:0] sig_out_vector_bus_mergerproxy_in3r8_;
  wire [11:0] sig_out_vector_bus_mergerproxy_in3w9_;
  wire [1:0] sig_out_vector_bus_mergerproxy_in4r10_;
  wire [1:0] sig_out_vector_bus_mergerproxy_in4w11_;
  wire [1:0] sig_out_vector_bus_mergerproxy_sel_LOAD12_;
  wire [1:0] sig_out_vector_bus_mergerproxy_sel_STORE13_;
  
  BMEMORY_CTRLN #(.BITSIZE_in1(1),
    .PORTSIZE_in1(2),
    .BITSIZE_in2(32),
    .PORTSIZE_in2(2),
    .BITSIZE_in3(6),
    .PORTSIZE_in3(2),
    .BITSIZE_in4(1),
    .PORTSIZE_in4(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_out1(8),
    .PORTSIZE_out1(2),
    .BITSIZE_Min_oe_ram(1),
    .PORTSIZE_Min_oe_ram(2),
    .BITSIZE_Min_we_ram(1),
    .PORTSIZE_Min_we_ram(2),
    .BITSIZE_Mout_oe_ram(1),
    .PORTSIZE_Mout_oe_ram(2),
    .BITSIZE_Mout_we_ram(1),
    .PORTSIZE_Mout_we_ram(2),
    .BITSIZE_M_DataRdy(1),
    .PORTSIZE_M_DataRdy(2),
    .BITSIZE_Min_addr_ram(32),
    .PORTSIZE_Min_addr_ram(2),
    .BITSIZE_Mout_addr_ram(32),
    .PORTSIZE_Mout_addr_ram(2),
    .BITSIZE_M_Rdata_ram(32),
    .PORTSIZE_M_Rdata_ram(2),
    .BITSIZE_Min_Wdata_ram(32),
    .PORTSIZE_Min_Wdata_ram(2),
    .BITSIZE_Mout_Wdata_ram(32),
    .PORTSIZE_Mout_Wdata_ram(2),
    .BITSIZE_Min_data_ram_size(6),
    .PORTSIZE_Min_data_ram_size(2),
    .BITSIZE_Mout_data_ram_size(6),
    .PORTSIZE_Mout_data_ram_size(2)) BMEMORY_CTRLN_53_i0 (.out1({out_BMEMORY_CTRLN_53_i1_BMEMORY_CTRLN_53_i0,
      out_BMEMORY_CTRLN_53_i0_BMEMORY_CTRLN_53_i0}),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .in1({1'b0,
      1'b0}),
    .in2({out_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0,
      out_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0}),
    .in3({out_conv_out_const_1_5_6,
      out_conv_out_const_1_5_6}),
    .in4({out_const_3,
      out_const_3}),
    .sel_LOAD({fuselector_BMEMORY_CTRLN_53_i1_LOAD,
      fuselector_BMEMORY_CTRLN_53_i0_LOAD}),
    .sel_STORE({fuselector_BMEMORY_CTRLN_53_i1_STORE,
      fuselector_BMEMORY_CTRLN_53_i0_STORE}),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(8),
    .BITSIZE_in2(8),
    .BITSIZE_out1(8)) MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0 (.out1(out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0),
    .sel(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0),
    .in1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in2(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0 (.out1(out_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0),
    .sel(selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0),
    .in1(out_reg_39_reg_39),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_84_i8_fu_cnn_top_428531_440984));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_17_BMEMORY_CTRLN_53_i0_1_0_0 (.out1(out_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0),
    .sel(selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0),
    .in1(out_reg_5_reg_5),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_84_i0_fu_cnn_top_428531_428554));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0 (.out1(out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .sel(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .in1(out_reg_31_reg_31),
    .in2(out_reg_29_reg_29));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1 (.out1(out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .sel(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .in1(out_reg_26_reg_26),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_84_i9_fu_cnn_top_428531_445821));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0 (.out1(out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0),
    .sel(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0),
    .in1(out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .in2(out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1));
  MUX_GATE #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0 (.out1(out_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0),
    .sel(selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0),
    .in1(out_reg_42_reg_42),
    .in2(out_reg_40_reg_40));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_20_BMEMORY_CTRLN_53_i1_1_0_0 (.out1(out_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0),
    .sel(selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0),
    .in1(out_reg_7_reg_7),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_84_i2_fu_cnn_top_428531_428559));
  MUX_GATE #(.BITSIZE_in1(5),
    .BITSIZE_in2(5),
    .BITSIZE_out1(5)) MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0 (.out1(out_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0),
    .sel(selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0),
    .in1(out_reg_21_reg_21),
    .in2(out_reg_18_reg_18));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0 (.out1(out_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0),
    .sel(selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0),
    .in1(out_reg_6_reg_6),
    .in2(out_reg_3_reg_3));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_44_conv_layer_93_i0_0_0_0 (.out1(out_MUX_44_conv_layer_93_i0_0_0_0),
    .sel(selector_MUX_44_conv_layer_93_i0_0_0_0),
    .in1(out_conv_out_const_0_1_32),
    .in2(out_conv_out_const_12_13_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_45_conv_layer_93_i0_1_0_0 (.out1(out_MUX_45_conv_layer_93_i0_1_0_0),
    .sel(selector_MUX_45_conv_layer_93_i0_1_0_0),
    .in1(out_conv_out_const_0_1_32),
    .in2(out_conv_out_const_12_13_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_46_conv_layer_93_i0_2_0_0 (.out1(out_MUX_46_conv_layer_93_i0_2_0_0),
    .sel(selector_MUX_46_conv_layer_93_i0_2_0_0),
    .in1(out_conv_out_const_0_1_32),
    .in2(out_conv_out_const_14_10_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_46_conv_layer_93_i0_2_0_1 (.out1(out_MUX_46_conv_layer_93_i0_2_0_1),
    .sel(selector_MUX_46_conv_layer_93_i0_2_0_1),
    .in1(out_conv_out_const_15_4_32),
    .in2(out_conv_out_const_18_8_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_46_conv_layer_93_i0_2_0_2 (.out1(out_MUX_46_conv_layer_93_i0_2_0_2),
    .sel(selector_MUX_46_conv_layer_93_i0_2_0_2),
    .in1(out_conv_out_const_22_11_32),
    .in2(out_MUX_46_conv_layer_93_i0_2_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_46_conv_layer_93_i0_2_1_0 (.out1(out_MUX_46_conv_layer_93_i0_2_1_0),
    .sel(selector_MUX_46_conv_layer_93_i0_2_1_0),
    .in1(out_MUX_46_conv_layer_93_i0_2_0_1),
    .in2(out_MUX_46_conv_layer_93_i0_2_0_2));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_47_conv_layer_93_i0_3_0_0 (.out1(out_MUX_47_conv_layer_93_i0_3_0_0),
    .sel(selector_MUX_47_conv_layer_93_i0_3_0_0),
    .in1(out_conv_out_const_0_1_32),
    .in2(out_conv_out_const_6_4_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_47_conv_layer_93_i0_3_0_1 (.out1(out_MUX_47_conv_layer_93_i0_3_0_1),
    .sel(selector_MUX_47_conv_layer_93_i0_3_0_1),
    .in1(out_conv_out_const_19_7_32),
    .in2(out_conv_out_const_25_6_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_47_conv_layer_93_i0_3_0_2 (.out1(out_MUX_47_conv_layer_93_i0_3_0_2),
    .sel(selector_MUX_47_conv_layer_93_i0_3_0_2),
    .in1(out_conv_out_const_28_5_32),
    .in2(out_MUX_47_conv_layer_93_i0_3_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_47_conv_layer_93_i0_3_1_0 (.out1(out_MUX_47_conv_layer_93_i0_3_1_0),
    .sel(selector_MUX_47_conv_layer_93_i0_3_1_0),
    .in1(out_MUX_47_conv_layer_93_i0_3_0_1),
    .in2(out_MUX_47_conv_layer_93_i0_3_0_2));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_48_conv_layer_93_i0_4_0_0 (.out1(out_MUX_48_conv_layer_93_i0_4_0_0),
    .sel(selector_MUX_48_conv_layer_93_i0_4_0_0),
    .in1(out_conv_out_const_3_1_32),
    .in2(out_conv_out_const_6_4_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_48_conv_layer_93_i0_4_0_1 (.out1(out_MUX_48_conv_layer_93_i0_4_0_1),
    .sel(selector_MUX_48_conv_layer_93_i0_4_0_1),
    .in1(out_conv_out_const_7_5_32),
    .in2(out_conv_out_const_24_5_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_48_conv_layer_93_i0_4_0_2 (.out1(out_MUX_48_conv_layer_93_i0_4_0_2),
    .sel(selector_MUX_48_conv_layer_93_i0_4_0_2),
    .in1(out_conv_out_const_31_5_32),
    .in2(out_MUX_48_conv_layer_93_i0_4_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_48_conv_layer_93_i0_4_1_0 (.out1(out_MUX_48_conv_layer_93_i0_4_1_0),
    .sel(selector_MUX_48_conv_layer_93_i0_4_1_0),
    .in1(out_MUX_48_conv_layer_93_i0_4_0_1),
    .in2(out_MUX_48_conv_layer_93_i0_4_0_2));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_49_conv_layer_93_i0_5_0_0 (.out1(out_MUX_49_conv_layer_93_i0_5_0_0),
    .sel(selector_MUX_49_conv_layer_93_i0_5_0_0),
    .in1(out_conv_out_const_6_4_32),
    .in2(out_conv_out_const_7_5_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_49_conv_layer_93_i0_5_0_1 (.out1(out_MUX_49_conv_layer_93_i0_5_0_1),
    .sel(selector_MUX_49_conv_layer_93_i0_5_0_1),
    .in1(out_conv_out_const_24_5_32),
    .in2(out_conv_out_const_30_5_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_49_conv_layer_93_i0_5_0_2 (.out1(out_MUX_49_conv_layer_93_i0_5_0_2),
    .sel(selector_MUX_49_conv_layer_93_i0_5_0_2),
    .in1(out_conv_out_const_31_5_32),
    .in2(out_MUX_49_conv_layer_93_i0_5_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_49_conv_layer_93_i0_5_1_0 (.out1(out_MUX_49_conv_layer_93_i0_5_1_0),
    .sel(selector_MUX_49_conv_layer_93_i0_5_1_0),
    .in1(out_MUX_49_conv_layer_93_i0_5_0_1),
    .in2(out_MUX_49_conv_layer_93_i0_5_0_2));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_50_conv_layer_93_i0_6_0_0 (.out1(out_MUX_50_conv_layer_93_i0_6_0_0),
    .sel(selector_MUX_50_conv_layer_93_i0_6_0_0),
    .in1(out_conv_out_const_6_4_32),
    .in2(out_conv_out_const_7_5_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_50_conv_layer_93_i0_6_0_1 (.out1(out_MUX_50_conv_layer_93_i0_6_0_1),
    .sel(selector_MUX_50_conv_layer_93_i0_6_0_1),
    .in1(out_conv_out_const_8_6_32),
    .in2(out_conv_out_const_9_7_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_50_conv_layer_93_i0_6_1_0 (.out1(out_MUX_50_conv_layer_93_i0_6_1_0),
    .sel(selector_MUX_50_conv_layer_93_i0_6_1_0),
    .in1(out_MUX_50_conv_layer_93_i0_6_0_0),
    .in2(out_MUX_50_conv_layer_93_i0_6_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_51_conv_layer_93_i0_7_0_0 (.out1(out_MUX_51_conv_layer_93_i0_7_0_0),
    .sel(selector_MUX_51_conv_layer_93_i0_7_0_0),
    .in1(out_conv_out_const_9_7_32),
    .in2(out_conv_out_const_10_9_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_51_conv_layer_93_i0_7_0_1 (.out1(out_MUX_51_conv_layer_93_i0_7_0_1),
    .sel(selector_MUX_51_conv_layer_93_i0_7_0_1),
    .in1(out_conv_out_const_11_11_32),
    .in2(out_conv_out_const_12_13_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_51_conv_layer_93_i0_7_1_0 (.out1(out_MUX_51_conv_layer_93_i0_7_1_0),
    .sel(selector_MUX_51_conv_layer_93_i0_7_1_0),
    .in1(out_MUX_51_conv_layer_93_i0_7_0_0),
    .in2(out_MUX_51_conv_layer_93_i0_7_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_52_conv_layer_93_i0_8_0_0 (.out1(out_MUX_52_conv_layer_93_i0_8_0_0),
    .sel(selector_MUX_52_conv_layer_93_i0_8_0_0),
    .in1(out_conv_out_const_17_5_32),
    .in2(out_conv_out_const_21_5_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_52_conv_layer_93_i0_8_0_1 (.out1(out_MUX_52_conv_layer_93_i0_8_0_1),
    .sel(selector_MUX_52_conv_layer_93_i0_8_0_1),
    .in1(out_conv_out_const_23_5_32),
    .in2(out_conv_out_const_24_5_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_52_conv_layer_93_i0_8_1_0 (.out1(out_MUX_52_conv_layer_93_i0_8_1_0),
    .sel(selector_MUX_52_conv_layer_93_i0_8_1_0),
    .in1(out_MUX_52_conv_layer_93_i0_8_0_0),
    .in2(out_MUX_52_conv_layer_93_i0_8_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_53_conv_layer_93_i0_9_0_0 (.out1(out_MUX_53_conv_layer_93_i0_9_0_0),
    .sel(selector_MUX_53_conv_layer_93_i0_9_0_0),
    .in1(out_conv_out_const_0_1_32),
    .in2(out_conv_out_const_3_1_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_72_reg_0_0_0_0 (.out1(out_MUX_72_reg_0_0_0_0),
    .sel(selector_MUX_72_reg_0_0_0_0),
    .in1(out_ui_lshift_expr_FU_32_0_32_71_i2_fu_cnn_top_428531_447674),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_76_reg_12_0_0_0 (.out1(out_MUX_76_reg_12_0_0_0),
    .sel(selector_MUX_76_reg_12_0_0_0),
    .in1(out_ui_lshift_expr_FU_32_0_32_72_i0_fu_cnn_top_428531_447686),
    .in2(out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_77_reg_13_0_0_0 (.out1(out_MUX_77_reg_13_0_0_0),
    .sel(selector_MUX_77_reg_13_0_0_0),
    .in1(out_ui_plus_expr_FU_32_32_32_82_i0_fu_cnn_top_428531_440963),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_78_reg_14_0_0_0 (.out1(out_MUX_78_reg_14_0_0_0),
    .sel(selector_MUX_78_reg_14_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_79_i0_fu_cnn_top_428531_446004),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_79_reg_15_0_0_0 (.out1(out_MUX_79_reg_15_0_0_0),
    .sel(selector_MUX_79_reg_15_0_0_0),
    .in1(out_ui_lshift_expr_FU_32_0_32_72_i1_fu_cnn_top_428531_447708),
    .in2(out_uu_conv_conn_obj_6_UUdata_converter_FU_uu_conv_6));
  MUX_GATE #(.BITSIZE_in1(8),
    .BITSIZE_in2(8),
    .BITSIZE_out1(8)) MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0 (.out1(out_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0),
    .sel(selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0),
    .in1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in2(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_80_reg_16_0_0_0 (.out1(out_MUX_80_reg_16_0_0_0),
    .sel(selector_MUX_80_reg_16_0_0_0),
    .in1(out_ui_plus_expr_FU_32_32_32_82_i1_fu_cnn_top_428531_445950),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_81_reg_17_0_0_0 (.out1(out_MUX_81_reg_17_0_0_0),
    .sel(selector_MUX_81_reg_17_0_0_0),
    .in1(out_ui_plus_expr_FU_32_0_32_79_i1_fu_cnn_top_428531_446007),
    .in2(out_uu_conv_conn_obj_7_UUdata_converter_FU_uu_conv_7));
  MUX_GATE #(.BITSIZE_in1(16),
    .BITSIZE_in2(16),
    .BITSIZE_out1(16)) MUX_83_reg_19_0_0_0 (.out1(out_MUX_83_reg_19_0_0_0),
    .sel(selector_MUX_83_reg_19_0_0_0),
    .in1(out_ui_ternary_plus_expr_FU_16_16_16_16_92_i0_fu_cnn_top_428531_445795),
    .in2(out_uu_conv_conn_obj_8_UUdata_converter_FU_uu_conv_8));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_85_reg_20_0_0_0 (.out1(out_MUX_85_reg_20_0_0_0),
    .sel(selector_MUX_85_reg_20_0_0_0),
    .in1(out_reg_15_reg_15),
    .in2(out_ui_lshift_expr_FU_32_0_32_73_i0_fu_cnn_top_428531_447694));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0 (.out1(out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0),
    .sel(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0),
    .in1(out_reg_30_reg_30),
    .in2(out_reg_28_reg_28));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1 (.out1(out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1),
    .sel(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1),
    .in1(out_reg_27_reg_27),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_84_i10_fu_cnn_top_428531_445837));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0 (.out1(out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0),
    .sel(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0),
    .in1(out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0),
    .in2(out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0 (.out1(out_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0),
    .sel(selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0),
    .in1(out_reg_8_reg_8),
    .in2(out_reg_4_reg_4));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_0 (.out1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in1(out_conv_out_const_0_1_32));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) UUdata_converter_FU_uu_conv_1 (.out1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in1(out_reg_10_reg_10));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) UUdata_converter_FU_uu_conv_2 (.out1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in1(out_reg_11_reg_11));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) UUdata_converter_FU_uu_conv_3 (.out1(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3),
    .in1(out_reg_10_reg_10));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) UUdata_converter_FU_uu_conv_4 (.out1(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4),
    .in1(out_reg_11_reg_11));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_5 (.out1(out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5),
    .in1(out_conv_out_const_13_13_32));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_6 (.out1(out_uu_conv_conn_obj_6_UUdata_converter_FU_uu_conv_6),
    .in1(out_conv_out_const_12_13_32));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_7 (.out1(out_uu_conv_conn_obj_7_UUdata_converter_FU_uu_conv_7),
    .in1(out_conv_out_const_30_5_32));
  UUdata_converter_FU #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) UUdata_converter_FU_uu_conv_8 (.out1(out_uu_conv_conn_obj_8_UUdata_converter_FU_uu_conv_8),
    .in1(out_conv_out_const_0_1_16));
  ARRAY_1D_STD_BRAM_NN_SDS #(.BITSIZE_in1(8),
    .PORTSIZE_in1(2),
    .BITSIZE_in2r(32),
    .PORTSIZE_in2r(2),
    .BITSIZE_in2w(32),
    .PORTSIZE_in2w(2),
    .BITSIZE_in3r(6),
    .PORTSIZE_in3r(2),
    .BITSIZE_in3w(6),
    .PORTSIZE_in3w(2),
    .BITSIZE_in4r(1),
    .PORTSIZE_in4r(2),
    .BITSIZE_in4w(1),
    .PORTSIZE_in4w(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(8),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("array_ref_428598.mem"),
    .n_elements(12288),
    .data_size(8),
    .address_space_begin(MEM_var_428598_428531),
    .address_space_rangesize(16384),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(0),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(8),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2r(32),
    .PORTSIZE_proxy_in2r(2),
    .BITSIZE_proxy_in2w(32),
    .PORTSIZE_proxy_in2w(2),
    .BITSIZE_proxy_in3r(6),
    .PORTSIZE_proxy_in3r(2),
    .BITSIZE_proxy_in3w(6),
    .PORTSIZE_proxy_in3w(2),
    .BITSIZE_proxy_in4r(1),
    .PORTSIZE_proxy_in4r(2),
    .BITSIZE_proxy_in4w(1),
    .PORTSIZE_proxy_in4w(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_428598_0 (.out1({out_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_array_428598_0,
      out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_428598_0}),
    .Sout_Rdata_ram({null_out_signal_array_428598_0_Sout_Rdata_ram_1,
      null_out_signal_array_428598_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_428598_0_Sout_DataRdy_1,
      null_out_signal_array_428598_0_Sout_DataRdy_0}),
    .proxy_out1(Sproxy_out1_428598),
    .clock(clock),
    .reset(reset),
    .in1({out_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0,
      out_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0}),
    .in2r({out_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0,
      out_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0}),
    .in2w({out_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0,
      out_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0}),
    .in3r({out_conv_out_const_1_5_6,
      out_conv_out_const_1_5_6}),
    .in3w({out_conv_out_const_1_5_6,
      out_conv_out_const_1_5_6}),
    .in4r({out_const_3,
      out_const_3}),
    .in4w({out_const_3,
      out_const_3}),
    .sel_LOAD({fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD,
      fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD}),
    .sel_STORE({fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE,
      fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1(sig_out_vector_bus_mergerproxy_in15_),
    .proxy_in2r(sig_out_vector_bus_mergerproxy_in2r6_),
    .proxy_in2w(sig_out_vector_bus_mergerproxy_in2w7_),
    .proxy_in3r(sig_out_vector_bus_mergerproxy_in3r8_),
    .proxy_in3w(sig_out_vector_bus_mergerproxy_in3w9_),
    .proxy_in4r(sig_out_vector_bus_mergerproxy_in4r10_),
    .proxy_in4w(sig_out_vector_bus_mergerproxy_in4w11_),
    .proxy_sel_LOAD(sig_out_vector_bus_mergerproxy_sel_LOAD12_),
    .proxy_sel_STORE(sig_out_vector_bus_mergerproxy_sel_STORE13_));
  ARRAY_1D_STD_BRAM_NN_SDS #(.BITSIZE_in1(32),
    .PORTSIZE_in1(2),
    .BITSIZE_in2r(32),
    .PORTSIZE_in2r(2),
    .BITSIZE_in2w(32),
    .PORTSIZE_in2w(2),
    .BITSIZE_in3r(6),
    .PORTSIZE_in3r(2),
    .BITSIZE_in3w(6),
    .PORTSIZE_in3w(2),
    .BITSIZE_in4r(1),
    .PORTSIZE_in4r(2),
    .BITSIZE_in4w(1),
    .PORTSIZE_in4w(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(32),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("array_ref_440988.mem"),
    .n_elements(2390),
    .data_size(32),
    .address_space_begin(MEM_var_440988_428530),
    .address_space_rangesize(16384),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(32),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2r(32),
    .PORTSIZE_proxy_in2r(2),
    .BITSIZE_proxy_in2w(32),
    .PORTSIZE_proxy_in2w(2),
    .BITSIZE_proxy_in3r(6),
    .PORTSIZE_proxy_in3r(2),
    .BITSIZE_proxy_in3w(6),
    .PORTSIZE_proxy_in3w(2),
    .BITSIZE_proxy_in4r(1),
    .PORTSIZE_proxy_in4r(2),
    .BITSIZE_proxy_in4w(1),
    .PORTSIZE_proxy_in4w(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_440988_0 (.out1({null_out_signal_array_440988_0_out1_1,
      out_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_array_440988_0}),
    .Sout_Rdata_ram({null_out_signal_array_440988_0_Sout_Rdata_ram_1,
      null_out_signal_array_440988_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_440988_0_Sout_DataRdy_1,
      null_out_signal_array_440988_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_440988_0_proxy_out1_1,
      null_out_signal_array_440988_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in2r({32'b00000000000000000000000000000000,
      out_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0}),
    .in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .in3r({6'b000000,
      out_conv_out_const_2_7_6}),
    .in3w({6'b000000,
      6'b000000}),
    .in4r({1'b0,
      out_const_3}),
    .in4w({1'b0,
      1'b0}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2r({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2w({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in3r({6'b000000,
      6'b000000}),
    .proxy_in3w({6'b000000,
      6'b000000}),
    .proxy_in4r({1'b0,
      1'b0}),
    .proxy_in4w({1'b0,
      1'b0}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b01000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(9),
    .value(9'b100000000)) const_10 (.out1(out_const_10));
  constant_value #(.BITSIZE_out1(11),
    .value(11'b10000000000)) const_11 (.out1(out_const_11));
  constant_value #(.BITSIZE_out1(13),
    .value(13'b1000000000000)) const_12 (.out1(out_const_12));
  constant_value #(.BITSIZE_out1(13),
    .value(13'b1000001000000)) const_13 (.out1(out_const_13));
  constant_value #(.BITSIZE_out1(10),
    .value(10'b1000110111)) const_14 (.out1(out_const_14));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1001)) const_15 (.out1(out_const_15));
  constant_value #(.BITSIZE_out1(11),
    .value(11'b10010100111)) const_16 (.out1(out_const_16));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10011)) const_17 (.out1(out_const_17));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b10011001)) const_18 (.out1(out_const_18));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b1001110)) const_19 (.out1(out_const_19));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b101)) const_20 (.out1(out_const_20));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10101)) const_21 (.out1(out_const_21));
  constant_value #(.BITSIZE_out1(11),
    .value(11'b10101011010)) const_22 (.out1(out_const_22));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10110)) const_23 (.out1(out_const_23));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10111)) const_24 (.out1(out_const_24));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b101111)) const_25 (.out1(out_const_25));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_26 (.out1(out_const_26));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b110)) const_27 (.out1(out_const_27));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11000)) const_28 (.out1(out_const_28));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b111)) const_29 (.out1(out_const_29));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11101)) const_30 (.out1(out_const_30));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11111)) const_31 (.out1(out_const_31));
  constant_value #(.BITSIZE_out1(15),
    .value(MEM_var_428598_428531)) const_32 (.out1(out_const_32));
  constant_value #(.BITSIZE_out1(15),
    .value(MEM_var_440988_428530)) const_33 (.out1(out_const_33));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b100)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1000)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10000)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b100000)) const_8 (.out1(out_const_8));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b1000000)) const_9 (.out1(out_const_9));
  conv_layer #(.MEM_var_428598_428531(MEM_var_428598_428531),
    .MEM_var_440988_428530(MEM_var_440988_428530),
    .MEM_var_446454_428530(MEM_var_446454_428530),
    .MEM_var_446587_428530(MEM_var_446587_428530)) conv_layer_93_i0 (.done_port(s_done_conv_layer_93_i0),
    .proxy_in1_428598(sig_out_vector_bus_mergerproxy_in15_),
    .proxy_in2r_428598(sig_out_vector_bus_mergerproxy_in2r6_),
    .proxy_in2w_428598(sig_out_vector_bus_mergerproxy_in2w7_),
    .proxy_in3r_428598(sig_out_vector_bus_mergerproxy_in3r8_),
    .proxy_in3w_428598(sig_out_vector_bus_mergerproxy_in3w9_),
    .proxy_in4r_428598(sig_out_vector_bus_mergerproxy_in4r10_),
    .proxy_in4w_428598(sig_out_vector_bus_mergerproxy_in4w11_),
    .proxy_sel_LOAD_428598(sig_out_vector_bus_mergerproxy_sel_LOAD12_),
    .proxy_sel_STORE_428598(sig_out_vector_bus_mergerproxy_sel_STORE13_),
    .clock(clock),
    .reset(reset),
    .start_port(s_conv_layer_93_i00),
    .in_off(out_MUX_44_conv_layer_93_i0_0_0_0),
    .out_off(out_MUX_45_conv_layer_93_i0_1_0_0),
    .w_off(out_MUX_46_conv_layer_93_i0_2_1_0),
    .m_off(out_MUX_47_conv_layer_93_i0_3_1_0),
    .cin(out_MUX_48_conv_layer_93_i0_4_1_0),
    .cout(out_MUX_49_conv_layer_93_i0_5_1_0),
    .H(out_MUX_50_conv_layer_93_i0_6_1_0),
    .hw(out_MUX_51_conv_layer_93_i0_7_1_0),
    .sh(out_MUX_52_conv_layer_93_i0_8_1_0),
    .pool(out_MUX_53_conv_layer_93_i0_9_0_0),
    .proxy_out1_428598(Sproxy_out1_428598));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(16)) conv_out_const_0_1_16 (.out1(out_conv_out_const_0_1_16),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(32)) conv_out_const_0_1_32 (.out1(out_conv_out_const_0_1_32),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(9),
    .BITSIZE_out1(32)) conv_out_const_10_9_32 (.out1(out_conv_out_const_10_9_32),
    .in1(out_const_10));
  UUdata_converter_FU #(.BITSIZE_in1(11),
    .BITSIZE_out1(32)) conv_out_const_11_11_32 (.out1(out_conv_out_const_11_11_32),
    .in1(out_const_11));
  UUdata_converter_FU #(.BITSIZE_in1(13),
    .BITSIZE_out1(32)) conv_out_const_12_13_32 (.out1(out_conv_out_const_12_13_32),
    .in1(out_const_12));
  UUdata_converter_FU #(.BITSIZE_in1(13),
    .BITSIZE_out1(32)) conv_out_const_13_13_32 (.out1(out_conv_out_const_13_13_32),
    .in1(out_const_13));
  UUdata_converter_FU #(.BITSIZE_in1(10),
    .BITSIZE_out1(32)) conv_out_const_14_10_32 (.out1(out_conv_out_const_14_10_32),
    .in1(out_const_14));
  UUdata_converter_FU #(.BITSIZE_in1(4),
    .BITSIZE_out1(32)) conv_out_const_15_4_32 (.out1(out_conv_out_const_15_4_32),
    .in1(out_const_15));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_17_5_32 (.out1(out_conv_out_const_17_5_32),
    .in1(out_const_17));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(32)) conv_out_const_18_8_32 (.out1(out_conv_out_const_18_8_32),
    .in1(out_const_18));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(32)) conv_out_const_19_7_32 (.out1(out_conv_out_const_19_7_32),
    .in1(out_const_19));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(6)) conv_out_const_1_5_6 (.out1(out_conv_out_const_1_5_6),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_21_5_32 (.out1(out_conv_out_const_21_5_32),
    .in1(out_const_21));
  UUdata_converter_FU #(.BITSIZE_in1(11),
    .BITSIZE_out1(32)) conv_out_const_22_11_32 (.out1(out_conv_out_const_22_11_32),
    .in1(out_const_22));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_23_5_32 (.out1(out_conv_out_const_23_5_32),
    .in1(out_const_23));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_24_5_32 (.out1(out_conv_out_const_24_5_32),
    .in1(out_const_24));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(32)) conv_out_const_25_6_32 (.out1(out_conv_out_const_25_6_32),
    .in1(out_const_25));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_28_5_32 (.out1(out_conv_out_const_28_5_32),
    .in1(out_const_28));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_2_7_6 (.out1(out_conv_out_const_2_7_6),
    .in1(out_const_2));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_30_5_32 (.out1(out_conv_out_const_30_5_32),
    .in1(out_const_30));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_31_5_32 (.out1(out_conv_out_const_31_5_32),
    .in1(out_const_31));
  UUdata_converter_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) conv_out_const_32_15_32 (.out1(out_conv_out_const_32_15_32),
    .in1(out_const_32));
  UUdata_converter_FU #(.BITSIZE_in1(15),
    .BITSIZE_out1(32)) conv_out_const_33_15_32 (.out1(out_conv_out_const_33_15_32),
    .in1(out_const_33));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(32)) conv_out_const_3_1_32 (.out1(out_conv_out_const_3_1_32),
    .in1(out_const_3));
  UUdata_converter_FU #(.BITSIZE_in1(4),
    .BITSIZE_out1(32)) conv_out_const_6_4_32 (.out1(out_conv_out_const_6_4_32),
    .in1(out_const_6));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(32)) conv_out_const_7_5_32 (.out1(out_conv_out_const_7_5_32),
    .in1(out_const_7));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(32)) conv_out_const_8_6_32 (.out1(out_conv_out_const_8_6_32),
    .in1(out_const_8));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(32)) conv_out_const_9_7_32 (.out1(out_conv_out_const_9_7_32),
    .in1(out_const_9));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428554 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i0_fu_cnn_top_428531_428554),
    .in1(in_port_img),
    .in2(out_reg_0_reg_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428556 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i1_fu_cnn_top_428531_428556),
    .in1(out_reg_1_reg_1),
    .in2(out_reg_0_reg_0));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_cnn_top_428531_428558 (.out1(out_ui_bit_ior_expr_FU_32_0_32_58_i0_fu_cnn_top_428531_428558),
    .in1(out_reg_0_reg_0),
    .in2(out_const_3));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428559 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i2_fu_cnn_top_428531_428559),
    .in1(in_port_img),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_58_i0_fu_cnn_top_428531_428558));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428561 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i3_fu_cnn_top_428531_428561),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_58_i0_fu_cnn_top_428531_428558));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32)) fu_cnn_top_428531_428563 (.out1(out_ui_bit_ior_expr_FU_32_0_32_59_i0_fu_cnn_top_428531_428563),
    .in1(out_reg_0_reg_0),
    .in2(out_const_4));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428564 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i4_fu_cnn_top_428531_428564),
    .in1(in_port_img),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_59_i0_fu_cnn_top_428531_428563));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428566 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i5_fu_cnn_top_428531_428566),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_59_i0_fu_cnn_top_428531_428563));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32)) fu_cnn_top_428531_428568 (.out1(out_ui_bit_ior_expr_FU_32_0_32_60_i0_fu_cnn_top_428531_428568),
    .in1(out_reg_0_reg_0),
    .in2(out_const_26));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428569 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i6_fu_cnn_top_428531_428569),
    .in1(in_port_img),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_60_i0_fu_cnn_top_428531_428568));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_428571 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i7_fu_cnn_top_428531_428571),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_60_i0_fu_cnn_top_428531_428568));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_428574 (.out1(out_UUdata_converter_FU_10_i0_fu_cnn_top_428531_428574),
    .in1(out_ui_eq_expr_FU_32_0_32_67_i0_fu_cnn_top_428531_447225));
  read_cond_FU #(.BITSIZE_in1(1)) fu_cnn_top_428531_428575 (.out1(out_read_cond_FU_11_i0_fu_cnn_top_428531_428575),
    .in1(out_reg_9_reg_9));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_440963 (.out1(out_ui_plus_expr_FU_32_32_32_82_i0_fu_cnn_top_428531_440963),
    .in1(out_ui_cond_expr_FU_32_32_32_32_66_i0_fu_cnn_top_428531_440966),
    .in2(out_reg_13_reg_13));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(23),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_440966 (.out1(out_ui_cond_expr_FU_32_32_32_32_66_i0_fu_cnn_top_428531_440966),
    .in1(out_reg_41_reg_41),
    .in2(out_ui_lshift_expr_FU_32_32_32_75_i0_ui_lshift_expr_FU_32_32_32_75_i0),
    .in3(out_ui_negate_expr_FU_32_32_78_i0_fu_cnn_top_428531_445944));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(2)) fu_cnn_top_428531_440984 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i8_fu_cnn_top_428531_440984),
    .in1(out_reg_2_reg_2),
    .in2(out_reg_23_reg_23));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(30),
    .OFFSET_PARAMETER(1)) fu_cnn_top_428531_445767 (.out1(out_ui_bit_ior_concat_expr_FU_57_i0_fu_cnn_top_428531_445767),
    .in1(out_ui_lshift_expr_FU_32_0_32_74_i0_fu_cnn_top_428531_447718),
    .in2(out_ui_bit_and_expr_FU_1_0_1_54_i0_fu_cnn_top_428531_447721),
    .in3(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_cnn_top_428531_445771 (.out1(out_ui_rshift_expr_FU_32_0_32_85_i0_fu_cnn_top_428531_445771),
    .in1(out_reg_14_reg_14),
    .in2(out_const_26));
  ui_bit_and_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_cnn_top_428531_445775 (.out1(out_ui_bit_and_expr_FU_8_0_8_55_i0_fu_cnn_top_428531_445775),
    .in1(out_ui_rshift_expr_FU_8_0_8_91_i0_fu_cnn_top_428531_447725),
    .in2(out_const_29));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_cnn_top_428531_445778 (.out1(out_ui_lshift_expr_FU_32_0_32_70_i0_fu_cnn_top_428531_445778),
    .in1(out_reg_14_reg_14),
    .in2(out_const_4));
  UUdata_converter_FU #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) fu_cnn_top_428531_445786 (.out1(out_UUdata_converter_FU_40_i0_fu_cnn_top_428531_445786),
    .in1(out_reg_19_reg_19));
  ui_ternary_plus_expr_FU #(.BITSIZE_in1(10),
    .BITSIZE_in2(10),
    .BITSIZE_in3(16),
    .BITSIZE_out1(16)) fu_cnn_top_428531_445795 (.out1(out_ui_ternary_plus_expr_FU_16_16_16_16_92_i0_fu_cnn_top_428531_445795),
    .in1(out_reg_35_reg_35),
    .in2(out_ui_ternary_plus_expr_FU_16_16_16_16_92_i2_fu_cnn_top_428531_445874),
    .in3(out_reg_19_reg_19));
  ui_ternary_plus_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(8),
    .BITSIZE_in3(9),
    .BITSIZE_out1(10)) fu_cnn_top_428531_445804 (.out1(out_ui_ternary_plus_expr_FU_16_16_16_16_92_i1_fu_cnn_top_428531_445804),
    .in1(out_reg_33_reg_33),
    .in2(out_reg_34_reg_34),
    .in3(out_ui_plus_expr_FU_8_8_8_83_i0_fu_cnn_top_428531_445844));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445814 (.out1(out_UUdata_converter_FU_24_i0_fu_cnn_top_428531_445814),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445821 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i9_fu_cnn_top_428531_445821),
    .in1(out_reg_1_reg_1),
    .in2(out_reg_20_reg_20));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445831 (.out1(out_UUdata_converter_FU_26_i0_fu_cnn_top_428531_445831),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445837 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i10_fu_cnn_top_428531_445837),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_59_i1_fu_cnn_top_428531_445842));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445842 (.out1(out_ui_bit_ior_expr_FU_32_0_32_59_i1_fu_cnn_top_428531_445842),
    .in1(out_reg_20_reg_20),
    .in2(out_const_4));
  ui_plus_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(8),
    .BITSIZE_out1(9)) fu_cnn_top_428531_445844 (.out1(out_ui_plus_expr_FU_8_8_8_83_i0_fu_cnn_top_428531_445844),
    .in1(out_UUdata_converter_FU_27_i0_fu_cnn_top_428531_445848),
    .in2(out_UUdata_converter_FU_29_i0_fu_cnn_top_428531_445861));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445848 (.out1(out_UUdata_converter_FU_27_i0_fu_cnn_top_428531_445848),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445854 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i11_fu_cnn_top_428531_445854),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_60_i1_fu_cnn_top_428531_445859));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445859 (.out1(out_ui_bit_ior_expr_FU_32_0_32_60_i1_fu_cnn_top_428531_445859),
    .in1(out_reg_20_reg_20),
    .in2(out_const_26));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445861 (.out1(out_UUdata_converter_FU_29_i0_fu_cnn_top_428531_445861),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445867 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i12_fu_cnn_top_428531_445867),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_61_i0_fu_cnn_top_428531_445872));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445872 (.out1(out_ui_bit_ior_expr_FU_32_0_32_61_i0_fu_cnn_top_428531_445872),
    .in1(out_reg_20_reg_20),
    .in2(out_const_20));
  ui_ternary_plus_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(8),
    .BITSIZE_in3(9),
    .BITSIZE_out1(10)) fu_cnn_top_428531_445874 (.out1(out_ui_ternary_plus_expr_FU_16_16_16_16_92_i2_fu_cnn_top_428531_445874),
    .in1(out_reg_36_reg_36),
    .in2(out_reg_37_reg_37),
    .in3(out_ui_plus_expr_FU_8_8_8_83_i1_fu_cnn_top_428531_445908));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445882 (.out1(out_UUdata_converter_FU_30_i0_fu_cnn_top_428531_445882),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445888 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i13_fu_cnn_top_428531_445888),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_62_i0_fu_cnn_top_428531_445893));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445893 (.out1(out_ui_bit_ior_expr_FU_32_0_32_62_i0_fu_cnn_top_428531_445893),
    .in1(out_reg_20_reg_20),
    .in2(out_const_27));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445895 (.out1(out_UUdata_converter_FU_28_i0_fu_cnn_top_428531_445895),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445901 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i14_fu_cnn_top_428531_445901),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_63_i0_fu_cnn_top_428531_445906));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445906 (.out1(out_ui_bit_ior_expr_FU_32_0_32_63_i0_fu_cnn_top_428531_445906),
    .in1(out_reg_20_reg_20),
    .in2(out_const_5));
  ui_plus_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_in2(8),
    .BITSIZE_out1(9)) fu_cnn_top_428531_445908 (.out1(out_ui_plus_expr_FU_8_8_8_83_i1_fu_cnn_top_428531_445908),
    .in1(out_UUdata_converter_FU_31_i0_fu_cnn_top_428531_445912),
    .in2(out_UUdata_converter_FU_25_i0_fu_cnn_top_428531_445925));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445912 (.out1(out_UUdata_converter_FU_31_i0_fu_cnn_top_428531_445912),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445918 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i15_fu_cnn_top_428531_445918),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_64_i0_fu_cnn_top_428531_445923));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445923 (.out1(out_ui_bit_ior_expr_FU_32_0_32_64_i0_fu_cnn_top_428531_445923),
    .in1(out_reg_20_reg_20),
    .in2(out_const_29));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) fu_cnn_top_428531_445925 (.out1(out_UUdata_converter_FU_25_i0_fu_cnn_top_428531_445925),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_array_428598_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_cnn_top_428531_445931 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i16_fu_cnn_top_428531_445931),
    .in1(out_reg_1_reg_1),
    .in2(out_ui_bit_ior_expr_FU_32_0_32_58_i1_fu_cnn_top_428531_445936));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445936 (.out1(out_ui_bit_ior_expr_FU_32_0_32_58_i1_fu_cnn_top_428531_445936),
    .in1(out_reg_20_reg_20),
    .in2(out_const_3));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_cnn_top_428531_445939 (.out1(out_ui_bit_xor_expr_FU_8_0_8_65_i0_fu_cnn_top_428531_445939),
    .in1(out_ui_bit_and_expr_FU_8_0_8_56_i0_fu_cnn_top_428531_445942),
    .in2(out_const_29));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_cnn_top_428531_445942 (.out1(out_ui_bit_and_expr_FU_8_0_8_56_i0_fu_cnn_top_428531_445942),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_29));
  ui_negate_expr_FU #(.BITSIZE_in1(23),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445944 (.out1(out_ui_negate_expr_FU_32_32_78_i0_fu_cnn_top_428531_445944),
    .in1(out_ui_lshift_expr_FU_32_32_32_75_i0_ui_lshift_expr_FU_32_32_32_75_i0));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445950 (.out1(out_ui_plus_expr_FU_32_32_32_82_i1_fu_cnn_top_428531_445950),
    .in1(out_ui_cond_expr_FU_32_32_32_32_66_i1_fu_cnn_top_428531_445953),
    .in2(out_reg_16_reg_16));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(23),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445953 (.out1(out_ui_cond_expr_FU_32_32_32_32_66_i1_fu_cnn_top_428531_445953),
    .in1(out_reg_43_reg_43),
    .in2(out_ui_lshift_expr_FU_32_32_32_75_i0_ui_lshift_expr_FU_32_32_32_75_i0),
    .in3(out_ui_negate_expr_FU_32_32_78_i1_fu_cnn_top_428531_445998));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(2)) fu_cnn_top_428531_445971 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_84_i17_fu_cnn_top_428531_445971),
    .in1(out_reg_2_reg_2),
    .in2(out_reg_24_reg_24));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(30),
    .OFFSET_PARAMETER(1)) fu_cnn_top_428531_445976 (.out1(out_ui_bit_ior_concat_expr_FU_57_i1_fu_cnn_top_428531_445976),
    .in1(out_ui_lshift_expr_FU_32_0_32_74_i1_fu_cnn_top_428531_447737),
    .in2(out_ui_bit_and_expr_FU_1_0_1_54_i1_fu_cnn_top_428531_447740),
    .in3(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_cnn_top_428531_445979 (.out1(out_ui_rshift_expr_FU_32_0_32_85_i1_fu_cnn_top_428531_445979),
    .in1(out_reg_17_reg_17),
    .in2(out_const_26));
  ui_bit_and_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_cnn_top_428531_445982 (.out1(out_ui_bit_and_expr_FU_8_0_8_55_i1_fu_cnn_top_428531_445982),
    .in1(out_ui_rshift_expr_FU_8_0_8_91_i1_fu_cnn_top_428531_447744),
    .in2(out_const_29));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_cnn_top_428531_445985 (.out1(out_ui_lshift_expr_FU_32_0_32_70_i1_fu_cnn_top_428531_445985),
    .in1(out_reg_17_reg_17),
    .in2(out_const_4));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_cnn_top_428531_445993 (.out1(out_ui_bit_xor_expr_FU_8_0_8_65_i1_fu_cnn_top_428531_445993),
    .in1(out_ui_bit_and_expr_FU_8_0_8_56_i1_fu_cnn_top_428531_445996),
    .in2(out_const_29));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(3)) fu_cnn_top_428531_445996 (.out1(out_ui_bit_and_expr_FU_8_0_8_56_i1_fu_cnn_top_428531_445996),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_29));
  ui_negate_expr_FU #(.BITSIZE_in1(23),
    .BITSIZE_out1(32)) fu_cnn_top_428531_445998 (.out1(out_ui_negate_expr_FU_32_32_78_i1_fu_cnn_top_428531_445998),
    .in1(out_ui_lshift_expr_FU_32_32_32_75_i0_ui_lshift_expr_FU_32_32_32_75_i0));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_cnn_top_428531_446004 (.out1(out_ui_plus_expr_FU_32_0_32_79_i0_fu_cnn_top_428531_446004),
    .in1(out_reg_14_reg_14),
    .in2(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32)) fu_cnn_top_428531_446007 (.out1(out_ui_plus_expr_FU_32_0_32_79_i1_fu_cnn_top_428531_446007),
    .in1(out_reg_17_reg_17),
    .in2(out_const_3));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_446009 (.out1(out_UUdata_converter_FU_19_i0_fu_cnn_top_428531_446009),
    .in1(out_ui_eq_expr_FU_32_0_32_68_i0_fu_cnn_top_428531_447244));
  read_cond_FU #(.BITSIZE_in1(1)) fu_cnn_top_428531_446010 (.out1(out_read_cond_FU_22_i0_fu_cnn_top_428531_446010),
    .in1(out_reg_22_reg_22));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_446013 (.out1(out_UUdata_converter_FU_32_i0_fu_cnn_top_428531_446013),
    .in1(out_ui_eq_expr_FU_32_32_32_69_i0_fu_cnn_top_428531_447287));
  read_cond_FU #(.BITSIZE_in1(1)) fu_cnn_top_428531_446014 (.out1(out_read_cond_FU_33_i0_fu_cnn_top_428531_446014),
    .in1(out_reg_32_reg_32));
  ui_minus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_446019 (.out1(out_ui_minus_expr_FU_32_32_32_77_i0_fu_cnn_top_428531_446019),
    .in1(out_reg_16_reg_16),
    .in2(out_reg_13_reg_13));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_446025 (.out1(out_UUdata_converter_FU_39_i0_fu_cnn_top_428531_446025),
    .in1(out_lut_expr_FU_38_i0_fu_cnn_top_428531_447327));
  read_cond_FU #(.BITSIZE_in1(1)) fu_cnn_top_428531_446026 (.out1(out_read_cond_FU_43_i0_fu_cnn_top_428531_446026),
    .in1(out_UUdata_converter_FU_39_i0_fu_cnn_top_428531_446025));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_446029 (.out1(out_UUdata_converter_FU_49_i0_fu_cnn_top_428531_446029),
    .in1(out_lut_expr_FU_48_i0_fu_cnn_top_428531_447340));
  read_cond_FU #(.BITSIZE_in1(1)) fu_cnn_top_428531_446030 (.out1(out_read_cond_FU_52_i0_fu_cnn_top_428531_446030),
    .in1(out_UUdata_converter_FU_49_i0_fu_cnn_top_428531_446029));
  ui_eq_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(11),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447225 (.out1(out_ui_eq_expr_FU_32_0_32_67_i0_fu_cnn_top_428531_447225),
    .in1(out_ui_rshift_expr_FU_32_0_32_86_i1_fu_cnn_top_428531_447677),
    .in2(out_const_11));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_447229 (.out1(out_addr_expr_FU_4_i0_fu_cnn_top_428531_447229),
    .in1(out_conv_out_const_32_15_32));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447244 (.out1(out_ui_eq_expr_FU_32_0_32_68_i0_fu_cnn_top_428531_447244),
    .in1(out_ui_plus_expr_FU_32_0_32_79_i0_fu_cnn_top_428531_446004),
    .in2(out_const_30));
  ui_eq_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(29),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447287 (.out1(out_ui_eq_expr_FU_32_32_32_69_i0_fu_cnn_top_428531_447287),
    .in1(out_ui_rshift_expr_FU_32_0_32_88_i1_fu_cnn_top_428531_447697),
    .in2(out_reg_25_reg_25));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_cnn_top_428531_447325 (.out1(out_ui_lshift_expr_FU_32_0_32_71_i0_fu_cnn_top_428531_447325),
    .in1(out_ui_bit_ior_concat_expr_FU_57_i0_fu_cnn_top_428531_445767),
    .in2(out_const_4));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447327 (.out1(out_lut_expr_FU_38_i0_fu_cnn_top_428531_447327),
    .in1(out_const_3),
    .in2(out_ui_extract_bit_expr_FU_35_i0_fu_cnn_top_428531_448000),
    .in3(out_ui_extract_bit_expr_FU_36_i0_fu_cnn_top_428531_448004),
    .in4(out_ui_extract_bit_expr_FU_37_i0_fu_cnn_top_428531_448008),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_cnn_top_428531_447331 (.out1(out_addr_expr_FU_12_i0_fu_cnn_top_428531_447331),
    .in1(out_conv_out_const_33_15_32));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_cnn_top_428531_447338 (.out1(out_ui_lshift_expr_FU_32_0_32_71_i1_fu_cnn_top_428531_447338),
    .in1(out_ui_bit_ior_concat_expr_FU_57_i1_fu_cnn_top_428531_445976),
    .in2(out_const_4));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447340 (.out1(out_lut_expr_FU_48_i0_fu_cnn_top_428531_447340),
    .in1(out_const_3),
    .in2(out_ui_extract_bit_expr_FU_45_i0_fu_cnn_top_428531_448020),
    .in3(out_ui_extract_bit_expr_FU_46_i0_fu_cnn_top_428531_448024),
    .in4(out_ui_extract_bit_expr_FU_47_i0_fu_cnn_top_428531_448028),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447352 (.out1(out_lut_expr_FU_42_i0_fu_cnn_top_428531_447352),
    .in1(out_const_3),
    .in2(out_ui_extract_bit_expr_FU_41_i0_fu_cnn_top_428531_448012),
    .in3(1'b0),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447358 (.out1(out_lut_expr_FU_51_i0_fu_cnn_top_428531_447358),
    .in1(out_const_3),
    .in2(out_ui_extract_bit_expr_FU_50_i0_fu_cnn_top_428531_448032),
    .in3(1'b0),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_cnn_top_428531_447668 (.out1(out_ui_rshift_expr_FU_32_0_32_86_i0_fu_cnn_top_428531_447668),
    .in1(out_reg_0_reg_0),
    .in2(out_const_4));
  ui_plus_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(1),
    .BITSIZE_out1(30)) fu_cnn_top_428531_447671 (.out1(out_ui_plus_expr_FU_32_0_32_80_i0_fu_cnn_top_428531_447671),
    .in1(out_ui_rshift_expr_FU_32_0_32_86_i0_fu_cnn_top_428531_447668),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_cnn_top_428531_447674 (.out1(out_ui_lshift_expr_FU_32_0_32_71_i2_fu_cnn_top_428531_447674),
    .in1(out_ui_plus_expr_FU_32_0_32_80_i0_fu_cnn_top_428531_447671),
    .in2(out_const_4));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_cnn_top_428531_447677 (.out1(out_ui_rshift_expr_FU_32_0_32_86_i1_fu_cnn_top_428531_447677),
    .in1(out_ui_lshift_expr_FU_32_0_32_71_i2_fu_cnn_top_428531_447674),
    .in2(out_const_4));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(26),
    .PRECISION(32)) fu_cnn_top_428531_447681 (.out1(out_ui_rshift_expr_FU_32_0_32_87_i0_fu_cnn_top_428531_447681),
    .in1(out_reg_12_reg_12),
    .in2(out_const_27));
  ui_plus_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(1),
    .BITSIZE_out1(26)) fu_cnn_top_428531_447683 (.out1(out_ui_plus_expr_FU_32_0_32_80_i1_fu_cnn_top_428531_447683),
    .in1(out_ui_rshift_expr_FU_32_0_32_87_i0_fu_cnn_top_428531_447681),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_cnn_top_428531_447686 (.out1(out_ui_lshift_expr_FU_32_0_32_72_i0_fu_cnn_top_428531_447686),
    .in1(out_ui_plus_expr_FU_32_0_32_80_i1_fu_cnn_top_428531_447683),
    .in2(out_const_27));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_cnn_top_428531_447689 (.out1(out_ui_rshift_expr_FU_32_0_32_88_i0_fu_cnn_top_428531_447689),
    .in1(out_reg_20_reg_20),
    .in2(out_const_26));
  ui_plus_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(29)) fu_cnn_top_428531_447691 (.out1(out_ui_plus_expr_FU_32_0_32_80_i2_fu_cnn_top_428531_447691),
    .in1(out_ui_rshift_expr_FU_32_0_32_88_i0_fu_cnn_top_428531_447689),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_cnn_top_428531_447694 (.out1(out_ui_lshift_expr_FU_32_0_32_73_i0_fu_cnn_top_428531_447694),
    .in1(out_ui_plus_expr_FU_32_0_32_80_i2_fu_cnn_top_428531_447691),
    .in2(out_const_26));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_cnn_top_428531_447697 (.out1(out_ui_rshift_expr_FU_32_0_32_88_i1_fu_cnn_top_428531_447697),
    .in1(out_ui_lshift_expr_FU_32_0_32_73_i0_fu_cnn_top_428531_447694),
    .in2(out_const_26));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(29),
    .PRECISION(32)) fu_cnn_top_428531_447700 (.out1(out_ui_rshift_expr_FU_32_0_32_88_i2_fu_cnn_top_428531_447700),
    .in1(out_reg_12_reg_12),
    .in2(out_const_26));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(26),
    .PRECISION(32)) fu_cnn_top_428531_447703 (.out1(out_ui_rshift_expr_FU_32_0_32_87_i1_fu_cnn_top_428531_447703),
    .in1(out_reg_15_reg_15),
    .in2(out_const_27));
  ui_plus_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(1),
    .BITSIZE_out1(26)) fu_cnn_top_428531_447705 (.out1(out_ui_plus_expr_FU_32_0_32_80_i3_fu_cnn_top_428531_447705),
    .in1(out_ui_rshift_expr_FU_32_0_32_87_i1_fu_cnn_top_428531_447703),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(26),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_cnn_top_428531_447708 (.out1(out_ui_lshift_expr_FU_32_0_32_72_i1_fu_cnn_top_428531_447708),
    .in1(out_ui_plus_expr_FU_32_0_32_80_i3_fu_cnn_top_428531_447705),
    .in2(out_const_27));
  ui_rshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(28),
    .PRECISION(32)) fu_cnn_top_428531_447711 (.out1(out_ui_rshift_expr_FU_32_0_32_89_i0_fu_cnn_top_428531_447711),
    .in1(out_ui_rshift_expr_FU_32_0_32_85_i0_fu_cnn_top_428531_445771),
    .in2(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(28),
    .BITSIZE_in2(11),
    .BITSIZE_out1(29)) fu_cnn_top_428531_447715 (.out1(out_ui_plus_expr_FU_32_0_32_81_i0_fu_cnn_top_428531_447715),
    .in1(out_ui_rshift_expr_FU_32_0_32_89_i0_fu_cnn_top_428531_447711),
    .in2(out_const_16));
  ui_lshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_cnn_top_428531_447718 (.out1(out_ui_lshift_expr_FU_32_0_32_74_i0_fu_cnn_top_428531_447718),
    .in1(out_ui_plus_expr_FU_32_0_32_81_i0_fu_cnn_top_428531_447715),
    .in2(out_const_3));
  ui_bit_and_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447721 (.out1(out_ui_bit_and_expr_FU_1_0_1_54_i0_fu_cnn_top_428531_447721),
    .in1(out_ui_rshift_expr_FU_32_0_32_85_i0_fu_cnn_top_428531_445771),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(3),
    .PRECISION(32)) fu_cnn_top_428531_447725 (.out1(out_ui_rshift_expr_FU_8_0_8_91_i0_fu_cnn_top_428531_447725),
    .in1(out_ui_lshift_expr_FU_32_0_32_70_i0_fu_cnn_top_428531_445778),
    .in2(out_const_4));
  ui_lshift_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_cnn_top_428531_447729 (.out1(out_ui_lshift_expr_FU_8_0_8_76_i0_fu_cnn_top_428531_447729),
    .in1(out_ui_bit_and_expr_FU_8_0_8_55_i0_fu_cnn_top_428531_445775),
    .in2(out_const_4));
  ui_rshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(28),
    .PRECISION(32)) fu_cnn_top_428531_447732 (.out1(out_ui_rshift_expr_FU_32_0_32_89_i1_fu_cnn_top_428531_447732),
    .in1(out_ui_rshift_expr_FU_32_0_32_85_i1_fu_cnn_top_428531_445979),
    .in2(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(28),
    .BITSIZE_in2(11),
    .BITSIZE_out1(29)) fu_cnn_top_428531_447734 (.out1(out_ui_plus_expr_FU_32_0_32_81_i1_fu_cnn_top_428531_447734),
    .in1(out_ui_rshift_expr_FU_32_0_32_89_i1_fu_cnn_top_428531_447732),
    .in2(out_const_16));
  ui_lshift_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_cnn_top_428531_447737 (.out1(out_ui_lshift_expr_FU_32_0_32_74_i1_fu_cnn_top_428531_447737),
    .in1(out_ui_plus_expr_FU_32_0_32_81_i1_fu_cnn_top_428531_447734),
    .in2(out_const_3));
  ui_bit_and_expr_FU #(.BITSIZE_in1(29),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_cnn_top_428531_447740 (.out1(out_ui_bit_and_expr_FU_1_0_1_54_i1_fu_cnn_top_428531_447740),
    .in1(out_ui_rshift_expr_FU_32_0_32_85_i1_fu_cnn_top_428531_445979),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_in2(2),
    .BITSIZE_out1(3),
    .PRECISION(32)) fu_cnn_top_428531_447744 (.out1(out_ui_rshift_expr_FU_8_0_8_91_i1_fu_cnn_top_428531_447744),
    .in1(out_ui_lshift_expr_FU_32_0_32_70_i1_fu_cnn_top_428531_445985),
    .in2(out_const_4));
  ui_lshift_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_in2(2),
    .BITSIZE_out1(5),
    .PRECISION(32)) fu_cnn_top_428531_447748 (.out1(out_ui_lshift_expr_FU_8_0_8_76_i1_fu_cnn_top_428531_447748),
    .in1(out_ui_bit_and_expr_FU_8_0_8_55_i1_fu_cnn_top_428531_445982),
    .in2(out_const_4));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_cnn_top_428531_448000 (.out1(out_ui_extract_bit_expr_FU_35_i0_fu_cnn_top_428531_448000),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_cnn_top_428531_448004 (.out1(out_ui_extract_bit_expr_FU_36_i0_fu_cnn_top_428531_448004),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_3));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_cnn_top_428531_448008 (.out1(out_ui_extract_bit_expr_FU_37_i0_fu_cnn_top_428531_448008),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_4));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_cnn_top_428531_448012 (.out1(out_ui_extract_bit_expr_FU_41_i0_fu_cnn_top_428531_448012),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_26));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_cnn_top_428531_448020 (.out1(out_ui_extract_bit_expr_FU_45_i0_fu_cnn_top_428531_448020),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1)) fu_cnn_top_428531_448024 (.out1(out_ui_extract_bit_expr_FU_46_i0_fu_cnn_top_428531_448024),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_3));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_cnn_top_428531_448028 (.out1(out_ui_extract_bit_expr_FU_47_i0_fu_cnn_top_428531_448028),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_4));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(2)) fu_cnn_top_428531_448032 (.out1(out_ui_extract_bit_expr_FU_50_i0_fu_cnn_top_428531_448032),
    .in1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in2(out_const_26));
  or or_or_conv_layer_93_i00( s_conv_layer_93_i00, selector_IN_UNBOUNDED_cnn_top_428531_440934, selector_IN_UNBOUNDED_cnn_top_428531_440935, selector_IN_UNBOUNDED_cnn_top_428531_440936, selector_IN_UNBOUNDED_cnn_top_428531_440937, selector_IN_UNBOUNDED_cnn_top_428531_440938);
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_72_reg_0_0_0_0),
    .wenable(wrenable_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_addr_expr_FU_4_i0_fu_cnn_top_428531_447229),
    .wenable(wrenable_reg_1));
  register_STD #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_10 (.out1(out_reg_10_reg_10),
    .clock(clock),
    .reset(reset),
    .in1(out_BMEMORY_CTRLN_53_i0_BMEMORY_CTRLN_53_i0),
    .wenable(wrenable_reg_10));
  register_STD #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_11 (.out1(out_reg_11_reg_11),
    .clock(clock),
    .reset(reset),
    .in1(out_BMEMORY_CTRLN_53_i1_BMEMORY_CTRLN_53_i0),
    .wenable(wrenable_reg_11));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_12 (.out1(out_reg_12_reg_12),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_76_reg_12_0_0_0),
    .wenable(wrenable_reg_12));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_13 (.out1(out_reg_13_reg_13),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_77_reg_13_0_0_0),
    .wenable(wrenable_reg_13));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_14 (.out1(out_reg_14_reg_14),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_78_reg_14_0_0_0),
    .wenable(wrenable_reg_14));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_15 (.out1(out_reg_15_reg_15),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_79_reg_15_0_0_0),
    .wenable(wrenable_reg_15));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_16 (.out1(out_reg_16_reg_16),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_80_reg_16_0_0_0),
    .wenable(wrenable_reg_16));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_17 (.out1(out_reg_17_reg_17),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_81_reg_17_0_0_0),
    .wenable(wrenable_reg_17));
  register_SE #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_18 (.out1(out_reg_18_reg_18),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_8_0_8_76_i0_fu_cnn_top_428531_447729),
    .wenable(wrenable_reg_18));
  register_SE #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) reg_19 (.out1(out_reg_19_reg_19),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_83_reg_19_0_0_0),
    .wenable(wrenable_reg_19));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_addr_expr_FU_12_i0_fu_cnn_top_428531_447331),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_20 (.out1(out_reg_20_reg_20),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_85_reg_20_0_0_0),
    .wenable(wrenable_reg_20));
  register_SE #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_21 (.out1(out_reg_21_reg_21),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_8_0_8_76_i1_fu_cnn_top_428531_447748),
    .wenable(wrenable_reg_21));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_22 (.out1(out_reg_22_reg_22),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_19_i0_fu_cnn_top_428531_446009),
    .wenable(wrenable_reg_22));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_23 (.out1(out_reg_23_reg_23),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_0_32_71_i0_fu_cnn_top_428531_447325),
    .wenable(wrenable_reg_23));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_24 (.out1(out_reg_24_reg_24),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_lshift_expr_FU_32_0_32_71_i1_fu_cnn_top_428531_447338),
    .wenable(wrenable_reg_24));
  register_SE #(.BITSIZE_in1(29),
    .BITSIZE_out1(29)) reg_25 (.out1(out_reg_25_reg_25),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_rshift_expr_FU_32_0_32_88_i2_fu_cnn_top_428531_447700),
    .wenable(wrenable_reg_25));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_26 (.out1(out_reg_26_reg_26),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i11_fu_cnn_top_428531_445854),
    .wenable(wrenable_reg_26));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_27 (.out1(out_reg_27_reg_27),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i12_fu_cnn_top_428531_445867),
    .wenable(wrenable_reg_27));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_28 (.out1(out_reg_28_reg_28),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i13_fu_cnn_top_428531_445888),
    .wenable(wrenable_reg_28));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_29 (.out1(out_reg_29_reg_29),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i14_fu_cnn_top_428531_445901),
    .wenable(wrenable_reg_29));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i1_fu_cnn_top_428531_428556),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_30 (.out1(out_reg_30_reg_30),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i15_fu_cnn_top_428531_445918),
    .wenable(wrenable_reg_30));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_31 (.out1(out_reg_31_reg_31),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i16_fu_cnn_top_428531_445931),
    .wenable(wrenable_reg_31));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_32 (.out1(out_reg_32_reg_32),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_32_i0_fu_cnn_top_428531_446013),
    .wenable(wrenable_reg_32));
  register_STD #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_33 (.out1(out_reg_33_reg_33),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_24_i0_fu_cnn_top_428531_445814),
    .wenable(wrenable_reg_33));
  register_STD #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_34 (.out1(out_reg_34_reg_34),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_26_i0_fu_cnn_top_428531_445831),
    .wenable(wrenable_reg_34));
  register_SE #(.BITSIZE_in1(10),
    .BITSIZE_out1(10)) reg_35 (.out1(out_reg_35_reg_35),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_ternary_plus_expr_FU_16_16_16_16_92_i1_fu_cnn_top_428531_445804),
    .wenable(wrenable_reg_35));
  register_STD #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_36 (.out1(out_reg_36_reg_36),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_30_i0_fu_cnn_top_428531_445882),
    .wenable(wrenable_reg_36));
  register_STD #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) reg_37 (.out1(out_reg_37_reg_37),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_28_i0_fu_cnn_top_428531_445895),
    .wenable(wrenable_reg_37));
  register_SE #(.BITSIZE_in1(16),
    .BITSIZE_out1(16)) reg_38 (.out1(out_reg_38_reg_38),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_40_i0_fu_cnn_top_428531_445786),
    .wenable(wrenable_reg_38));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_39 (.out1(out_reg_39_reg_39),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i17_fu_cnn_top_428531_445971),
    .wenable(wrenable_reg_39));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i3_fu_cnn_top_428531_428561),
    .wenable(wrenable_reg_4));
  register_STD #(.BITSIZE_in1(3),
    .BITSIZE_out1(3)) reg_40 (.out1(out_reg_40_reg_40),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_xor_expr_FU_8_0_8_65_i0_fu_cnn_top_428531_445939),
    .wenable(wrenable_reg_40));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_41 (.out1(out_reg_41_reg_41),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_42_i0_fu_cnn_top_428531_447352),
    .wenable(wrenable_reg_41));
  register_STD #(.BITSIZE_in1(3),
    .BITSIZE_out1(3)) reg_42 (.out1(out_reg_42_reg_42),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_xor_expr_FU_8_0_8_65_i1_fu_cnn_top_428531_445993),
    .wenable(wrenable_reg_42));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_43 (.out1(out_reg_43_reg_43),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_51_i0_fu_cnn_top_428531_447358),
    .wenable(wrenable_reg_43));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i4_fu_cnn_top_428531_428564),
    .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i5_fu_cnn_top_428531_428566),
    .wenable(wrenable_reg_6));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i6_fu_cnn_top_428531_428569),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_84_i7_fu_cnn_top_428531_428571),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_10_i0_fu_cnn_top_428531_428574),
    .wenable(wrenable_reg_9));
  ui_lshift_expr_FU #(.BITSIZE_in1(16),
    .BITSIZE_in2(3),
    .BITSIZE_out1(23),
    .PRECISION(32)) ui_lshift_expr_FU_32_32_32_75_i0 (.out1(out_ui_lshift_expr_FU_32_32_32_75_i0_ui_lshift_expr_FU_32_32_32_75_i0),
    .in1(out_reg_38_reg_38),
    .in2(out_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5),
    .BITSIZE_out1(4),
    .PRECISION(32)) ui_rshift_expr_FU_32_32_32_90_i0 (.out1(out_ui_rshift_expr_FU_32_32_32_90_i0_ui_rshift_expr_FU_32_32_32_90_i0),
    .in1(out_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_array_440988_0),
    .in2(out_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0));
  // io-signal post fix
  assign return_port = out_ui_minus_expr_FU_32_32_32_77_i0_fu_cnn_top_428531_446019;
  assign OUT_CONDITION_cnn_top_428531_428575 = out_read_cond_FU_11_i0_fu_cnn_top_428531_428575;
  assign OUT_CONDITION_cnn_top_428531_446010 = out_read_cond_FU_22_i0_fu_cnn_top_428531_446010;
  assign OUT_CONDITION_cnn_top_428531_446014 = out_read_cond_FU_33_i0_fu_cnn_top_428531_446014;
  assign OUT_CONDITION_cnn_top_428531_446026 = out_read_cond_FU_43_i0_fu_cnn_top_428531_446026;
  assign OUT_CONDITION_cnn_top_428531_446030 = out_read_cond_FU_52_i0_fu_cnn_top_428531_446030;
  assign OUT_UNBOUNDED_cnn_top_428531_440934 = s_done_conv_layer_93_i0;
  assign OUT_UNBOUNDED_cnn_top_428531_440935 = s_done_conv_layer_93_i0;
  assign OUT_UNBOUNDED_cnn_top_428531_440936 = s_done_conv_layer_93_i0;
  assign OUT_UNBOUNDED_cnn_top_428531_440937 = s_done_conv_layer_93_i0;
  assign OUT_UNBOUNDED_cnn_top_428531_440938 = s_done_conv_layer_93_i0;

endmodule

// FSM based controller description for cnn_top
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_cnn_top(done_port,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE,
  fuselector_BMEMORY_CTRLN_53_i0_LOAD,
  fuselector_BMEMORY_CTRLN_53_i0_STORE,
  fuselector_BMEMORY_CTRLN_53_i1_LOAD,
  fuselector_BMEMORY_CTRLN_53_i1_STORE,
  selector_IN_UNBOUNDED_cnn_top_428531_440934,
  selector_IN_UNBOUNDED_cnn_top_428531_440935,
  selector_IN_UNBOUNDED_cnn_top_428531_440936,
  selector_IN_UNBOUNDED_cnn_top_428531_440937,
  selector_IN_UNBOUNDED_cnn_top_428531_440938,
  selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0,
  selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0,
  selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0,
  selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0,
  selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1,
  selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0,
  selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0,
  selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0,
  selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0,
  selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0,
  selector_MUX_44_conv_layer_93_i0_0_0_0,
  selector_MUX_45_conv_layer_93_i0_1_0_0,
  selector_MUX_46_conv_layer_93_i0_2_0_0,
  selector_MUX_46_conv_layer_93_i0_2_0_1,
  selector_MUX_46_conv_layer_93_i0_2_0_2,
  selector_MUX_46_conv_layer_93_i0_2_1_0,
  selector_MUX_47_conv_layer_93_i0_3_0_0,
  selector_MUX_47_conv_layer_93_i0_3_0_1,
  selector_MUX_47_conv_layer_93_i0_3_0_2,
  selector_MUX_47_conv_layer_93_i0_3_1_0,
  selector_MUX_48_conv_layer_93_i0_4_0_0,
  selector_MUX_48_conv_layer_93_i0_4_0_1,
  selector_MUX_48_conv_layer_93_i0_4_0_2,
  selector_MUX_48_conv_layer_93_i0_4_1_0,
  selector_MUX_49_conv_layer_93_i0_5_0_0,
  selector_MUX_49_conv_layer_93_i0_5_0_1,
  selector_MUX_49_conv_layer_93_i0_5_0_2,
  selector_MUX_49_conv_layer_93_i0_5_1_0,
  selector_MUX_50_conv_layer_93_i0_6_0_0,
  selector_MUX_50_conv_layer_93_i0_6_0_1,
  selector_MUX_50_conv_layer_93_i0_6_1_0,
  selector_MUX_51_conv_layer_93_i0_7_0_0,
  selector_MUX_51_conv_layer_93_i0_7_0_1,
  selector_MUX_51_conv_layer_93_i0_7_1_0,
  selector_MUX_52_conv_layer_93_i0_8_0_0,
  selector_MUX_52_conv_layer_93_i0_8_0_1,
  selector_MUX_52_conv_layer_93_i0_8_1_0,
  selector_MUX_53_conv_layer_93_i0_9_0_0,
  selector_MUX_72_reg_0_0_0_0,
  selector_MUX_76_reg_12_0_0_0,
  selector_MUX_77_reg_13_0_0_0,
  selector_MUX_78_reg_14_0_0_0,
  selector_MUX_79_reg_15_0_0_0,
  selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0,
  selector_MUX_80_reg_16_0_0_0,
  selector_MUX_81_reg_17_0_0_0,
  selector_MUX_83_reg_19_0_0_0,
  selector_MUX_85_reg_20_0_0_0,
  selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0,
  selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1,
  selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0,
  selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_10,
  wrenable_reg_11,
  wrenable_reg_12,
  wrenable_reg_13,
  wrenable_reg_14,
  wrenable_reg_15,
  wrenable_reg_16,
  wrenable_reg_17,
  wrenable_reg_18,
  wrenable_reg_19,
  wrenable_reg_2,
  wrenable_reg_20,
  wrenable_reg_21,
  wrenable_reg_22,
  wrenable_reg_23,
  wrenable_reg_24,
  wrenable_reg_25,
  wrenable_reg_26,
  wrenable_reg_27,
  wrenable_reg_28,
  wrenable_reg_29,
  wrenable_reg_3,
  wrenable_reg_30,
  wrenable_reg_31,
  wrenable_reg_32,
  wrenable_reg_33,
  wrenable_reg_34,
  wrenable_reg_35,
  wrenable_reg_36,
  wrenable_reg_37,
  wrenable_reg_38,
  wrenable_reg_39,
  wrenable_reg_4,
  wrenable_reg_40,
  wrenable_reg_41,
  wrenable_reg_42,
  wrenable_reg_43,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_cnn_top_428531_428575,
  OUT_CONDITION_cnn_top_428531_446010,
  OUT_CONDITION_cnn_top_428531_446014,
  OUT_CONDITION_cnn_top_428531_446026,
  OUT_CONDITION_cnn_top_428531_446030,
  OUT_UNBOUNDED_cnn_top_428531_440934,
  OUT_UNBOUNDED_cnn_top_428531_440935,
  OUT_UNBOUNDED_cnn_top_428531_440936,
  OUT_UNBOUNDED_cnn_top_428531_440937,
  OUT_UNBOUNDED_cnn_top_428531_440938,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_cnn_top_428531_428575;
  input OUT_CONDITION_cnn_top_428531_446010;
  input OUT_CONDITION_cnn_top_428531_446014;
  input OUT_CONDITION_cnn_top_428531_446026;
  input OUT_CONDITION_cnn_top_428531_446030;
  input OUT_UNBOUNDED_cnn_top_428531_440934;
  input OUT_UNBOUNDED_cnn_top_428531_440935;
  input OUT_UNBOUNDED_cnn_top_428531_440936;
  input OUT_UNBOUNDED_cnn_top_428531_440937;
  input OUT_UNBOUNDED_cnn_top_428531_440938;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE;
  output fuselector_BMEMORY_CTRLN_53_i0_LOAD;
  output fuselector_BMEMORY_CTRLN_53_i0_STORE;
  output fuselector_BMEMORY_CTRLN_53_i1_LOAD;
  output fuselector_BMEMORY_CTRLN_53_i1_STORE;
  output selector_IN_UNBOUNDED_cnn_top_428531_440934;
  output selector_IN_UNBOUNDED_cnn_top_428531_440935;
  output selector_IN_UNBOUNDED_cnn_top_428531_440936;
  output selector_IN_UNBOUNDED_cnn_top_428531_440937;
  output selector_IN_UNBOUNDED_cnn_top_428531_440938;
  output selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0;
  output selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0;
  output selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0;
  output selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  output selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  output selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0;
  output selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0;
  output selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0;
  output selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0;
  output selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0;
  output selector_MUX_44_conv_layer_93_i0_0_0_0;
  output selector_MUX_45_conv_layer_93_i0_1_0_0;
  output selector_MUX_46_conv_layer_93_i0_2_0_0;
  output selector_MUX_46_conv_layer_93_i0_2_0_1;
  output selector_MUX_46_conv_layer_93_i0_2_0_2;
  output selector_MUX_46_conv_layer_93_i0_2_1_0;
  output selector_MUX_47_conv_layer_93_i0_3_0_0;
  output selector_MUX_47_conv_layer_93_i0_3_0_1;
  output selector_MUX_47_conv_layer_93_i0_3_0_2;
  output selector_MUX_47_conv_layer_93_i0_3_1_0;
  output selector_MUX_48_conv_layer_93_i0_4_0_0;
  output selector_MUX_48_conv_layer_93_i0_4_0_1;
  output selector_MUX_48_conv_layer_93_i0_4_0_2;
  output selector_MUX_48_conv_layer_93_i0_4_1_0;
  output selector_MUX_49_conv_layer_93_i0_5_0_0;
  output selector_MUX_49_conv_layer_93_i0_5_0_1;
  output selector_MUX_49_conv_layer_93_i0_5_0_2;
  output selector_MUX_49_conv_layer_93_i0_5_1_0;
  output selector_MUX_50_conv_layer_93_i0_6_0_0;
  output selector_MUX_50_conv_layer_93_i0_6_0_1;
  output selector_MUX_50_conv_layer_93_i0_6_1_0;
  output selector_MUX_51_conv_layer_93_i0_7_0_0;
  output selector_MUX_51_conv_layer_93_i0_7_0_1;
  output selector_MUX_51_conv_layer_93_i0_7_1_0;
  output selector_MUX_52_conv_layer_93_i0_8_0_0;
  output selector_MUX_52_conv_layer_93_i0_8_0_1;
  output selector_MUX_52_conv_layer_93_i0_8_1_0;
  output selector_MUX_53_conv_layer_93_i0_9_0_0;
  output selector_MUX_72_reg_0_0_0_0;
  output selector_MUX_76_reg_12_0_0_0;
  output selector_MUX_77_reg_13_0_0_0;
  output selector_MUX_78_reg_14_0_0_0;
  output selector_MUX_79_reg_15_0_0_0;
  output selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0;
  output selector_MUX_80_reg_16_0_0_0;
  output selector_MUX_81_reg_17_0_0_0;
  output selector_MUX_83_reg_19_0_0_0;
  output selector_MUX_85_reg_20_0_0_0;
  output selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0;
  output selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1;
  output selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0;
  output selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_10;
  output wrenable_reg_11;
  output wrenable_reg_12;
  output wrenable_reg_13;
  output wrenable_reg_14;
  output wrenable_reg_15;
  output wrenable_reg_16;
  output wrenable_reg_17;
  output wrenable_reg_18;
  output wrenable_reg_19;
  output wrenable_reg_2;
  output wrenable_reg_20;
  output wrenable_reg_21;
  output wrenable_reg_22;
  output wrenable_reg_23;
  output wrenable_reg_24;
  output wrenable_reg_25;
  output wrenable_reg_26;
  output wrenable_reg_27;
  output wrenable_reg_28;
  output wrenable_reg_29;
  output wrenable_reg_3;
  output wrenable_reg_30;
  output wrenable_reg_31;
  output wrenable_reg_32;
  output wrenable_reg_33;
  output wrenable_reg_34;
  output wrenable_reg_35;
  output wrenable_reg_36;
  output wrenable_reg_37;
  output wrenable_reg_38;
  output wrenable_reg_39;
  output wrenable_reg_4;
  output wrenable_reg_40;
  output wrenable_reg_41;
  output wrenable_reg_42;
  output wrenable_reg_43;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  output wrenable_reg_9;
  parameter [28:0] S_4 = 29'b00000000000000000000000010000,
    S_0 = 29'b00000000000000000000000000001,
    S_1 = 29'b00000000000000000000000000010,
    S_2 = 29'b00000000000000000000000000100,
    S_3 = 29'b00000000000000000000000001000,
    S_5 = 29'b00000000000000000000000100000,
    S_6 = 29'b00000000000000000000001000000,
    S_7 = 29'b00000000000000000000010000000,
    S_8 = 29'b00000000000000000000100000000,
    S_9 = 29'b00000000000000000001000000000,
    S_10 = 29'b00000000000000000010000000000,
    S_11 = 29'b00000000000000000100000000000,
    S_12 = 29'b00000000000000001000000000000,
    S_13 = 29'b00000000000000010000000000000,
    S_14 = 29'b00000000000000100000000000000,
    S_15 = 29'b00000000000001000000000000000,
    S_17 = 29'b00000000000100000000000000000,
    S_18 = 29'b00000000001000000000000000000,
    S_19 = 29'b00000000010000000000000000000,
    S_20 = 29'b00000000100000000000000000000,
    S_21 = 29'b00000001000000000000000000000,
    S_23 = 29'b00000100000000000000000000000,
    S_24 = 29'b00001000000000000000000000000,
    S_27 = 29'b01000000000000000000000000000,
    S_25 = 29'b00010000000000000000000000000,
    S_26 = 29'b00100000000000000000000000000,
    S_28 = 29'b10000000000000000000000000000,
    S_16 = 29'b00000000000010000000000000000,
    S_22 = 29'b00000010000000000000000000000;
  reg [28:0] _present_state=S_4, _next_state;
  reg done_port;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE;
  reg fuselector_BMEMORY_CTRLN_53_i0_LOAD;
  reg fuselector_BMEMORY_CTRLN_53_i0_STORE;
  reg fuselector_BMEMORY_CTRLN_53_i1_LOAD;
  reg fuselector_BMEMORY_CTRLN_53_i1_STORE;
  reg selector_IN_UNBOUNDED_cnn_top_428531_440934;
  reg selector_IN_UNBOUNDED_cnn_top_428531_440935;
  reg selector_IN_UNBOUNDED_cnn_top_428531_440936;
  reg selector_IN_UNBOUNDED_cnn_top_428531_440937;
  reg selector_IN_UNBOUNDED_cnn_top_428531_440938;
  reg selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0;
  reg selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0;
  reg selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0;
  reg selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  reg selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  reg selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0;
  reg selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0;
  reg selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0;
  reg selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0;
  reg selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0;
  reg selector_MUX_44_conv_layer_93_i0_0_0_0;
  reg selector_MUX_45_conv_layer_93_i0_1_0_0;
  reg selector_MUX_46_conv_layer_93_i0_2_0_0;
  reg selector_MUX_46_conv_layer_93_i0_2_0_1;
  reg selector_MUX_46_conv_layer_93_i0_2_0_2;
  reg selector_MUX_46_conv_layer_93_i0_2_1_0;
  reg selector_MUX_47_conv_layer_93_i0_3_0_0;
  reg selector_MUX_47_conv_layer_93_i0_3_0_1;
  reg selector_MUX_47_conv_layer_93_i0_3_0_2;
  reg selector_MUX_47_conv_layer_93_i0_3_1_0;
  reg selector_MUX_48_conv_layer_93_i0_4_0_0;
  reg selector_MUX_48_conv_layer_93_i0_4_0_1;
  reg selector_MUX_48_conv_layer_93_i0_4_0_2;
  reg selector_MUX_48_conv_layer_93_i0_4_1_0;
  reg selector_MUX_49_conv_layer_93_i0_5_0_0;
  reg selector_MUX_49_conv_layer_93_i0_5_0_1;
  reg selector_MUX_49_conv_layer_93_i0_5_0_2;
  reg selector_MUX_49_conv_layer_93_i0_5_1_0;
  reg selector_MUX_50_conv_layer_93_i0_6_0_0;
  reg selector_MUX_50_conv_layer_93_i0_6_0_1;
  reg selector_MUX_50_conv_layer_93_i0_6_1_0;
  reg selector_MUX_51_conv_layer_93_i0_7_0_0;
  reg selector_MUX_51_conv_layer_93_i0_7_0_1;
  reg selector_MUX_51_conv_layer_93_i0_7_1_0;
  reg selector_MUX_52_conv_layer_93_i0_8_0_0;
  reg selector_MUX_52_conv_layer_93_i0_8_0_1;
  reg selector_MUX_52_conv_layer_93_i0_8_1_0;
  reg selector_MUX_53_conv_layer_93_i0_9_0_0;
  reg selector_MUX_72_reg_0_0_0_0;
  reg selector_MUX_76_reg_12_0_0_0;
  reg selector_MUX_77_reg_13_0_0_0;
  reg selector_MUX_78_reg_14_0_0_0;
  reg selector_MUX_79_reg_15_0_0_0;
  reg selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0;
  reg selector_MUX_80_reg_16_0_0_0;
  reg selector_MUX_81_reg_17_0_0_0;
  reg selector_MUX_83_reg_19_0_0_0;
  reg selector_MUX_85_reg_20_0_0_0;
  reg selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0;
  reg selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1;
  reg selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0;
  reg selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_10;
  reg wrenable_reg_11;
  reg wrenable_reg_12;
  reg wrenable_reg_13;
  reg wrenable_reg_14;
  reg wrenable_reg_15;
  reg wrenable_reg_16;
  reg wrenable_reg_17;
  reg wrenable_reg_18;
  reg wrenable_reg_19;
  reg wrenable_reg_2;
  reg wrenable_reg_20;
  reg wrenable_reg_21;
  reg wrenable_reg_22;
  reg wrenable_reg_23;
  reg wrenable_reg_24;
  reg wrenable_reg_25;
  reg wrenable_reg_26;
  reg wrenable_reg_27;
  reg wrenable_reg_28;
  reg wrenable_reg_29;
  reg wrenable_reg_3;
  reg wrenable_reg_30;
  reg wrenable_reg_31;
  reg wrenable_reg_32;
  reg wrenable_reg_33;
  reg wrenable_reg_34;
  reg wrenable_reg_35;
  reg wrenable_reg_36;
  reg wrenable_reg_37;
  reg wrenable_reg_38;
  reg wrenable_reg_39;
  reg wrenable_reg_4;
  reg wrenable_reg_40;
  reg wrenable_reg_41;
  reg wrenable_reg_42;
  reg wrenable_reg_43;
  reg wrenable_reg_5;
  reg wrenable_reg_6;
  reg wrenable_reg_7;
  reg wrenable_reg_8;
  reg wrenable_reg_9;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_4;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE = 1'b0;
    fuselector_BMEMORY_CTRLN_53_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_53_i0_STORE = 1'b0;
    fuselector_BMEMORY_CTRLN_53_i1_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_53_i1_STORE = 1'b0;
    selector_IN_UNBOUNDED_cnn_top_428531_440934 = 1'b0;
    selector_IN_UNBOUNDED_cnn_top_428531_440935 = 1'b0;
    selector_IN_UNBOUNDED_cnn_top_428531_440936 = 1'b0;
    selector_IN_UNBOUNDED_cnn_top_428531_440937 = 1'b0;
    selector_IN_UNBOUNDED_cnn_top_428531_440938 = 1'b0;
    selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0 = 1'b0;
    selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0 = 1'b0;
    selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0 = 1'b0;
    selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0 = 1'b0;
    selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1 = 1'b0;
    selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0 = 1'b0;
    selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0 = 1'b0;
    selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0 = 1'b0;
    selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0 = 1'b0;
    selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0 = 1'b0;
    selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b0;
    selector_MUX_45_conv_layer_93_i0_1_0_0 = 1'b0;
    selector_MUX_46_conv_layer_93_i0_2_0_0 = 1'b0;
    selector_MUX_46_conv_layer_93_i0_2_0_1 = 1'b0;
    selector_MUX_46_conv_layer_93_i0_2_0_2 = 1'b0;
    selector_MUX_46_conv_layer_93_i0_2_1_0 = 1'b0;
    selector_MUX_47_conv_layer_93_i0_3_0_0 = 1'b0;
    selector_MUX_47_conv_layer_93_i0_3_0_1 = 1'b0;
    selector_MUX_47_conv_layer_93_i0_3_0_2 = 1'b0;
    selector_MUX_47_conv_layer_93_i0_3_1_0 = 1'b0;
    selector_MUX_48_conv_layer_93_i0_4_0_0 = 1'b0;
    selector_MUX_48_conv_layer_93_i0_4_0_1 = 1'b0;
    selector_MUX_48_conv_layer_93_i0_4_0_2 = 1'b0;
    selector_MUX_48_conv_layer_93_i0_4_1_0 = 1'b0;
    selector_MUX_49_conv_layer_93_i0_5_0_0 = 1'b0;
    selector_MUX_49_conv_layer_93_i0_5_0_1 = 1'b0;
    selector_MUX_49_conv_layer_93_i0_5_0_2 = 1'b0;
    selector_MUX_49_conv_layer_93_i0_5_1_0 = 1'b0;
    selector_MUX_50_conv_layer_93_i0_6_0_0 = 1'b0;
    selector_MUX_50_conv_layer_93_i0_6_0_1 = 1'b0;
    selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b0;
    selector_MUX_51_conv_layer_93_i0_7_0_0 = 1'b0;
    selector_MUX_51_conv_layer_93_i0_7_0_1 = 1'b0;
    selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b0;
    selector_MUX_52_conv_layer_93_i0_8_0_0 = 1'b0;
    selector_MUX_52_conv_layer_93_i0_8_0_1 = 1'b0;
    selector_MUX_52_conv_layer_93_i0_8_1_0 = 1'b0;
    selector_MUX_53_conv_layer_93_i0_9_0_0 = 1'b0;
    selector_MUX_72_reg_0_0_0_0 = 1'b0;
    selector_MUX_76_reg_12_0_0_0 = 1'b0;
    selector_MUX_77_reg_13_0_0_0 = 1'b0;
    selector_MUX_78_reg_14_0_0_0 = 1'b0;
    selector_MUX_79_reg_15_0_0_0 = 1'b0;
    selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0 = 1'b0;
    selector_MUX_80_reg_16_0_0_0 = 1'b0;
    selector_MUX_81_reg_17_0_0_0 = 1'b0;
    selector_MUX_83_reg_19_0_0_0 = 1'b0;
    selector_MUX_85_reg_20_0_0_0 = 1'b0;
    selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0 = 1'b0;
    selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1 = 1'b0;
    selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0 = 1'b0;
    selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_10 = 1'b0;
    wrenable_reg_11 = 1'b0;
    wrenable_reg_12 = 1'b0;
    wrenable_reg_13 = 1'b0;
    wrenable_reg_14 = 1'b0;
    wrenable_reg_15 = 1'b0;
    wrenable_reg_16 = 1'b0;
    wrenable_reg_17 = 1'b0;
    wrenable_reg_18 = 1'b0;
    wrenable_reg_19 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_20 = 1'b0;
    wrenable_reg_21 = 1'b0;
    wrenable_reg_22 = 1'b0;
    wrenable_reg_23 = 1'b0;
    wrenable_reg_24 = 1'b0;
    wrenable_reg_25 = 1'b0;
    wrenable_reg_26 = 1'b0;
    wrenable_reg_27 = 1'b0;
    wrenable_reg_28 = 1'b0;
    wrenable_reg_29 = 1'b0;
    wrenable_reg_3 = 1'b0;
    wrenable_reg_30 = 1'b0;
    wrenable_reg_31 = 1'b0;
    wrenable_reg_32 = 1'b0;
    wrenable_reg_33 = 1'b0;
    wrenable_reg_34 = 1'b0;
    wrenable_reg_35 = 1'b0;
    wrenable_reg_36 = 1'b0;
    wrenable_reg_37 = 1'b0;
    wrenable_reg_38 = 1'b0;
    wrenable_reg_39 = 1'b0;
    wrenable_reg_4 = 1'b0;
    wrenable_reg_40 = 1'b0;
    wrenable_reg_41 = 1'b0;
    wrenable_reg_42 = 1'b0;
    wrenable_reg_43 = 1'b0;
    wrenable_reg_5 = 1'b0;
    wrenable_reg_6 = 1'b0;
    wrenable_reg_7 = 1'b0;
    wrenable_reg_8 = 1'b0;
    wrenable_reg_9 = 1'b0;
    case (_present_state)
      S_4 :
        if(start_port == 1'b1)
        begin
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_2 = 1'b1;
          _next_state = S_0;
        end
        else
        begin
          _next_state = S_4;
        end
      S_0 :
        begin
          fuselector_BMEMORY_CTRLN_53_i0_LOAD = 1'b1;
          fuselector_BMEMORY_CTRLN_53_i1_LOAD = 1'b1;
          selector_MUX_72_reg_0_0_0_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          _next_state = S_1;
        end
      S_1 :
        begin
          fuselector_BMEMORY_CTRLN_53_i0_LOAD = 1'b1;
          fuselector_BMEMORY_CTRLN_53_i1_LOAD = 1'b1;
          selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0 = 1'b1;
          selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0 = 1'b1;
          wrenable_reg_10 = 1'b1;
          wrenable_reg_11 = 1'b1;
          _next_state = S_2;
        end
      S_2 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE = 1'b1;
          selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0 = 1'b1;
          selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0 = 1'b1;
          wrenable_reg_10 = 1'b1;
          wrenable_reg_11 = 1'b1;
          _next_state = S_3;
        end
      S_3 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE = 1'b1;
          selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0 = 1'b1;
          selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0 = 1'b1;
          if (OUT_CONDITION_cnn_top_428531_428575 == 1'b1)
            begin
              _next_state = S_5;
            end
          else
            begin
              _next_state = S_0;
            end
        end
      S_5 :
        begin
          selector_IN_UNBOUNDED_cnn_top_428531_440934 = 1'b1;
          selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_0_0 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_0_0 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_0_0 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_0_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_0_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_1_0 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440934 == 1'b0)
            begin
              _next_state = S_6;
            end
          else
            begin
              _next_state = S_7;
            end
        end
      S_6 :
        begin
          selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_0_0 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_0_0 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_0_0 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_0_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_0_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_1_0 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440934 == 1'b0)
            begin
              _next_state = S_6;
            end
          else
            begin
              _next_state = S_7;
            end
        end
      S_7 :
        begin
          selector_IN_UNBOUNDED_cnn_top_428531_440935 = 1'b1;
          selector_MUX_45_conv_layer_93_i0_1_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_0_1 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_1_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_0_1 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_0_1 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_1_0 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440935 == 1'b0)
            begin
              _next_state = S_8;
            end
          else
            begin
              _next_state = S_9;
            end
        end
      S_8 :
        begin
          selector_MUX_45_conv_layer_93_i0_1_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_0_1 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_1_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_0_1 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_0_1 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_1_0 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440935 == 1'b0)
            begin
              _next_state = S_8;
            end
          else
            begin
              _next_state = S_9;
            end
        end
      S_9 :
        begin
          selector_IN_UNBOUNDED_cnn_top_428531_440936 = 1'b1;
          selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_1_0 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_0_2 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_0_1 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_1_0 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_0_1 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_1_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_0_1 = 1'b1;
          selector_MUX_53_conv_layer_93_i0_9_0_0 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440936 == 1'b0)
            begin
              _next_state = S_10;
            end
          else
            begin
              _next_state = S_11;
            end
        end
      S_10 :
        begin
          selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_1_0 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_0_2 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_0_1 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_1_0 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_0_1 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_1_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_0_1 = 1'b1;
          selector_MUX_53_conv_layer_93_i0_9_0_0 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440936 == 1'b0)
            begin
              _next_state = S_10;
            end
          else
            begin
              _next_state = S_11;
            end
        end
      S_11 :
        begin
          selector_IN_UNBOUNDED_cnn_top_428531_440937 = 1'b1;
          selector_MUX_45_conv_layer_93_i0_1_0_0 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_1_0 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_1_0 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_0_2 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_0_1 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440937 == 1'b0)
            begin
              _next_state = S_12;
            end
          else
            begin
              _next_state = S_13;
            end
        end
      S_12 :
        begin
          selector_MUX_45_conv_layer_93_i0_1_0_0 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_1_0 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_1_0 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_0_2 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b1;
          selector_MUX_52_conv_layer_93_i0_8_0_1 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440937 == 1'b0)
            begin
              _next_state = S_12;
            end
          else
            begin
              _next_state = S_13;
            end
        end
      S_13 :
        begin
          selector_IN_UNBOUNDED_cnn_top_428531_440938 = 1'b1;
          selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_0_2 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_0_1 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_1_0 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_0_2 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_1_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_0_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_0_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b1;
          selector_MUX_53_conv_layer_93_i0_9_0_0 = 1'b1;
          wrenable_reg_12 = 1'b1;
          wrenable_reg_13 = 1'b1;
          wrenable_reg_14 = 1'b1;
          wrenable_reg_15 = 1'b1;
          wrenable_reg_16 = 1'b1;
          wrenable_reg_17 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440938 == 1'b0)
            begin
              _next_state = S_14;
              wrenable_reg_12 = 1'b0;
              wrenable_reg_13 = 1'b0;
              wrenable_reg_14 = 1'b0;
              wrenable_reg_15 = 1'b0;
              wrenable_reg_16 = 1'b0;
              wrenable_reg_17 = 1'b0;
            end
          else
            begin
              _next_state = S_15;
            end
        end
      S_14 :
        begin
          selector_MUX_44_conv_layer_93_i0_0_0_0 = 1'b1;
          selector_MUX_46_conv_layer_93_i0_2_0_2 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_0_1 = 1'b1;
          selector_MUX_47_conv_layer_93_i0_3_1_0 = 1'b1;
          selector_MUX_48_conv_layer_93_i0_4_0_2 = 1'b1;
          selector_MUX_49_conv_layer_93_i0_5_1_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_0_0 = 1'b1;
          selector_MUX_50_conv_layer_93_i0_6_1_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_0_0 = 1'b1;
          selector_MUX_51_conv_layer_93_i0_7_1_0 = 1'b1;
          selector_MUX_53_conv_layer_93_i0_9_0_0 = 1'b1;
          wrenable_reg_12 = 1'b1;
          wrenable_reg_13 = 1'b1;
          wrenable_reg_14 = 1'b1;
          wrenable_reg_15 = 1'b1;
          wrenable_reg_16 = 1'b1;
          wrenable_reg_17 = 1'b1;
          if (OUT_UNBOUNDED_cnn_top_428531_440938 == 1'b0)
            begin
              _next_state = S_14;
              wrenable_reg_12 = 1'b0;
              wrenable_reg_13 = 1'b0;
              wrenable_reg_14 = 1'b0;
              wrenable_reg_15 = 1'b0;
              wrenable_reg_16 = 1'b0;
              wrenable_reg_17 = 1'b0;
            end
          else
            begin
              _next_state = S_15;
            end
        end
      S_15 :
        begin
          selector_MUX_76_reg_12_0_0_0 = 1'b1;
          selector_MUX_78_reg_14_0_0_0 = 1'b1;
          selector_MUX_79_reg_15_0_0_0 = 1'b1;
          selector_MUX_81_reg_17_0_0_0 = 1'b1;
          selector_MUX_85_reg_20_0_0_0 = 1'b1;
          wrenable_reg_12 = 1'b1;
          wrenable_reg_14 = 1'b1;
          wrenable_reg_15 = 1'b1;
          wrenable_reg_17 = 1'b1;
          wrenable_reg_18 = 1'b1;
          wrenable_reg_19 = 1'b1;
          wrenable_reg_20 = 1'b1;
          wrenable_reg_21 = 1'b1;
          wrenable_reg_22 = 1'b1;
          wrenable_reg_23 = 1'b1;
          wrenable_reg_24 = 1'b1;
          wrenable_reg_25 = 1'b1;
          _next_state = S_17;
        end
      S_17 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD = 1'b1;
          wrenable_reg_20 = 1'b1;
          wrenable_reg_26 = 1'b1;
          wrenable_reg_27 = 1'b1;
          wrenable_reg_28 = 1'b1;
          wrenable_reg_29 = 1'b1;
          wrenable_reg_30 = 1'b1;
          wrenable_reg_31 = 1'b1;
          wrenable_reg_32 = 1'b1;
          _next_state = S_18;
        end
      S_18 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD = 1'b1;
          selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1 = 1'b1;
          selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1 = 1'b1;
          wrenable_reg_33 = 1'b1;
          wrenable_reg_34 = 1'b1;
          _next_state = S_19;
        end
      S_19 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD = 1'b1;
          selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0 = 1'b1;
          selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0 = 1'b1;
          wrenable_reg_35 = 1'b1;
          _next_state = S_20;
        end
      S_20 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD = 1'b1;
          selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0 = 1'b1;
          selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0 = 1'b1;
          selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0 = 1'b1;
          selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0 = 1'b1;
          wrenable_reg_36 = 1'b1;
          wrenable_reg_37 = 1'b1;
          _next_state = S_21;
        end
      S_21 :
        begin
          selector_MUX_83_reg_19_0_0_0 = 1'b1;
          wrenable_reg_19 = 1'b1;
          if (OUT_CONDITION_cnn_top_428531_446014 == 1'b1)
            begin
              _next_state = S_23;
            end
          else
            begin
              _next_state = S_17;
            end
        end
      S_23 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD = 1'b1;
          wrenable_reg_38 = 1'b1;
          wrenable_reg_39 = 1'b1;
          _next_state = S_24;
        end
      S_24 :
        begin
          wrenable_reg_40 = 1'b1;
          wrenable_reg_41 = 1'b1;
          if (OUT_CONDITION_cnn_top_428531_446026 == 1'b1)
            begin
              _next_state = S_25;
              wrenable_reg_40 = 1'b0;
              wrenable_reg_41 = 1'b0;
            end
          else
            begin
              _next_state = S_27;
            end
        end
      S_27 :
        begin
          selector_MUX_77_reg_13_0_0_0 = 1'b1;
          wrenable_reg_13 = 1'b1;
          _next_state = S_25;
        end
      S_25 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD = 1'b1;
          selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0 = 1'b1;
          _next_state = S_26;
        end
      S_26 :
        begin
          selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0 = 1'b1;
          wrenable_reg_42 = 1'b1;
          wrenable_reg_43 = 1'b1;
          if (OUT_CONDITION_cnn_top_428531_446030 == 1'b1)
            begin
              _next_state = S_16;
              wrenable_reg_42 = 1'b0;
              wrenable_reg_43 = 1'b0;
            end
          else
            begin
              _next_state = S_28;
            end
        end
      S_28 :
        begin
          selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0 = 1'b1;
          selector_MUX_80_reg_16_0_0_0 = 1'b1;
          wrenable_reg_16 = 1'b1;
          _next_state = S_16;
        end
      S_16 :
        begin
          if (OUT_CONDITION_cnn_top_428531_446010 == 1'b1)
            begin
              _next_state = S_22;
              done_port = 1'b1;
            end
          else
            begin
              _next_state = S_15;
            end
        end
      S_22 :
        begin
          _next_state = S_4;
        end
      default :
        begin
          _next_state = S_4;
        end
    endcase
  end
endmodule

// Top component for cnn_top
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _cnn_top(clock,
  reset,
  start_port,
  done_port,
  img,
  return_port,
  M_Rdata_ram,
  M_DataRdy,
  Min_oe_ram,
  Min_we_ram,
  Min_addr_ram,
  Min_Wdata_ram,
  Min_data_ram_size,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size);
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] img;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  input [1:0] Min_oe_ram;
  input [1:0] Min_we_ram;
  input [63:0] Min_addr_ram;
  input [63:0] Min_Wdata_ram;
  input [11:0] Min_data_ram_size;
  // OUT
  output done_port;
  output [31:0] return_port;
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  // Component and signal declarations
  wire OUT_CONDITION_cnn_top_428531_428575;
  wire OUT_CONDITION_cnn_top_428531_446010;
  wire OUT_CONDITION_cnn_top_428531_446014;
  wire OUT_CONDITION_cnn_top_428531_446026;
  wire OUT_CONDITION_cnn_top_428531_446030;
  wire OUT_UNBOUNDED_cnn_top_428531_440934;
  wire OUT_UNBOUNDED_cnn_top_428531_440935;
  wire OUT_UNBOUNDED_cnn_top_428531_440936;
  wire OUT_UNBOUNDED_cnn_top_428531_440937;
  wire OUT_UNBOUNDED_cnn_top_428531_440938;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE;
  wire fuselector_BMEMORY_CTRLN_53_i0_LOAD;
  wire fuselector_BMEMORY_CTRLN_53_i0_STORE;
  wire fuselector_BMEMORY_CTRLN_53_i1_LOAD;
  wire fuselector_BMEMORY_CTRLN_53_i1_STORE;
  wire selector_IN_UNBOUNDED_cnn_top_428531_440934;
  wire selector_IN_UNBOUNDED_cnn_top_428531_440935;
  wire selector_IN_UNBOUNDED_cnn_top_428531_440936;
  wire selector_IN_UNBOUNDED_cnn_top_428531_440937;
  wire selector_IN_UNBOUNDED_cnn_top_428531_440938;
  wire selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0;
  wire selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0;
  wire selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0;
  wire selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0;
  wire selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1;
  wire selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0;
  wire selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0;
  wire selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0;
  wire selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0;
  wire selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0;
  wire selector_MUX_44_conv_layer_93_i0_0_0_0;
  wire selector_MUX_45_conv_layer_93_i0_1_0_0;
  wire selector_MUX_46_conv_layer_93_i0_2_0_0;
  wire selector_MUX_46_conv_layer_93_i0_2_0_1;
  wire selector_MUX_46_conv_layer_93_i0_2_0_2;
  wire selector_MUX_46_conv_layer_93_i0_2_1_0;
  wire selector_MUX_47_conv_layer_93_i0_3_0_0;
  wire selector_MUX_47_conv_layer_93_i0_3_0_1;
  wire selector_MUX_47_conv_layer_93_i0_3_0_2;
  wire selector_MUX_47_conv_layer_93_i0_3_1_0;
  wire selector_MUX_48_conv_layer_93_i0_4_0_0;
  wire selector_MUX_48_conv_layer_93_i0_4_0_1;
  wire selector_MUX_48_conv_layer_93_i0_4_0_2;
  wire selector_MUX_48_conv_layer_93_i0_4_1_0;
  wire selector_MUX_49_conv_layer_93_i0_5_0_0;
  wire selector_MUX_49_conv_layer_93_i0_5_0_1;
  wire selector_MUX_49_conv_layer_93_i0_5_0_2;
  wire selector_MUX_49_conv_layer_93_i0_5_1_0;
  wire selector_MUX_50_conv_layer_93_i0_6_0_0;
  wire selector_MUX_50_conv_layer_93_i0_6_0_1;
  wire selector_MUX_50_conv_layer_93_i0_6_1_0;
  wire selector_MUX_51_conv_layer_93_i0_7_0_0;
  wire selector_MUX_51_conv_layer_93_i0_7_0_1;
  wire selector_MUX_51_conv_layer_93_i0_7_1_0;
  wire selector_MUX_52_conv_layer_93_i0_8_0_0;
  wire selector_MUX_52_conv_layer_93_i0_8_0_1;
  wire selector_MUX_52_conv_layer_93_i0_8_1_0;
  wire selector_MUX_53_conv_layer_93_i0_9_0_0;
  wire selector_MUX_72_reg_0_0_0_0;
  wire selector_MUX_76_reg_12_0_0_0;
  wire selector_MUX_77_reg_13_0_0_0;
  wire selector_MUX_78_reg_14_0_0_0;
  wire selector_MUX_79_reg_15_0_0_0;
  wire selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0;
  wire selector_MUX_80_reg_16_0_0_0;
  wire selector_MUX_81_reg_17_0_0_0;
  wire selector_MUX_83_reg_19_0_0_0;
  wire selector_MUX_85_reg_20_0_0_0;
  wire selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0;
  wire selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1;
  wire selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0;
  wire selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_10;
  wire wrenable_reg_11;
  wire wrenable_reg_12;
  wire wrenable_reg_13;
  wire wrenable_reg_14;
  wire wrenable_reg_15;
  wire wrenable_reg_16;
  wire wrenable_reg_17;
  wire wrenable_reg_18;
  wire wrenable_reg_19;
  wire wrenable_reg_2;
  wire wrenable_reg_20;
  wire wrenable_reg_21;
  wire wrenable_reg_22;
  wire wrenable_reg_23;
  wire wrenable_reg_24;
  wire wrenable_reg_25;
  wire wrenable_reg_26;
  wire wrenable_reg_27;
  wire wrenable_reg_28;
  wire wrenable_reg_29;
  wire wrenable_reg_3;
  wire wrenable_reg_30;
  wire wrenable_reg_31;
  wire wrenable_reg_32;
  wire wrenable_reg_33;
  wire wrenable_reg_34;
  wire wrenable_reg_35;
  wire wrenable_reg_36;
  wire wrenable_reg_37;
  wire wrenable_reg_38;
  wire wrenable_reg_39;
  wire wrenable_reg_4;
  wire wrenable_reg_40;
  wire wrenable_reg_41;
  wire wrenable_reg_42;
  wire wrenable_reg_43;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  wire wrenable_reg_9;
  
  controller_cnn_top Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE),
    .fuselector_BMEMORY_CTRLN_53_i0_LOAD(fuselector_BMEMORY_CTRLN_53_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_53_i0_STORE(fuselector_BMEMORY_CTRLN_53_i0_STORE),
    .fuselector_BMEMORY_CTRLN_53_i1_LOAD(fuselector_BMEMORY_CTRLN_53_i1_LOAD),
    .fuselector_BMEMORY_CTRLN_53_i1_STORE(fuselector_BMEMORY_CTRLN_53_i1_STORE),
    .selector_IN_UNBOUNDED_cnn_top_428531_440934(selector_IN_UNBOUNDED_cnn_top_428531_440934),
    .selector_IN_UNBOUNDED_cnn_top_428531_440935(selector_IN_UNBOUNDED_cnn_top_428531_440935),
    .selector_IN_UNBOUNDED_cnn_top_428531_440936(selector_IN_UNBOUNDED_cnn_top_428531_440936),
    .selector_IN_UNBOUNDED_cnn_top_428531_440937(selector_IN_UNBOUNDED_cnn_top_428531_440937),
    .selector_IN_UNBOUNDED_cnn_top_428531_440938(selector_IN_UNBOUNDED_cnn_top_428531_440938),
    .selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0),
    .selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0(selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0),
    .selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0(selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0),
    .selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0),
    .selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0(selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0),
    .selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0(selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0),
    .selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0(selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0),
    .selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0(selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0),
    .selector_MUX_44_conv_layer_93_i0_0_0_0(selector_MUX_44_conv_layer_93_i0_0_0_0),
    .selector_MUX_45_conv_layer_93_i0_1_0_0(selector_MUX_45_conv_layer_93_i0_1_0_0),
    .selector_MUX_46_conv_layer_93_i0_2_0_0(selector_MUX_46_conv_layer_93_i0_2_0_0),
    .selector_MUX_46_conv_layer_93_i0_2_0_1(selector_MUX_46_conv_layer_93_i0_2_0_1),
    .selector_MUX_46_conv_layer_93_i0_2_0_2(selector_MUX_46_conv_layer_93_i0_2_0_2),
    .selector_MUX_46_conv_layer_93_i0_2_1_0(selector_MUX_46_conv_layer_93_i0_2_1_0),
    .selector_MUX_47_conv_layer_93_i0_3_0_0(selector_MUX_47_conv_layer_93_i0_3_0_0),
    .selector_MUX_47_conv_layer_93_i0_3_0_1(selector_MUX_47_conv_layer_93_i0_3_0_1),
    .selector_MUX_47_conv_layer_93_i0_3_0_2(selector_MUX_47_conv_layer_93_i0_3_0_2),
    .selector_MUX_47_conv_layer_93_i0_3_1_0(selector_MUX_47_conv_layer_93_i0_3_1_0),
    .selector_MUX_48_conv_layer_93_i0_4_0_0(selector_MUX_48_conv_layer_93_i0_4_0_0),
    .selector_MUX_48_conv_layer_93_i0_4_0_1(selector_MUX_48_conv_layer_93_i0_4_0_1),
    .selector_MUX_48_conv_layer_93_i0_4_0_2(selector_MUX_48_conv_layer_93_i0_4_0_2),
    .selector_MUX_48_conv_layer_93_i0_4_1_0(selector_MUX_48_conv_layer_93_i0_4_1_0),
    .selector_MUX_49_conv_layer_93_i0_5_0_0(selector_MUX_49_conv_layer_93_i0_5_0_0),
    .selector_MUX_49_conv_layer_93_i0_5_0_1(selector_MUX_49_conv_layer_93_i0_5_0_1),
    .selector_MUX_49_conv_layer_93_i0_5_0_2(selector_MUX_49_conv_layer_93_i0_5_0_2),
    .selector_MUX_49_conv_layer_93_i0_5_1_0(selector_MUX_49_conv_layer_93_i0_5_1_0),
    .selector_MUX_50_conv_layer_93_i0_6_0_0(selector_MUX_50_conv_layer_93_i0_6_0_0),
    .selector_MUX_50_conv_layer_93_i0_6_0_1(selector_MUX_50_conv_layer_93_i0_6_0_1),
    .selector_MUX_50_conv_layer_93_i0_6_1_0(selector_MUX_50_conv_layer_93_i0_6_1_0),
    .selector_MUX_51_conv_layer_93_i0_7_0_0(selector_MUX_51_conv_layer_93_i0_7_0_0),
    .selector_MUX_51_conv_layer_93_i0_7_0_1(selector_MUX_51_conv_layer_93_i0_7_0_1),
    .selector_MUX_51_conv_layer_93_i0_7_1_0(selector_MUX_51_conv_layer_93_i0_7_1_0),
    .selector_MUX_52_conv_layer_93_i0_8_0_0(selector_MUX_52_conv_layer_93_i0_8_0_0),
    .selector_MUX_52_conv_layer_93_i0_8_0_1(selector_MUX_52_conv_layer_93_i0_8_0_1),
    .selector_MUX_52_conv_layer_93_i0_8_1_0(selector_MUX_52_conv_layer_93_i0_8_1_0),
    .selector_MUX_53_conv_layer_93_i0_9_0_0(selector_MUX_53_conv_layer_93_i0_9_0_0),
    .selector_MUX_72_reg_0_0_0_0(selector_MUX_72_reg_0_0_0_0),
    .selector_MUX_76_reg_12_0_0_0(selector_MUX_76_reg_12_0_0_0),
    .selector_MUX_77_reg_13_0_0_0(selector_MUX_77_reg_13_0_0_0),
    .selector_MUX_78_reg_14_0_0_0(selector_MUX_78_reg_14_0_0_0),
    .selector_MUX_79_reg_15_0_0_0(selector_MUX_79_reg_15_0_0_0),
    .selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0(selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0),
    .selector_MUX_80_reg_16_0_0_0(selector_MUX_80_reg_16_0_0_0),
    .selector_MUX_81_reg_17_0_0_0(selector_MUX_81_reg_17_0_0_0),
    .selector_MUX_83_reg_19_0_0_0(selector_MUX_83_reg_19_0_0_0),
    .selector_MUX_85_reg_20_0_0_0(selector_MUX_85_reg_20_0_0_0),
    .selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0),
    .selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1),
    .selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0),
    .selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0(selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_10(wrenable_reg_10),
    .wrenable_reg_11(wrenable_reg_11),
    .wrenable_reg_12(wrenable_reg_12),
    .wrenable_reg_13(wrenable_reg_13),
    .wrenable_reg_14(wrenable_reg_14),
    .wrenable_reg_15(wrenable_reg_15),
    .wrenable_reg_16(wrenable_reg_16),
    .wrenable_reg_17(wrenable_reg_17),
    .wrenable_reg_18(wrenable_reg_18),
    .wrenable_reg_19(wrenable_reg_19),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_20(wrenable_reg_20),
    .wrenable_reg_21(wrenable_reg_21),
    .wrenable_reg_22(wrenable_reg_22),
    .wrenable_reg_23(wrenable_reg_23),
    .wrenable_reg_24(wrenable_reg_24),
    .wrenable_reg_25(wrenable_reg_25),
    .wrenable_reg_26(wrenable_reg_26),
    .wrenable_reg_27(wrenable_reg_27),
    .wrenable_reg_28(wrenable_reg_28),
    .wrenable_reg_29(wrenable_reg_29),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_30(wrenable_reg_30),
    .wrenable_reg_31(wrenable_reg_31),
    .wrenable_reg_32(wrenable_reg_32),
    .wrenable_reg_33(wrenable_reg_33),
    .wrenable_reg_34(wrenable_reg_34),
    .wrenable_reg_35(wrenable_reg_35),
    .wrenable_reg_36(wrenable_reg_36),
    .wrenable_reg_37(wrenable_reg_37),
    .wrenable_reg_38(wrenable_reg_38),
    .wrenable_reg_39(wrenable_reg_39),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_40(wrenable_reg_40),
    .wrenable_reg_41(wrenable_reg_41),
    .wrenable_reg_42(wrenable_reg_42),
    .wrenable_reg_43(wrenable_reg_43),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9),
    .OUT_CONDITION_cnn_top_428531_428575(OUT_CONDITION_cnn_top_428531_428575),
    .OUT_CONDITION_cnn_top_428531_446010(OUT_CONDITION_cnn_top_428531_446010),
    .OUT_CONDITION_cnn_top_428531_446014(OUT_CONDITION_cnn_top_428531_446014),
    .OUT_CONDITION_cnn_top_428531_446026(OUT_CONDITION_cnn_top_428531_446026),
    .OUT_CONDITION_cnn_top_428531_446030(OUT_CONDITION_cnn_top_428531_446030),
    .OUT_UNBOUNDED_cnn_top_428531_440934(OUT_UNBOUNDED_cnn_top_428531_440934),
    .OUT_UNBOUNDED_cnn_top_428531_440935(OUT_UNBOUNDED_cnn_top_428531_440935),
    .OUT_UNBOUNDED_cnn_top_428531_440936(OUT_UNBOUNDED_cnn_top_428531_440936),
    .OUT_UNBOUNDED_cnn_top_428531_440937(OUT_UNBOUNDED_cnn_top_428531_440937),
    .OUT_UNBOUNDED_cnn_top_428531_440938(OUT_UNBOUNDED_cnn_top_428531_440938),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_cnn_top #(.MEM_var_428598_428531(16384),
    .MEM_var_440988_428530(16384),
    .MEM_var_446454_428530(16384),
    .MEM_var_446587_428530(16384)) Datapath_i (.return_port(return_port),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_cnn_top_428531_428575(OUT_CONDITION_cnn_top_428531_428575),
    .OUT_CONDITION_cnn_top_428531_446010(OUT_CONDITION_cnn_top_428531_446010),
    .OUT_CONDITION_cnn_top_428531_446014(OUT_CONDITION_cnn_top_428531_446014),
    .OUT_CONDITION_cnn_top_428531_446026(OUT_CONDITION_cnn_top_428531_446026),
    .OUT_CONDITION_cnn_top_428531_446030(OUT_CONDITION_cnn_top_428531_446030),
    .OUT_UNBOUNDED_cnn_top_428531_440934(OUT_UNBOUNDED_cnn_top_428531_440934),
    .OUT_UNBOUNDED_cnn_top_428531_440935(OUT_UNBOUNDED_cnn_top_428531_440935),
    .OUT_UNBOUNDED_cnn_top_428531_440936(OUT_UNBOUNDED_cnn_top_428531_440936),
    .OUT_UNBOUNDED_cnn_top_428531_440937(OUT_UNBOUNDED_cnn_top_428531_440937),
    .OUT_UNBOUNDED_cnn_top_428531_440938(OUT_UNBOUNDED_cnn_top_428531_440938),
    .clock(clock),
    .reset(reset),
    .in_port_img(img),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_STORE),
    .fuselector_BMEMORY_CTRLN_53_i0_LOAD(fuselector_BMEMORY_CTRLN_53_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_53_i0_STORE(fuselector_BMEMORY_CTRLN_53_i0_STORE),
    .fuselector_BMEMORY_CTRLN_53_i1_LOAD(fuselector_BMEMORY_CTRLN_53_i1_LOAD),
    .fuselector_BMEMORY_CTRLN_53_i1_STORE(fuselector_BMEMORY_CTRLN_53_i1_STORE),
    .selector_IN_UNBOUNDED_cnn_top_428531_440934(selector_IN_UNBOUNDED_cnn_top_428531_440934),
    .selector_IN_UNBOUNDED_cnn_top_428531_440935(selector_IN_UNBOUNDED_cnn_top_428531_440935),
    .selector_IN_UNBOUNDED_cnn_top_428531_440936(selector_IN_UNBOUNDED_cnn_top_428531_440936),
    .selector_IN_UNBOUNDED_cnn_top_428531_440937(selector_IN_UNBOUNDED_cnn_top_428531_440937),
    .selector_IN_UNBOUNDED_cnn_top_428531_440938(selector_IN_UNBOUNDED_cnn_top_428531_440938),
    .selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0(selector_MUX_0_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_0_0_0),
    .selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0(selector_MUX_14_ARRAY_1D_STD_BRAM_NN_SDS_1_i0_1_0_0),
    .selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0(selector_MUX_17_BMEMORY_CTRLN_53_i0_1_0_0),
    .selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_0),
    .selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_0_1),
    .selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0(selector_MUX_1_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_1_1_0),
    .selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0(selector_MUX_207_ui_lshift_expr_FU_32_32_32_75_i0_1_0_0),
    .selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0(selector_MUX_20_BMEMORY_CTRLN_53_i1_1_0_0),
    .selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0(selector_MUX_299_ui_rshift_expr_FU_32_32_32_90_i0_1_0_0),
    .selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0(selector_MUX_2_ARRAY_1D_STD_BRAM_NN_SDS_0_i0_2_0_0),
    .selector_MUX_44_conv_layer_93_i0_0_0_0(selector_MUX_44_conv_layer_93_i0_0_0_0),
    .selector_MUX_45_conv_layer_93_i0_1_0_0(selector_MUX_45_conv_layer_93_i0_1_0_0),
    .selector_MUX_46_conv_layer_93_i0_2_0_0(selector_MUX_46_conv_layer_93_i0_2_0_0),
    .selector_MUX_46_conv_layer_93_i0_2_0_1(selector_MUX_46_conv_layer_93_i0_2_0_1),
    .selector_MUX_46_conv_layer_93_i0_2_0_2(selector_MUX_46_conv_layer_93_i0_2_0_2),
    .selector_MUX_46_conv_layer_93_i0_2_1_0(selector_MUX_46_conv_layer_93_i0_2_1_0),
    .selector_MUX_47_conv_layer_93_i0_3_0_0(selector_MUX_47_conv_layer_93_i0_3_0_0),
    .selector_MUX_47_conv_layer_93_i0_3_0_1(selector_MUX_47_conv_layer_93_i0_3_0_1),
    .selector_MUX_47_conv_layer_93_i0_3_0_2(selector_MUX_47_conv_layer_93_i0_3_0_2),
    .selector_MUX_47_conv_layer_93_i0_3_1_0(selector_MUX_47_conv_layer_93_i0_3_1_0),
    .selector_MUX_48_conv_layer_93_i0_4_0_0(selector_MUX_48_conv_layer_93_i0_4_0_0),
    .selector_MUX_48_conv_layer_93_i0_4_0_1(selector_MUX_48_conv_layer_93_i0_4_0_1),
    .selector_MUX_48_conv_layer_93_i0_4_0_2(selector_MUX_48_conv_layer_93_i0_4_0_2),
    .selector_MUX_48_conv_layer_93_i0_4_1_0(selector_MUX_48_conv_layer_93_i0_4_1_0),
    .selector_MUX_49_conv_layer_93_i0_5_0_0(selector_MUX_49_conv_layer_93_i0_5_0_0),
    .selector_MUX_49_conv_layer_93_i0_5_0_1(selector_MUX_49_conv_layer_93_i0_5_0_1),
    .selector_MUX_49_conv_layer_93_i0_5_0_2(selector_MUX_49_conv_layer_93_i0_5_0_2),
    .selector_MUX_49_conv_layer_93_i0_5_1_0(selector_MUX_49_conv_layer_93_i0_5_1_0),
    .selector_MUX_50_conv_layer_93_i0_6_0_0(selector_MUX_50_conv_layer_93_i0_6_0_0),
    .selector_MUX_50_conv_layer_93_i0_6_0_1(selector_MUX_50_conv_layer_93_i0_6_0_1),
    .selector_MUX_50_conv_layer_93_i0_6_1_0(selector_MUX_50_conv_layer_93_i0_6_1_0),
    .selector_MUX_51_conv_layer_93_i0_7_0_0(selector_MUX_51_conv_layer_93_i0_7_0_0),
    .selector_MUX_51_conv_layer_93_i0_7_0_1(selector_MUX_51_conv_layer_93_i0_7_0_1),
    .selector_MUX_51_conv_layer_93_i0_7_1_0(selector_MUX_51_conv_layer_93_i0_7_1_0),
    .selector_MUX_52_conv_layer_93_i0_8_0_0(selector_MUX_52_conv_layer_93_i0_8_0_0),
    .selector_MUX_52_conv_layer_93_i0_8_0_1(selector_MUX_52_conv_layer_93_i0_8_0_1),
    .selector_MUX_52_conv_layer_93_i0_8_1_0(selector_MUX_52_conv_layer_93_i0_8_1_0),
    .selector_MUX_53_conv_layer_93_i0_9_0_0(selector_MUX_53_conv_layer_93_i0_9_0_0),
    .selector_MUX_72_reg_0_0_0_0(selector_MUX_72_reg_0_0_0_0),
    .selector_MUX_76_reg_12_0_0_0(selector_MUX_76_reg_12_0_0_0),
    .selector_MUX_77_reg_13_0_0_0(selector_MUX_77_reg_13_0_0_0),
    .selector_MUX_78_reg_14_0_0_0(selector_MUX_78_reg_14_0_0_0),
    .selector_MUX_79_reg_15_0_0_0(selector_MUX_79_reg_15_0_0_0),
    .selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0(selector_MUX_7_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_0_0_0),
    .selector_MUX_80_reg_16_0_0_0(selector_MUX_80_reg_16_0_0_0),
    .selector_MUX_81_reg_17_0_0_0(selector_MUX_81_reg_17_0_0_0),
    .selector_MUX_83_reg_19_0_0_0(selector_MUX_83_reg_19_0_0_0),
    .selector_MUX_85_reg_20_0_0_0(selector_MUX_85_reg_20_0_0_0),
    .selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_0),
    .selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_0_1),
    .selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0(selector_MUX_8_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_1_1_0),
    .selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0(selector_MUX_9_ARRAY_1D_STD_BRAM_NN_SDS_0_i1_2_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_10(wrenable_reg_10),
    .wrenable_reg_11(wrenable_reg_11),
    .wrenable_reg_12(wrenable_reg_12),
    .wrenable_reg_13(wrenable_reg_13),
    .wrenable_reg_14(wrenable_reg_14),
    .wrenable_reg_15(wrenable_reg_15),
    .wrenable_reg_16(wrenable_reg_16),
    .wrenable_reg_17(wrenable_reg_17),
    .wrenable_reg_18(wrenable_reg_18),
    .wrenable_reg_19(wrenable_reg_19),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_20(wrenable_reg_20),
    .wrenable_reg_21(wrenable_reg_21),
    .wrenable_reg_22(wrenable_reg_22),
    .wrenable_reg_23(wrenable_reg_23),
    .wrenable_reg_24(wrenable_reg_24),
    .wrenable_reg_25(wrenable_reg_25),
    .wrenable_reg_26(wrenable_reg_26),
    .wrenable_reg_27(wrenable_reg_27),
    .wrenable_reg_28(wrenable_reg_28),
    .wrenable_reg_29(wrenable_reg_29),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_30(wrenable_reg_30),
    .wrenable_reg_31(wrenable_reg_31),
    .wrenable_reg_32(wrenable_reg_32),
    .wrenable_reg_33(wrenable_reg_33),
    .wrenable_reg_34(wrenable_reg_34),
    .wrenable_reg_35(wrenable_reg_35),
    .wrenable_reg_36(wrenable_reg_36),
    .wrenable_reg_37(wrenable_reg_37),
    .wrenable_reg_38(wrenable_reg_38),
    .wrenable_reg_39(wrenable_reg_39),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_40(wrenable_reg_40),
    .wrenable_reg_41(wrenable_reg_41),
    .wrenable_reg_42(wrenable_reg_42),
    .wrenable_reg_43(wrenable_reg_43),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9));
  flipflop_AR #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out),
    .clock(clock),
    .reset(reset),
    .in1(done_delayed_REG_signal_in));
  // io-signal post fix
  assign done_port = done_delayed_REG_signal_out;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2024 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_view_convert_expr_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// Minimal interface for function: cnn_top
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module cnn_top(clock,
  reset,
  start_port,
  img,
  M_Rdata_ram,
  M_DataRdy,
  done_port,
  return_port,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size);
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] img;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  // OUT
  output done_port;
  output [31:0] return_port;
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  // Component and signal declarations
  wire [31:0] out_return_port_ui_view_convert_expr_FU;
  
  _cnn_top _cnn_top_i0 (.done_port(done_port),
    .return_port(out_return_port_ui_view_convert_expr_FU),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .reset(reset),
    .start_port(start_port),
    .img(img),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram({1'b0,
      1'b0}),
    .Min_we_ram({1'b0,
      1'b0}),
    .Min_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Min_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Min_data_ram_size({6'b000000,
      6'b000000}));
  ui_view_convert_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) return_port_ui_view_convert_expr_FU (.out1(return_port),
    .in1(out_return_port_ui_view_convert_expr_FU));

endmodule


