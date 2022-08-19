library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_8b_tb is
end decoder_8b_tb ;

architecture test of decoder_8b_tb is
    component decoder_8b is
        port (
            num : in std_logic_vector(0 to 2);
            saida : out std_logic_vector(0 to 7)
        ) ;
    end component;

    signal entrada: std_logic_vector(0 to 2);
    signal saida: std_logic_vector(0 to 7);
begin
    dut: decoder_8b port map(num => entrada, saida => saida);

    process
    begin
        wait for 10 ns;

        entrada <= "000";
        wait for 10 ns;

        for i in 0 to 10 loop
            entrada <= std_logic_vector(unsigned(entrada) + "001");
            wait for 10 ns;
        end loop ;
        wait;
    end process;
end architecture ; -- test