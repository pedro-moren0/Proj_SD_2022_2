library ieee;
use ieee.std_logic_1164.all;

entity paridade_impar_6b_tb is
end paridade_impar_6b_tb ;

architecture test of paridade_impar_6b_tb is
    component paridade_impar_6b is
        port (
            bits : in std_logic_vector(0 to 5);
            output: out std_logic
        ) ;
    end component;

    signal entrada : std_logic_vector(0 to 5);
    signal saida : std_logic;
begin
    dut: paridade_impar_6b port map(bits => entrada, output => saida);

    test: process
    begin
        entrada <= "101011";
        wait for 10 ns;

        entrada <= "010100";
        wait for 10 ns;

        entrada <= "111110";
        wait for 10 ns;
        wait;
    end process;
end architecture ; -- test