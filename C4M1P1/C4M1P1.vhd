library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity C4M1P1 is
   port(
      SW: in std_logic_vector(9 downto 0);
      HEX0, HEX1: out std_logic_vector(7 downto 0)
    );
end entity C4M1P1;

architecture RTL of C4M1P1 is

   -- Function to convert 4-bit input to 7-segment display pattern
   function hex_to_7seg(hex_val : std_logic_vector(3 downto 0)) return std_logic_vector is
      variable seg : std_logic_vector(6 downto 0);
   begin
      case hex_val is
         when "0000" => seg := "1000000"; -- 0
         when "0001" => seg := "1111001"; -- 1
         when "0010" => seg := "0100100"; -- 2
         when "0011" => seg := "0110000"; -- 3
         when "0100" => seg := "0011001"; -- 4
         when "0101" => seg := "0010010"; -- 5
         when "0110" => seg := "0000010"; -- 6
         when "0111" => seg := "1111000"; -- 7
         when "1000" => seg := "0000000"; -- 8
         when "1001" => seg := "0011000"; -- 9
         when others => seg := "-------"; -- don't care for values 10-15
      end case;
      return seg;
   end function;

begin

   -- HEX0 displays SW(3 downto 0)
   -- Bit 7 is decimal point (active low, so set to '1' to turn off)
   HEX0 <= '1' & hex_to_7seg(SW(3 downto 0));
   
   -- HEX1 displays SW(7 downto 4)
   HEX1 <= '1' & hex_to_7seg(SW(7 downto 4));

end architecture RTL;