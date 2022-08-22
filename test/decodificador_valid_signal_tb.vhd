library ieee;
use ieee.std_logic_1164.all;

entity decodificador_valid_signal_tb is
end decodificador_valid_signal_tb;

architecture arch of decodificador_valid_signal_tb is
    component decodificador_valid_signal is
        port (
            clk: in std_logic;
            output : out std_logic
        ) ;
    end component;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
    signal dclk: std_logic;

begin
    dut: decodificador_valid_signal port map (clk => clk, output => dclk);

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
end arch ; -- arch