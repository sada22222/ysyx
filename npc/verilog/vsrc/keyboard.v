module PS2Keyboard(
  input        clock,
  input        reset,
  input        io_ps2_clk,
  input        io_ps2_data,
  input        io_fifo_clean,
  output [7:0] io_data,
  output       io_ready
);
  reg [9:0] buffer; // @[ps_data.scala 16:23]
  reg [31:0] _RAND_0;
  reg [7:0] fifo_0; // @[ps_data.scala 17:21]
  reg [31:0] _RAND_1;
  reg [2:0] w_ptr; // @[ps_data.scala 18:22]
  reg [31:0] _RAND_2;
  reg [3:0] count; // @[ps_data.scala 20:22]
  reg [31:0] _RAND_3;
  reg  ps2_clk_sync_1; // @[ps_data.scala 21:29]
  reg [31:0] _RAND_4;
  reg  ps2_clk_sync_2; // @[ps_data.scala 21:29]
  reg [31:0] _RAND_5;
  wire  _T_2 = ~ps2_clk_sync_1; // @[ps_data.scala 25:37]
  wire  sampling = ps2_clk_sync_2 & _T_2; // @[ps_data.scala 25:34]
  reg  ready; // @[ps_data.scala 28:22]
  reg [31:0] _RAND_6;
  wire [9:0] _GEN_11 = io_fifo_clean ? 10'h0 : buffer; // @[ps_data.scala 30:23]
  wire  _T_3 = count == 4'ha; // @[ps_data.scala 39:17]
  wire  _T_5 = ~buffer[0]; // @[ps_data.scala 40:23]
  wire  _T_6 = _T_5 & io_ps2_data; // @[ps_data.scala 40:31]
  wire  _T_8 = ^buffer[9:1]; // @[ps_data.scala 40:62]
  wire  _T_9 = _T_6 & _T_8; // @[ps_data.scala 40:46]
  wire [2:0] _T_12 = w_ptr + 3'h1; // @[ps_data.scala 42:24]
  wire  _GEN_29 = _T_9 | ready; // @[ps_data.scala 40:68]
  wire [15:0] _T_17 = 16'h1 << count; // @[ps_data.scala 49:30]
  wire [15:0] _GEN_68 = {{6'd0}, buffer}; // @[ps_data.scala 49:30]
  wire [15:0] _T_18 = _GEN_68 | _T_17; // @[ps_data.scala 49:30]
  wire [9:0] _T_19 = ~buffer; // @[ps_data.scala 49:30]
  wire [15:0] _GEN_69 = {{6'd0}, _T_19}; // @[ps_data.scala 49:30]
  wire [15:0] _T_20 = _GEN_69 | _T_17; // @[ps_data.scala 49:30]
  wire [15:0] _T_21 = ~_T_20; // @[ps_data.scala 49:30]
  wire [15:0] _T_22 = io_ps2_data ? _T_18 : _T_21; // @[ps_data.scala 49:30]
  wire [3:0] _T_24 = count + 4'h1; // @[ps_data.scala 50:22]
  wire [15:0] _GEN_42 = _T_3 ? 16'h0 : _T_22; // @[ps_data.scala 39:27]
  wire [15:0] _GEN_55 = sampling ? _GEN_42 : {{6'd0}, _GEN_11}; // @[ps_data.scala 38:19]
  assign io_data = fifo_0; // @[ps_data.scala 61:11]
  assign io_ready = ready; // @[ps_data.scala 62:12]
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
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
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  buffer = _RAND_0[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  fifo_0 = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  w_ptr = _RAND_2[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  count = _RAND_3[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  ps2_clk_sync_1 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  ps2_clk_sync_2 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      buffer <= 10'h0;
    end else begin
      buffer <= _GEN_55[9:0];
    end
    if (reset) begin
      fifo_0 <= 8'h0;
    end else if (sampling) begin
      if (_T_3) begin
        if (_T_9) begin
          if (3'h0 == w_ptr) begin
            fifo_0 <= buffer[8:1];
          end else if (io_fifo_clean) begin
            fifo_0 <= 8'h0;
          end
        end else if (io_fifo_clean) begin
          fifo_0 <= 8'h0;
        end
      end else if (io_fifo_clean) begin
        fifo_0 <= 8'h0;
      end
    end else if (io_fifo_clean) begin
      fifo_0 <= 8'h0;
    end
    if (reset) begin
      w_ptr <= 3'h0;
    end else if (sampling) begin
      if (_T_3) begin
        if (_T_9) begin
          w_ptr <= _T_12;
        end else if (io_fifo_clean) begin
          w_ptr <= 3'h0;
        end
      end else if (io_fifo_clean) begin
        w_ptr <= 3'h0;
      end
    end else if (io_fifo_clean) begin
      w_ptr <= 3'h0;
    end
    if (reset) begin
      count <= 4'h0;
    end else if (sampling) begin
      if (_T_3) begin
        count <= 4'h0;
      end else begin
        count <= _T_24;
      end
    end else if (io_fifo_clean) begin
      count <= 4'h0;
    end
    if (reset) begin
      ps2_clk_sync_1 <= 1'h0;
    end else begin
      ps2_clk_sync_1 <= ps2_clk_sync_2;
    end
    if (reset) begin
      ps2_clk_sync_2 <= 1'h0;
    end else begin
      ps2_clk_sync_2 <= io_ps2_clk;
    end
    if (reset) begin
      ready <= 1'h0;
    end else if (sampling) begin
      if (_T_3) begin
        ready <= _GEN_29;
      end
    end
  end
endmodule
module keyboard(
  input        clock,
  input        reset,
  input        io_ps2_clk,
  input        io_ps2_data,
  output [7:0] io_seg_0,
  output [7:0] io_seg_1,
  output [7:0] io_seg_2,
  output [7:0] io_seg_3,
  output [7:0] io_seg_4,
  output [7:0] io_seg_5,
  output [7:0] io_seg_6,
  output [7:0] io_seg_7
);
  wire  ps2Keyboard_clock; // @[ps_data.scala 73:27]
  wire  ps2Keyboard_reset; // @[ps_data.scala 73:27]
  wire  ps2Keyboard_io_ps2_clk; // @[ps_data.scala 73:27]
  wire  ps2Keyboard_io_ps2_data; // @[ps_data.scala 73:27]
  wire  ps2Keyboard_io_fifo_clean; // @[ps_data.scala 73:27]
  wire [7:0] ps2Keyboard_io_data; // @[ps_data.scala 73:27]
  wire  ps2Keyboard_io_ready; // @[ps_data.scala 73:27]
  reg [1:0] state; // @[ps_data.scala 84:22]
  reg [31:0] _RAND_0;
  reg [7:0] lastKeyCode; // @[ps_data.scala 85:28]
  reg [31:0] _RAND_1;
  reg [7:0] keyCount; // @[ps_data.scala 86:25]
  reg [31:0] _RAND_2;
  reg  newKeyPress; // @[ps_data.scala 87:28]
  reg [31:0] _RAND_3;
  reg  fifo_clean; // @[ps_data.scala 89:27]
  reg [31:0] _RAND_4;
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire [7:0] _T_3 = keyCount + 8'h1; // @[ps_data.scala 102:28]
  wire  _T_4 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_5 = ps2Keyboard_io_data == 8'hf0; // @[ps_data.scala 110:23]
  wire  _GEN_6 = _T_4 | newKeyPress; // @[Conditional.scala 39:67]
  wire  _GEN_12 = _T_1 | fifo_clean; // @[Conditional.scala 39:67]
  wire [3:0] _T_7 = newKeyPress ? lastKeyCode[3:0] : 4'h0; // @[ps_data.scala 183:16]
  wire [3:0] _T_9 = newKeyPress ? lastKeyCode[7:4] : 4'h0; // @[ps_data.scala 184:16]
  wire [7:0] _GEN_42 = 8'h15 == lastKeyCode ? 8'h51 : 8'h0; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_43 = 8'h16 == lastKeyCode ? 8'h31 : _GEN_42; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_44 = 8'h17 == lastKeyCode ? 8'h0 : _GEN_43; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_45 = 8'h18 == lastKeyCode ? 8'h0 : _GEN_44; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_46 = 8'h19 == lastKeyCode ? 8'h0 : _GEN_45; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_47 = 8'h1a == lastKeyCode ? 8'h5a : _GEN_46; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_48 = 8'h1b == lastKeyCode ? 8'h53 : _GEN_47; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_49 = 8'h1c == lastKeyCode ? 8'h41 : _GEN_48; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_50 = 8'h1d == lastKeyCode ? 8'h57 : _GEN_49; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_51 = 8'h1e == lastKeyCode ? 8'h32 : _GEN_50; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_52 = 8'h1f == lastKeyCode ? 8'h0 : _GEN_51; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_53 = 8'h20 == lastKeyCode ? 8'h0 : _GEN_52; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_54 = 8'h21 == lastKeyCode ? 8'h43 : _GEN_53; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_55 = 8'h22 == lastKeyCode ? 8'h58 : _GEN_54; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_56 = 8'h23 == lastKeyCode ? 8'h44 : _GEN_55; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_57 = 8'h24 == lastKeyCode ? 8'h45 : _GEN_56; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_58 = 8'h25 == lastKeyCode ? 8'h34 : _GEN_57; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_59 = 8'h26 == lastKeyCode ? 8'h33 : _GEN_58; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_60 = 8'h27 == lastKeyCode ? 8'h0 : _GEN_59; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_61 = 8'h28 == lastKeyCode ? 8'h0 : _GEN_60; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_62 = 8'h29 == lastKeyCode ? 8'h20 : _GEN_61; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_63 = 8'h2a == lastKeyCode ? 8'h56 : _GEN_62; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_64 = 8'h2b == lastKeyCode ? 8'h46 : _GEN_63; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_65 = 8'h2c == lastKeyCode ? 8'h54 : _GEN_64; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_66 = 8'h2d == lastKeyCode ? 8'h52 : _GEN_65; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_67 = 8'h2e == lastKeyCode ? 8'h35 : _GEN_66; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_68 = 8'h2f == lastKeyCode ? 8'h0 : _GEN_67; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_69 = 8'h30 == lastKeyCode ? 8'h0 : _GEN_68; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_70 = 8'h31 == lastKeyCode ? 8'h4e : _GEN_69; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_71 = 8'h32 == lastKeyCode ? 8'h42 : _GEN_70; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_72 = 8'h33 == lastKeyCode ? 8'h48 : _GEN_71; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_73 = 8'h34 == lastKeyCode ? 8'h47 : _GEN_72; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_74 = 8'h35 == lastKeyCode ? 8'h59 : _GEN_73; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_75 = 8'h36 == lastKeyCode ? 8'h36 : _GEN_74; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_76 = 8'h37 == lastKeyCode ? 8'h0 : _GEN_75; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_77 = 8'h38 == lastKeyCode ? 8'h0 : _GEN_76; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_78 = 8'h39 == lastKeyCode ? 8'h0 : _GEN_77; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_79 = 8'h3a == lastKeyCode ? 8'h4d : _GEN_78; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_80 = 8'h3b == lastKeyCode ? 8'h4a : _GEN_79; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_81 = 8'h3c == lastKeyCode ? 8'h55 : _GEN_80; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_82 = 8'h3d == lastKeyCode ? 8'h37 : _GEN_81; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_83 = 8'h3e == lastKeyCode ? 8'h38 : _GEN_82; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_84 = 8'h3f == lastKeyCode ? 8'h0 : _GEN_83; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_85 = 8'h40 == lastKeyCode ? 8'h0 : _GEN_84; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_86 = 8'h41 == lastKeyCode ? 8'h0 : _GEN_85; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_87 = 8'h42 == lastKeyCode ? 8'h4b : _GEN_86; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_88 = 8'h43 == lastKeyCode ? 8'h49 : _GEN_87; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_89 = 8'h44 == lastKeyCode ? 8'h4f : _GEN_88; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_90 = 8'h45 == lastKeyCode ? 8'h30 : _GEN_89; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_91 = 8'h46 == lastKeyCode ? 8'h39 : _GEN_90; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_92 = 8'h47 == lastKeyCode ? 8'h0 : _GEN_91; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_93 = 8'h48 == lastKeyCode ? 8'h0 : _GEN_92; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_94 = 8'h49 == lastKeyCode ? 8'h0 : _GEN_93; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_95 = 8'h4a == lastKeyCode ? 8'h0 : _GEN_94; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_96 = 8'h4b == lastKeyCode ? 8'h4c : _GEN_95; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_97 = 8'h4c == lastKeyCode ? 8'h0 : _GEN_96; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_98 = 8'h4d == lastKeyCode ? 8'h50 : _GEN_97; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_99 = 8'h4e == lastKeyCode ? 8'h0 : _GEN_98; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_100 = 8'h4f == lastKeyCode ? 8'h0 : _GEN_99; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_101 = 8'h50 == lastKeyCode ? 8'h0 : _GEN_100; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_102 = 8'h51 == lastKeyCode ? 8'h0 : _GEN_101; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_103 = 8'h52 == lastKeyCode ? 8'h0 : _GEN_102; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_104 = 8'h53 == lastKeyCode ? 8'h0 : _GEN_103; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_105 = 8'h54 == lastKeyCode ? 8'h0 : _GEN_104; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_106 = 8'h55 == lastKeyCode ? 8'h0 : _GEN_105; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_107 = 8'h56 == lastKeyCode ? 8'h0 : _GEN_106; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_108 = 8'h57 == lastKeyCode ? 8'h0 : _GEN_107; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_109 = 8'h58 == lastKeyCode ? 8'h0 : _GEN_108; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_110 = 8'h59 == lastKeyCode ? 8'h0 : _GEN_109; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_111 = 8'h5a == lastKeyCode ? 8'h0 : _GEN_110; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_112 = 8'h5b == lastKeyCode ? 8'h0 : _GEN_111; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_113 = 8'h5c == lastKeyCode ? 8'h0 : _GEN_112; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_114 = 8'h5d == lastKeyCode ? 8'h0 : _GEN_113; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_115 = 8'h5e == lastKeyCode ? 8'h0 : _GEN_114; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_116 = 8'h5f == lastKeyCode ? 8'h0 : _GEN_115; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_117 = 8'h60 == lastKeyCode ? 8'h0 : _GEN_116; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_118 = 8'h61 == lastKeyCode ? 8'h0 : _GEN_117; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_119 = 8'h62 == lastKeyCode ? 8'h0 : _GEN_118; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_120 = 8'h63 == lastKeyCode ? 8'h0 : _GEN_119; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_121 = 8'h64 == lastKeyCode ? 8'h0 : _GEN_120; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_122 = 8'h65 == lastKeyCode ? 8'h0 : _GEN_121; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_123 = 8'h66 == lastKeyCode ? 8'h0 : _GEN_122; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_124 = 8'h67 == lastKeyCode ? 8'h0 : _GEN_123; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_125 = 8'h68 == lastKeyCode ? 8'h0 : _GEN_124; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_126 = 8'h69 == lastKeyCode ? 8'h0 : _GEN_125; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_127 = 8'h6a == lastKeyCode ? 8'h0 : _GEN_126; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_128 = 8'h6b == lastKeyCode ? 8'h0 : _GEN_127; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_129 = 8'h6c == lastKeyCode ? 8'h0 : _GEN_128; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_130 = 8'h6d == lastKeyCode ? 8'h0 : _GEN_129; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_131 = 8'h6e == lastKeyCode ? 8'h0 : _GEN_130; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_132 = 8'h6f == lastKeyCode ? 8'h0 : _GEN_131; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_133 = 8'h70 == lastKeyCode ? 8'h0 : _GEN_132; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_134 = 8'h71 == lastKeyCode ? 8'h0 : _GEN_133; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_135 = 8'h72 == lastKeyCode ? 8'h0 : _GEN_134; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_136 = 8'h73 == lastKeyCode ? 8'h0 : _GEN_135; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_137 = 8'h74 == lastKeyCode ? 8'h0 : _GEN_136; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_138 = 8'h75 == lastKeyCode ? 8'h0 : _GEN_137; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_139 = 8'h76 == lastKeyCode ? 8'h0 : _GEN_138; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_140 = 8'h77 == lastKeyCode ? 8'h0 : _GEN_139; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_141 = 8'h78 == lastKeyCode ? 8'h0 : _GEN_140; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_142 = 8'h79 == lastKeyCode ? 8'h0 : _GEN_141; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_143 = 8'h7a == lastKeyCode ? 8'h0 : _GEN_142; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_144 = 8'h7b == lastKeyCode ? 8'h0 : _GEN_143; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_145 = 8'h7c == lastKeyCode ? 8'h0 : _GEN_144; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_146 = 8'h7d == lastKeyCode ? 8'h0 : _GEN_145; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_147 = 8'h7e == lastKeyCode ? 8'h0 : _GEN_146; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_148 = 8'h7f == lastKeyCode ? 8'h0 : _GEN_147; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_149 = 8'h80 == lastKeyCode ? 8'h0 : _GEN_148; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_150 = 8'h81 == lastKeyCode ? 8'h0 : _GEN_149; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_151 = 8'h82 == lastKeyCode ? 8'h0 : _GEN_150; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_152 = 8'h83 == lastKeyCode ? 8'h0 : _GEN_151; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_153 = 8'h84 == lastKeyCode ? 8'h0 : _GEN_152; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_154 = 8'h85 == lastKeyCode ? 8'h0 : _GEN_153; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_155 = 8'h86 == lastKeyCode ? 8'h0 : _GEN_154; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_156 = 8'h87 == lastKeyCode ? 8'h0 : _GEN_155; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_157 = 8'h88 == lastKeyCode ? 8'h0 : _GEN_156; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_158 = 8'h89 == lastKeyCode ? 8'h0 : _GEN_157; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_159 = 8'h8a == lastKeyCode ? 8'h0 : _GEN_158; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_160 = 8'h8b == lastKeyCode ? 8'h0 : _GEN_159; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_161 = 8'h8c == lastKeyCode ? 8'h0 : _GEN_160; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_162 = 8'h8d == lastKeyCode ? 8'h0 : _GEN_161; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_163 = 8'h8e == lastKeyCode ? 8'h0 : _GEN_162; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_164 = 8'h8f == lastKeyCode ? 8'h0 : _GEN_163; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_165 = 8'h90 == lastKeyCode ? 8'h0 : _GEN_164; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_166 = 8'h91 == lastKeyCode ? 8'h0 : _GEN_165; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_167 = 8'h92 == lastKeyCode ? 8'h0 : _GEN_166; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_168 = 8'h93 == lastKeyCode ? 8'h0 : _GEN_167; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_169 = 8'h94 == lastKeyCode ? 8'h0 : _GEN_168; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_170 = 8'h95 == lastKeyCode ? 8'h0 : _GEN_169; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_171 = 8'h96 == lastKeyCode ? 8'h0 : _GEN_170; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_172 = 8'h97 == lastKeyCode ? 8'h0 : _GEN_171; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_173 = 8'h98 == lastKeyCode ? 8'h0 : _GEN_172; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_174 = 8'h99 == lastKeyCode ? 8'h0 : _GEN_173; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_175 = 8'h9a == lastKeyCode ? 8'h0 : _GEN_174; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_176 = 8'h9b == lastKeyCode ? 8'h0 : _GEN_175; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_177 = 8'h9c == lastKeyCode ? 8'h0 : _GEN_176; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_178 = 8'h9d == lastKeyCode ? 8'h0 : _GEN_177; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_179 = 8'h9e == lastKeyCode ? 8'h0 : _GEN_178; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_180 = 8'h9f == lastKeyCode ? 8'h0 : _GEN_179; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_181 = 8'ha0 == lastKeyCode ? 8'h0 : _GEN_180; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_182 = 8'ha1 == lastKeyCode ? 8'h0 : _GEN_181; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_183 = 8'ha2 == lastKeyCode ? 8'h0 : _GEN_182; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_184 = 8'ha3 == lastKeyCode ? 8'h0 : _GEN_183; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_185 = 8'ha4 == lastKeyCode ? 8'h0 : _GEN_184; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_186 = 8'ha5 == lastKeyCode ? 8'h0 : _GEN_185; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_187 = 8'ha6 == lastKeyCode ? 8'h0 : _GEN_186; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_188 = 8'ha7 == lastKeyCode ? 8'h0 : _GEN_187; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_189 = 8'ha8 == lastKeyCode ? 8'h0 : _GEN_188; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_190 = 8'ha9 == lastKeyCode ? 8'h0 : _GEN_189; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_191 = 8'haa == lastKeyCode ? 8'h0 : _GEN_190; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_192 = 8'hab == lastKeyCode ? 8'h0 : _GEN_191; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_193 = 8'hac == lastKeyCode ? 8'h0 : _GEN_192; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_194 = 8'had == lastKeyCode ? 8'h0 : _GEN_193; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_195 = 8'hae == lastKeyCode ? 8'h0 : _GEN_194; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_196 = 8'haf == lastKeyCode ? 8'h0 : _GEN_195; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_197 = 8'hb0 == lastKeyCode ? 8'h0 : _GEN_196; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_198 = 8'hb1 == lastKeyCode ? 8'h0 : _GEN_197; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_199 = 8'hb2 == lastKeyCode ? 8'h0 : _GEN_198; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_200 = 8'hb3 == lastKeyCode ? 8'h0 : _GEN_199; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_201 = 8'hb4 == lastKeyCode ? 8'h0 : _GEN_200; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_202 = 8'hb5 == lastKeyCode ? 8'h0 : _GEN_201; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_203 = 8'hb6 == lastKeyCode ? 8'h0 : _GEN_202; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_204 = 8'hb7 == lastKeyCode ? 8'h0 : _GEN_203; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_205 = 8'hb8 == lastKeyCode ? 8'h0 : _GEN_204; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_206 = 8'hb9 == lastKeyCode ? 8'h0 : _GEN_205; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_207 = 8'hba == lastKeyCode ? 8'h0 : _GEN_206; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_208 = 8'hbb == lastKeyCode ? 8'h0 : _GEN_207; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_209 = 8'hbc == lastKeyCode ? 8'h0 : _GEN_208; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_210 = 8'hbd == lastKeyCode ? 8'h0 : _GEN_209; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_211 = 8'hbe == lastKeyCode ? 8'h0 : _GEN_210; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_212 = 8'hbf == lastKeyCode ? 8'h0 : _GEN_211; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_213 = 8'hc0 == lastKeyCode ? 8'h0 : _GEN_212; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_214 = 8'hc1 == lastKeyCode ? 8'h0 : _GEN_213; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_215 = 8'hc2 == lastKeyCode ? 8'h0 : _GEN_214; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_216 = 8'hc3 == lastKeyCode ? 8'h0 : _GEN_215; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_217 = 8'hc4 == lastKeyCode ? 8'h0 : _GEN_216; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_218 = 8'hc5 == lastKeyCode ? 8'h0 : _GEN_217; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_219 = 8'hc6 == lastKeyCode ? 8'h0 : _GEN_218; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_220 = 8'hc7 == lastKeyCode ? 8'h0 : _GEN_219; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_221 = 8'hc8 == lastKeyCode ? 8'h0 : _GEN_220; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_222 = 8'hc9 == lastKeyCode ? 8'h0 : _GEN_221; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_223 = 8'hca == lastKeyCode ? 8'h0 : _GEN_222; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_224 = 8'hcb == lastKeyCode ? 8'h0 : _GEN_223; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_225 = 8'hcc == lastKeyCode ? 8'h0 : _GEN_224; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_226 = 8'hcd == lastKeyCode ? 8'h0 : _GEN_225; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_227 = 8'hce == lastKeyCode ? 8'h0 : _GEN_226; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_228 = 8'hcf == lastKeyCode ? 8'h0 : _GEN_227; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_229 = 8'hd0 == lastKeyCode ? 8'h0 : _GEN_228; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_230 = 8'hd1 == lastKeyCode ? 8'h0 : _GEN_229; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_231 = 8'hd2 == lastKeyCode ? 8'h0 : _GEN_230; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_232 = 8'hd3 == lastKeyCode ? 8'h0 : _GEN_231; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_233 = 8'hd4 == lastKeyCode ? 8'h0 : _GEN_232; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_234 = 8'hd5 == lastKeyCode ? 8'h0 : _GEN_233; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_235 = 8'hd6 == lastKeyCode ? 8'h0 : _GEN_234; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_236 = 8'hd7 == lastKeyCode ? 8'h0 : _GEN_235; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_237 = 8'hd8 == lastKeyCode ? 8'h0 : _GEN_236; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_238 = 8'hd9 == lastKeyCode ? 8'h0 : _GEN_237; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_239 = 8'hda == lastKeyCode ? 8'h0 : _GEN_238; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_240 = 8'hdb == lastKeyCode ? 8'h0 : _GEN_239; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_241 = 8'hdc == lastKeyCode ? 8'h0 : _GEN_240; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_242 = 8'hdd == lastKeyCode ? 8'h0 : _GEN_241; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_243 = 8'hde == lastKeyCode ? 8'h0 : _GEN_242; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_244 = 8'hdf == lastKeyCode ? 8'h0 : _GEN_243; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_245 = 8'he0 == lastKeyCode ? 8'h0 : _GEN_244; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_246 = 8'he1 == lastKeyCode ? 8'h0 : _GEN_245; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_247 = 8'he2 == lastKeyCode ? 8'h0 : _GEN_246; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_248 = 8'he3 == lastKeyCode ? 8'h0 : _GEN_247; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_249 = 8'he4 == lastKeyCode ? 8'h0 : _GEN_248; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_250 = 8'he5 == lastKeyCode ? 8'h0 : _GEN_249; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_251 = 8'he6 == lastKeyCode ? 8'h0 : _GEN_250; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_252 = 8'he7 == lastKeyCode ? 8'h0 : _GEN_251; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_253 = 8'he8 == lastKeyCode ? 8'h0 : _GEN_252; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_254 = 8'he9 == lastKeyCode ? 8'h0 : _GEN_253; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_255 = 8'hea == lastKeyCode ? 8'h0 : _GEN_254; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_256 = 8'heb == lastKeyCode ? 8'h0 : _GEN_255; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_257 = 8'hec == lastKeyCode ? 8'h0 : _GEN_256; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_258 = 8'hed == lastKeyCode ? 8'h0 : _GEN_257; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_259 = 8'hee == lastKeyCode ? 8'h0 : _GEN_258; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_260 = 8'hef == lastKeyCode ? 8'h0 : _GEN_259; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_261 = 8'hf0 == lastKeyCode ? 8'h0 : _GEN_260; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_262 = 8'hf1 == lastKeyCode ? 8'h0 : _GEN_261; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_263 = 8'hf2 == lastKeyCode ? 8'h0 : _GEN_262; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_264 = 8'hf3 == lastKeyCode ? 8'h0 : _GEN_263; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_265 = 8'hf4 == lastKeyCode ? 8'h0 : _GEN_264; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_266 = 8'hf5 == lastKeyCode ? 8'h0 : _GEN_265; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_267 = 8'hf6 == lastKeyCode ? 8'h0 : _GEN_266; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_268 = 8'hf7 == lastKeyCode ? 8'h0 : _GEN_267; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_269 = 8'hf8 == lastKeyCode ? 8'h0 : _GEN_268; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_270 = 8'hf9 == lastKeyCode ? 8'h0 : _GEN_269; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_271 = 8'hfa == lastKeyCode ? 8'h0 : _GEN_270; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_272 = 8'hfb == lastKeyCode ? 8'h0 : _GEN_271; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_273 = 8'hfc == lastKeyCode ? 8'h0 : _GEN_272; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_274 = 8'hfd == lastKeyCode ? 8'h0 : _GEN_273; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_275 = 8'hfe == lastKeyCode ? 8'h0 : _GEN_274; // @[ps_data.scala 185:39]
  wire [7:0] _GEN_276 = 8'hff == lastKeyCode ? 8'h0 : _GEN_275; // @[ps_data.scala 185:39]
  wire [3:0] _T_11 = newKeyPress ? _GEN_276[3:0] : 4'h0; // @[ps_data.scala 185:16]
  wire [3:0] _T_13 = newKeyPress ? _GEN_276[7:4] : 4'h0; // @[ps_data.scala 186:16]
  wire [7:0] _GEN_0 = keyCount % 8'ha; // @[ps_data.scala 187:22]
  wire [3:0] _T_14 = _GEN_0[3:0]; // @[ps_data.scala 187:22]
  wire [7:0] _T_16 = keyCount / 8'ha; // @[ps_data.scala 188:23]
  wire [7:0] _GEN_1 = _T_16 % 8'ha; // @[ps_data.scala 188:31]
  wire [3:0] _T_17 = _GEN_1[3:0]; // @[ps_data.scala 188:31]
  wire [7:0] _GEN_278 = 4'h1 == _T_7 ? 8'h9f : 8'h3; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_279 = 4'h2 == _T_7 ? 8'h25 : _GEN_278; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_280 = 4'h3 == _T_7 ? 8'hd : _GEN_279; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_281 = 4'h4 == _T_7 ? 8'h99 : _GEN_280; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_282 = 4'h5 == _T_7 ? 8'h49 : _GEN_281; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_283 = 4'h6 == _T_7 ? 8'h41 : _GEN_282; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_284 = 4'h7 == _T_7 ? 8'h1f : _GEN_283; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_285 = 4'h8 == _T_7 ? 8'h1 : _GEN_284; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_286 = 4'h9 == _T_7 ? 8'h9 : _GEN_285; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_287 = 4'ha == _T_7 ? 8'h11 : _GEN_286; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_288 = 4'hb == _T_7 ? 8'hc1 : _GEN_287; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_289 = 4'hc == _T_7 ? 8'h63 : _GEN_288; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_290 = 4'hd == _T_7 ? 8'h85 : _GEN_289; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_291 = 4'he == _T_7 ? 8'h61 : _GEN_290; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_294 = 4'h1 == _T_9 ? 8'h9f : 8'h3; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_295 = 4'h2 == _T_9 ? 8'h25 : _GEN_294; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_296 = 4'h3 == _T_9 ? 8'hd : _GEN_295; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_297 = 4'h4 == _T_9 ? 8'h99 : _GEN_296; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_298 = 4'h5 == _T_9 ? 8'h49 : _GEN_297; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_299 = 4'h6 == _T_9 ? 8'h41 : _GEN_298; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_300 = 4'h7 == _T_9 ? 8'h1f : _GEN_299; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_301 = 4'h8 == _T_9 ? 8'h1 : _GEN_300; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_302 = 4'h9 == _T_9 ? 8'h9 : _GEN_301; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_303 = 4'ha == _T_9 ? 8'h11 : _GEN_302; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_304 = 4'hb == _T_9 ? 8'hc1 : _GEN_303; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_305 = 4'hc == _T_9 ? 8'h63 : _GEN_304; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_306 = 4'hd == _T_9 ? 8'h85 : _GEN_305; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_307 = 4'he == _T_9 ? 8'h61 : _GEN_306; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_310 = 4'h1 == _T_11 ? 8'h9f : 8'h3; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_311 = 4'h2 == _T_11 ? 8'h25 : _GEN_310; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_312 = 4'h3 == _T_11 ? 8'hd : _GEN_311; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_313 = 4'h4 == _T_11 ? 8'h99 : _GEN_312; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_314 = 4'h5 == _T_11 ? 8'h49 : _GEN_313; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_315 = 4'h6 == _T_11 ? 8'h41 : _GEN_314; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_316 = 4'h7 == _T_11 ? 8'h1f : _GEN_315; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_317 = 4'h8 == _T_11 ? 8'h1 : _GEN_316; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_318 = 4'h9 == _T_11 ? 8'h9 : _GEN_317; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_319 = 4'ha == _T_11 ? 8'h11 : _GEN_318; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_320 = 4'hb == _T_11 ? 8'hc1 : _GEN_319; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_321 = 4'hc == _T_11 ? 8'h63 : _GEN_320; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_322 = 4'hd == _T_11 ? 8'h85 : _GEN_321; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_323 = 4'he == _T_11 ? 8'h61 : _GEN_322; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_326 = 4'h1 == _T_13 ? 8'h9f : 8'h3; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_327 = 4'h2 == _T_13 ? 8'h25 : _GEN_326; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_328 = 4'h3 == _T_13 ? 8'hd : _GEN_327; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_329 = 4'h4 == _T_13 ? 8'h99 : _GEN_328; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_330 = 4'h5 == _T_13 ? 8'h49 : _GEN_329; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_331 = 4'h6 == _T_13 ? 8'h41 : _GEN_330; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_332 = 4'h7 == _T_13 ? 8'h1f : _GEN_331; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_333 = 4'h8 == _T_13 ? 8'h1 : _GEN_332; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_334 = 4'h9 == _T_13 ? 8'h9 : _GEN_333; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_335 = 4'ha == _T_13 ? 8'h11 : _GEN_334; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_336 = 4'hb == _T_13 ? 8'hc1 : _GEN_335; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_337 = 4'hc == _T_13 ? 8'h63 : _GEN_336; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_338 = 4'hd == _T_13 ? 8'h85 : _GEN_337; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_339 = 4'he == _T_13 ? 8'h61 : _GEN_338; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_342 = 4'h1 == _T_14 ? 8'h9f : 8'h3; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_343 = 4'h2 == _T_14 ? 8'h25 : _GEN_342; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_344 = 4'h3 == _T_14 ? 8'hd : _GEN_343; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_345 = 4'h4 == _T_14 ? 8'h99 : _GEN_344; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_346 = 4'h5 == _T_14 ? 8'h49 : _GEN_345; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_347 = 4'h6 == _T_14 ? 8'h41 : _GEN_346; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_348 = 4'h7 == _T_14 ? 8'h1f : _GEN_347; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_349 = 4'h8 == _T_14 ? 8'h1 : _GEN_348; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_350 = 4'h9 == _T_14 ? 8'h9 : _GEN_349; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_351 = 4'ha == _T_14 ? 8'h11 : _GEN_350; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_352 = 4'hb == _T_14 ? 8'hc1 : _GEN_351; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_353 = 4'hc == _T_14 ? 8'h63 : _GEN_352; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_354 = 4'hd == _T_14 ? 8'h85 : _GEN_353; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_355 = 4'he == _T_14 ? 8'h61 : _GEN_354; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_358 = 4'h1 == _T_17 ? 8'h9f : 8'h3; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_359 = 4'h2 == _T_17 ? 8'h25 : _GEN_358; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_360 = 4'h3 == _T_17 ? 8'hd : _GEN_359; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_361 = 4'h4 == _T_17 ? 8'h99 : _GEN_360; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_362 = 4'h5 == _T_17 ? 8'h49 : _GEN_361; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_363 = 4'h6 == _T_17 ? 8'h41 : _GEN_362; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_364 = 4'h7 == _T_17 ? 8'h1f : _GEN_363; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_365 = 4'h8 == _T_17 ? 8'h1 : _GEN_364; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_366 = 4'h9 == _T_17 ? 8'h9 : _GEN_365; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_367 = 4'ha == _T_17 ? 8'h11 : _GEN_366; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_368 = 4'hb == _T_17 ? 8'hc1 : _GEN_367; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_369 = 4'hc == _T_17 ? 8'h63 : _GEN_368; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_370 = 4'hd == _T_17 ? 8'h85 : _GEN_369; // @[ps_data.scala 182:20]
  wire [7:0] _GEN_371 = 4'he == _T_17 ? 8'h61 : _GEN_370; // @[ps_data.scala 182:20]
  PS2Keyboard ps2Keyboard ( // @[ps_data.scala 73:27]
    .clock(ps2Keyboard_clock),
    .reset(ps2Keyboard_reset),
    .io_ps2_clk(ps2Keyboard_io_ps2_clk),
    .io_ps2_data(ps2Keyboard_io_ps2_data),
    .io_fifo_clean(ps2Keyboard_io_fifo_clean),
    .io_data(ps2Keyboard_io_data),
    .io_ready(ps2Keyboard_io_ready)
  );
  assign io_seg_0 = 4'hf == _T_7 ? 8'h71 : _GEN_291; // @[ps_data.scala 182:10]
  assign io_seg_1 = 4'hf == _T_9 ? 8'h71 : _GEN_307; // @[ps_data.scala 182:10]
  assign io_seg_2 = 4'hf == _T_11 ? 8'h71 : _GEN_323; // @[ps_data.scala 182:10]
  assign io_seg_3 = 4'hf == _T_13 ? 8'h71 : _GEN_339; // @[ps_data.scala 182:10]
  assign io_seg_4 = 4'hf == _T_14 ? 8'h71 : _GEN_355; // @[ps_data.scala 182:10]
  assign io_seg_5 = 4'hf == _T_17 ? 8'h71 : _GEN_371; // @[ps_data.scala 182:10]
  assign io_seg_6 = 8'h0; // @[ps_data.scala 182:10]
  assign io_seg_7 = 8'h0; // @[ps_data.scala 182:10]
  assign ps2Keyboard_clock = clock;
  assign ps2Keyboard_reset = reset;
  assign ps2Keyboard_io_ps2_clk = io_ps2_clk; // @[ps_data.scala 75:26]
  assign ps2Keyboard_io_ps2_data = io_ps2_data; // @[ps_data.scala 76:27]
  assign ps2Keyboard_io_fifo_clean = fifo_clean; // @[ps_data.scala 194:29]
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
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
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  lastKeyCode = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  keyCount = _RAND_2[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  newKeyPress = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  fifo_clean = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else if (_T) begin
      if (ps2Keyboard_io_ready) begin
        state <= 2'h2;
      end
    end else if (_T_1) begin
      state <= 2'h0;
    end else if (_T_4) begin
      if (ps2Keyboard_io_ready) begin
        if (_T_5) begin
          state <= 2'h1;
        end else begin
          state <= 2'h0;
        end
      end
    end
    if (reset) begin
      lastKeyCode <= 8'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (_T_4) begin
          if (ps2Keyboard_io_ready) begin
            if (!(_T_5)) begin
              lastKeyCode <= ps2Keyboard_io_data;
            end
          end
        end
      end
    end
    if (reset) begin
      keyCount <= 8'h0;
    end else if (!(_T)) begin
      if (_T_1) begin
        keyCount <= _T_3;
      end
    end
    if (reset) begin
      newKeyPress <= 1'h0;
    end else if (_T) begin
      newKeyPress <= 1'h0;
    end else if (_T_1) begin
      newKeyPress <= 1'h0;
    end else begin
      newKeyPress <= _GEN_6;
    end
    if (reset) begin
      fifo_clean <= 1'h0;
    end else if (_T) begin
      fifo_clean <= 1'h0;
    end else begin
      fifo_clean <= _GEN_12;
    end
  end
endmodule
