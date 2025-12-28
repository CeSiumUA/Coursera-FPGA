library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (
   In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture Behavioral of FSM is
   type state_type is (A, B, C);
   signal state : state_type := A;
begin
   state_proc: process (CLK, RST)
   begin
      if RST = '1' then
         state <= A;

      elsif rising_edge(CLK) then
         case state is
            when A =>
               if In1 = '1' then
                  state <= B;
               end if;
            when B =>
               if In1 = '0' then
                  state <= C;
               end if;
            when C =>
               if In1 = '1' then
                  state <= A;
               end if;
         end case;
      end if;
   end process state_proc;

   out_proc: process (state)
   begin
      case state is
         when C =>
            Out1 <= '1';
         when others =>
            Out1 <= '0';
      end case;
   end process out_proc;

end Behavioral;