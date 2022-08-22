library ieee;
use ieee.std_logic_1164.all;

entity period_changer_7_tb is
end period_changer_7_tb;

architecture arch of period_changer_7_tb is
    component period_changer_7 is
        port (
            clk: in std_logic;
            output: out std_logic
        );
    end component;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
    signal dclk: std_logic;

begin
    dut: period_changer_7 port map (clk => clk, output => dclk);

    -- Clock process definition
    clk_process: process
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process;
end arch ; -- arch