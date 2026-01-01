module RAM128x32 
#(
  parameter Data_width = 32,  //# of bits in word
            Addr_width = 7  // # of address bits
  )
  (  //ports
    input wire clk,
    input wire we,
    input wire [(Addr_width-1):0] address, 
    input wire [(Data_width-1):0] d,
    output wire [(Data_width-1):0] q
  );

  reg [(Data_width-1):0] RAM[(2**Addr_width)-1:0]; //declare RAM
  reg [(Data_width-1):0] out_reg;

  assign q = out_reg; //output register

  always @(posedge clk) begin
    if (we) begin
      RAM[address] <= d; //write data to RAM
      out_reg <= {Data_width{1'bz}}; // write high impedance on output during write
    end
    else begin
      out_reg <= RAM[address]; //read data from RAM
    end
  end

endmodule