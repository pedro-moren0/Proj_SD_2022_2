library ieee;
use ieee.std_logic_1164.all;

entity disp_f_tb is
end disp_f_tb ;

architecture test of disp_f_tb is
    component disp_f is
        port (
            main_in, s1, q1 : in std_logic;
            d : out std_logic
        ) ;
    end component;

    signal esse : std_logic;
    signal q: std_logic := '0';
    signal saida : std_logic;
    
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
begin
    dut: disp_f port map (
        main_in => clk, s1 => esse, q1 => q, d => saida
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

        esse <= '1';
        wait for clk_period * 2;

        esse <= '0';
        wait for clk_period;
        q <= '1';
        wait for clk_period;

        wait;
    end process;
end test ; -- arch