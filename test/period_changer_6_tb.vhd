library ieee;
use ieee.std_logic_1164.all;

entity period_changer_6_tb is
end period_changer_6_tb;

architecture arch of period_changer_6_tb is
    component period_changer_6 is
        port (
            clock: in std_logic;
            delay : out std_logic
        ) ;
    end component;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
    signal dclk: std_logic;

begin
    dut: period_changer_6 port map (clock => clk, delay => dclk);

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
end arch ; -- arch