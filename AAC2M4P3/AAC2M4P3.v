module FSM(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);

  reg [1:0] state, next_state;

  parameter A = 2'b00,
            B = 2'b01,
            C = 2'b10;

  always @(posedge CLK, negedge RST) begin
    if (RST == 0)
      state <= A;
    else
      state <= next_state;
  end

  always @(state, In1) begin
    case (state)
      A: begin
        if (In1)
          next_state = B;
        else
          next_state = state;
      end
      B: begin
        if (In1 == 0)
          next_state = C;
        else
          next_state = state;
      end
      C: begin
        if (In1)
          next_state = A;
        else
          next_state = state;
      end
      default: next_state = A;
    endcase
  end

  always @(state) begin
    case (state)
      A: Out1 = 0;
      B: Out1 = 0;
      C: Out1 = 1;
      default: Out1 = 0;
    endcase
  end
endmodule
