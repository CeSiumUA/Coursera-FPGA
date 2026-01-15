library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity C4M1P3 is
   port(
      A : in std_logic_vector(3 downto 0);
      B : in std_logic_vector(3 downto 0);
      Cin : in std_logic;
      S : out std_logic_vector(3 downto 0);
      Cout : out std_logic
   );
end entity C4M1P3;

architecture RTL of C4M1P3 is
   -- Internal carry signals
   signal C : std_logic_vector(4 downto 0);
begin
   -- Connect input carry
   C(0) <= Cin;
   
   gen_adder: for i in 0 to 3 generate
      S(i) <= A(i) xor B(i) xor C(i);
      C(i+1) <= (A(i) and B(i)) or (C(i) and (A(i) xor B(i)));
   end generate gen_adder;
   
   -- Connect output carry
   Cout <= C(4);
   
end architecture RTL;