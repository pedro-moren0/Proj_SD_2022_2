library ieee;
use ieee.std_logic_1164.all;

entity contador_3b_tb is
end contador_3b_tb;

architecture test of contador_3b_tb is
    component contador_3b is
        port (
            clk: in std_logic;
            num: out std_logic_vector(0 to 2)
        ) ;
    end component;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
    signal saida: std_logic_vector(0 to 2);

begin
    dut: contador_3b port map (clk => clk, num => saida);

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
end test ; -- test