library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity C4M1P5 is
   port(
      A : in std_logic_vector(3 downto 0);
      B : in std_logic_vector(3 downto 0);
      Cin : in std_logic;
      S : out std_logic_vector(3 downto 0);
      Cout : out std_logic;
      HEX_A, HEX_B, HEX_S0, HEX_S1 : out std_logic_vector(7 downto 0);
      ERR : out std_logic
   );
end entity C4M1P5;

architecture RTL of C4M1P5 is
   -- Internal carry signals
   signal C : std_logic_vector(4 downto 0);
   signal Sum : std_logic_vector(3 downto 0);
   signal T0 : unsigned(4 downto 0);
   signal Z0 : unsigned(4 downto 0);
   signal c1 : std_logic;
   signal S0 : std_logic_vector(3 downto 0);
   signal S1 : std_logic;

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

   T0 <= ('0' & unsigned(A)) + ('0' & unsigned(B)) + ("0000" & Cin);

   process(T0)
   begin
      if T0 > 9 then
         Z0 <= "01010";
         c1 <= '1';
      else
         Z0 <= "00000";
         c1 <= '0';
      end if;
   end process;

   S0 <= std_logic_vector(T0 - Z0)(3 downto 0);
   S1 <= c1;

   ERR <= '1' when (unsigned(A) > 9) or (unsigned(B) > 9) else '0';

   Cout <= S1;
   S <= S0;

   HEX_A <= hex_to_7seg(A);
   HEX_B <= hex_to_7seg(B);
   HEX_S0 <= hex_to_7seg(S0);
   HEX_S1 <= hex_to_7seg(("000" & S1));
   
end architecture RTL;