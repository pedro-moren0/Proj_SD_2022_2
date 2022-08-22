library ieee;
use ieee.std_logic_1164.all;

entity delayer_6_tb is
end delayer_6_tb;

architecture test of delayer_6_tb is
    component delayer_6 is
        port (
            input, clk: in std_logic;
            output: out std_logic
        ) ;
    end component;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
    signal s1: std_logic := '0';
    signal saida: std_logic;

begin
    dut: delayer_6 port map (input => s1, clk => clk, output => saida);

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    s1_process: process
    begin
        wait until clk'event and clk = '1';
        s1 <= not s1;
    end process;
end test ; -- test