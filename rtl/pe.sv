// This module implements a Processing Element (PE). It performs an 8-bit
// multiply-accumulate operation.

`default_nettype none

module pe
  ( input  var logic        i_clk
  , input  var logic        i_arst

  , input  var logic        i_doProcess
  , input  var logic        i_mode
  , input  var logic [15:0]  i_a
  , input  var logic [15:0]  i_b

  , output var logic [15:0]  o_a
  , output var logic [15:0]  o_b
  , output var logic [31:0] o_y_real
  , output var logic [31:0] o_y_imag
  );

  //split inputs to real and imaginary

  logic [7:0] a_real, a_imag, b_real, b_imag;
  assign a_real = i_a[15:8];
  assign a_imag = i_mode ? i_a[7:0] : 8'b0;
  assign b_real = i_b[15:8];
  assign b_imag = i_mode ? i_b[7:0] : 8'b0;
 
  // {{{ MAC

  logic [31:0] mult_ar_br, mult_ar_bi, mult_ai_br, mult_ai_bi, product_real, product_imag;

  
  assign  mult_ar_br = a_real*b_real;
  assign  mult_ar_bi = a_real*b_imag;
  assign  mult_ai_br = a_imag*b_real;
  assign  mult_ai_bi = a_imag*b_imag;
  assign  product_real = i_mode ? mult_ar_br - mult_ai_bi : mult_ar_br;
  assign  product_imag = i_mode ? mult_ai_br + mult_ar_bi : 32'b0;
 
       
  logic [31:0] mac_d_real, mac_d_imag, mac_q_real, mac_q_imag;

  always_ff @(posedge i_clk, posedge i_arst) begin
    if (i_arst) begin
      mac_q_real <= 32'b0;
      mac_q_imag <= 32'b0;
    end else begin
      mac_q_real <= mac_d_real;
      mac_q_imag <= mac_d_imag;
    end
  end
  assign  mac_d_real = (i_doProcess) ? mac_q_real + product_real : '0;
  assign  mac_d_imag = (i_doProcess) ? mac_q_imag + product_imag : '0;

  assign  o_y_real = mac_q_real;
  assign  o_y_imag = mac_q_imag;  

  // }}} MAC

  // {{{ Register inputs and assign them to outputs

  logic [15:0] a_q, b_q;

  always_ff @(posedge i_clk, posedge i_arst) begin
    if (i_arst) begin
      a_q <= 16'b0;
      b_q <= 16'b0;
    end else if (i_doProcess) begin
      a_q <= i_a;
      b_q <= i_b;
    end else begin
      a_q <= a_q;
      b_q <= b_q;
    end
  end
  assign  o_a = a_q;
  assign  o_b = b_q;

  // }}} Register inputs and assign them to outputs

endmodule

`resetall
