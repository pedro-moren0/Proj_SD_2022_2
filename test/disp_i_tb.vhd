library ieee;
use ieee.std_logic_1164.all;

entity disp_i_tb is
end disp_i_tb ;

architecture test of disp_i_tb is
    component disp_i is
        port (
            main_in, second_in, s1, s2 : in std_logic;
            d : out std_logic
        ) ;
    end component;

    signal esse : std_logic;
    signal prox : std_logic;
    signal saida : std_logic;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
begin
    dut: disp_i port map (
        main_in => clk, second_in => '1', s1 => esse, s2 => prox, d => saida
    );

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    dut_process: process
    begin
        
        wait until clk'event and clk = '1';

        esse <= '0';
        prox <= '0';
        wait for clk_period * 2;

        esse <= '1';
        prox <= '0';
        wait for clk_period * 2;

        esse <= '0';
        prox <= '1';
        wait for clk_period * 2;
        wait;
    end process;
end test ; -- arch