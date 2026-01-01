module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

  parameter OC_OUT_A = 3'b000,
            OC_ADD = 3'b001,
            OC_SUB = 3'b010,
            OC_AND = 3'b011,
            OC_OR  = 3'b100,
            OC_INC_A = 3'b101,
            OC_DEC_A = 3'b110,
            OC_OUT_B = 3'b111;

always @(*) begin
  case (Op_code)
    OC_OUT_A: Y = A;
    OC_ADD:   Y = A + B;
    OC_SUB:   Y = A - B;
    OC_AND:   Y = A & B;
    OC_OR:    Y = A | B;
    OC_INC_A: Y = A + 1;
    OC_DEC_A: Y = A - 1;
    OC_OUT_B: Y = B;
    default:  Y = 32'b0;
  endcase
end

endmodule
