LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
PORT( Op_code : IN STD_LOGIC_VECTOR( 2 DOWNTO 0 );
A, B : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
Y : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 ) );
END ALU;

architecture behavior OF ALU IS
BEGIN
    PROCESS(Op_code, A, B)
    BEGIN
    CASE Op_code IS
    WHEN "000" =>
    Y <= A;
    WHEN "001" =>
    Y <= A + B;
    WHEN "010" =>
    Y <= A - B;
    WHEN "011" =>
    Y <= A AND B;
    WHEN "100" =>
    Y <= A OR B;
    WHEN "101" =>
    Y <= A + 1;
    WHEN "110" =>
    Y <= A - 1;
    WHEN "111" =>
    Y <= B;
    WHEN OTHERS =>
    Y <= (OTHERS => '0');
    END CASE;
    END PROCESS;
end behavior;