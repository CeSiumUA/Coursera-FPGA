library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity C4M1P4 is
   port(
      X : in std_logic_vector(3 downto 0);
      Y : in std_logic_vector(3 downto 0);
      Cin : in std_logic;
      S : out std_logic_vector(3 downto 0);
      Cout : out std_logic;
      HEX_X, HEX_Y, HEX_S0, HEX_S1 : out std_logic_vector(7 downto 0);
      ERR : out std_logic
   );
end entity C4M1P4;

architecture RTL of C4M1P4 is
   -- Internal carry signals
   signal C : std_logic_vector(4 downto 0);
   signal Sum : std_logic_vector(3 downto 0);
   signal d0, d1 : std_logic_vector(3 downto 0);
   signal z : std_logic;
   signal full_sum : std_logic_vector(4 downto 0);

   -- Function to convert 4-bit input to 7-segment display pattern
   function hex_to_7seg(hex_val : std_logic_vector(3 downto 0)) return std_logic_vector is
      variable seg : std_logic_vector(7 downto 0);
   begin
      case hex_val is
         when "0000" => seg := "11000000"; -- 0
         when "0001" => seg := "11111001"; -- 1
         when "0010" => seg := "10100100"; -- 2
         when "0011" => seg := "10110000"; -- 3
         when "0100" => seg := "10011001"; -- 4
         when "0101" => seg := "10010010"; -- 5
         when "0110" => seg := "10000010"; -- 6
         when "0111" => seg := "11111000"; -- 7
         when "1000" => seg := "10000000"; -- 8
         when "1001" => seg := "10011000"; -- 9
         when others => seg := "0-------"; -- don't care for values 10-15
      end case;
      return seg;
   end function;
begin
   -- Connect input carry
   C(0) <= Cin;
   
   gen_adder: for i in 0 to 3 generate
      Sum(i) <= X(i) xor Y(i) xor C(i);
      C(i+1) <= (X(i) and Y(i)) or (C(i) and (X(i) xor Y(i)));
   end generate gen_adder;
   
   -- Connect output carry
   Cout <= C(4);

   full_sum <= C(4) & Sum;

   S <= Sum;

   z <= '1' when full_sum > "01001" else '0';

   d0 <= std_logic_vector(unsigned(full_sum) - 10)(3 downto 0) when z = '1' else full_sum(3 downto 0);
   d1 <= "0000" when z = '0' else "0001";

   ERR <= '1' when (X > "1001" or Y > "1001") else '0';

   HEX_X <= hex_to_7seg(X);
   HEX_Y <= hex_to_7seg(Y);
   HEX_S0 <= hex_to_7seg(d0);
   HEX_S1 <= hex_to_7seg(d1);
   
end architecture RTL;