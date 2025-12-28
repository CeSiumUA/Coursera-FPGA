library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO8x9 is
   port(
      clk, rst:		in std_logic;
      RdPtrClr, WrPtrClr:	in std_logic;    
      RdInc, WrInc:	in std_logic;
      DataIn:	 in std_logic_vector(8 downto 0);
      DataOut: out std_logic_vector(8 downto 0);
      rden, wren: in std_logic
	);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
	--signal declarations
	type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);  -- makes use of VHDL’s enumerated type
	signal fifo:  fifo_array;
	signal wrptr, rdptr: unsigned(2 downto 0);
	signal en: std_logic_vector(7 downto 0);
	signal dmuxout: std_logic_vector(8 downto 0);

   begin
   process (clk, rst, rden, wren, RdInc, WrInc)
   begin
      if rising_edge(clk) then
         if RdPtrClr = '1' then
            rdptr <= (others => '0');
         end if;
         if WrPtrClr = '1' then
            wrptr <= (others => '0');
         end if;

         if rden = '1' and RdInc = '1' then
               rdptr <= rdptr + 1;
         end if;

         if wren = '1' then
            if WrInc = '1' then
               wrptr <= wrptr + 1;
            end if;
            fifo(to_integer(wrptr)) <= DataIn;
         end if;

         if rst = '1' then
            rdptr <= (others => '0');
            wrptr <= (others => '0');
            DataOut <= (others => '0');
         end if;
      else
         if rden = '0' then
            DataOut <= (others => 'Z');
         else
            DataOut <= fifo(to_integer(rdptr));
         end if;
      end if;
   end process;
end architecture RTL;
