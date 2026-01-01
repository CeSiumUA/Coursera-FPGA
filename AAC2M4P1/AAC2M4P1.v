module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output reg [3:0]Q,        // Parallel Output 	
    output reg RCO            // Ripple Carry Output (Terminal Count)
); 

wire [3:0] combined = {CLR_n, LOAD_n, ENT, ENP};

always @(posedge(CLK), negedge(CLR_n)) begin
    case (combined)
        4'b0xxx: begin
            Q <= 4'b0000;          // Asynchronous Reset
        end
        4'b10xx: begin
            Q <= D;                // Load Parallel Input
        end
        4'b1111: begin
            Q <= Q + 1;            // Count Up
        end
        default: begin
            Q <= Q;                // Hold State
        end
    endcase
    RCO <= ENT && (&Q);
end

endmodule
