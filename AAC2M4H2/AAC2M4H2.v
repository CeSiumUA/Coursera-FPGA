module FIFO8x9(
  input clk, rst,
  input RdPtrClr, WrPtrClr, 
  input RdInc, WrInc,
  input [8:0] DataIn,
  output reg [8:0] DataOut,
  input rden, wren
	);
//signal declarations

	reg [8:0] fifo_array[7:0];
	reg [7:0] wrptr, rdptr;
	wire [7:0] wr_cnt, rd_cnt;

  wire [6:0] combined_signals;

  assign combined_signals = {rst, RdPtrClr, WrPtrClr, RdInc, WrInc, rden, wren};
  assign wr_cnt = wrptr;
  assign rd_cnt = rdptr;

  always @(posedge clk) begin
    case (combined_signals)
      7'b0XXXXXX: begin // reset
        DataOut <= 9'bZZZZZZZZZ;
        fifo_array[0] <= 0;
        fifo_array[1] <= 0;
        fifo_array[2] <= 0;
        fifo_array[3] <= 0;
        fifo_array[4] <= 0;
        fifo_array[5] <= 0;
        fifo_array[6] <= 0;
        fifo_array[7] <= 0;

        wrptr <= 0;
        rdptr <= 0;
      end

      7'b11XXXXX: begin
        DataOut <= 9'bZZZZZZZZZ;
        rdptr <= 0;
      end

      7'b1X1XXXX: begin
        DataOut <= 9'bZZZZZZZZZ;
        wrptr <= 0;
      end

      7'b1XX1XXX: begin
        DataOut <= 9'bZZZZZZZZZ;
        rdptr <= rdptr + 1;
      end

      7'b1XXX1XX: begin
        DataOut <= 9'bZZZZZZZZZ;
        wrptr <= wrptr + 1;
      end

      7'b1XXXX1X: begin
        DataOut <= fifo_array[rdptr];
      end

      7'b1XXXXX1: begin
        fifo_array[wrptr] <= DataIn;
      end
      default: begin
        DataOut <= 9'bZZZZZZZZZ;
      end
    endcase
  end

endmodule
