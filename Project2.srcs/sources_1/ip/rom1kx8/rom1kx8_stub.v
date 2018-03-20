// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Tue Mar 20 03:54:18 2018
// Host        : 25thBam running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Jason/Desktop/EGR
//               426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/rom1kx8/rom1kx8_stub.v}
// Design      : rom1kx8
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.2" *)
module rom1kx8(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[9:0],douta[7:0]" */;
  input clka;
  input [9:0]addra;
  output [7:0]douta;
endmodule
