library ieee;
use ieee.std_logic_1164.all;

entity serial_reg_7b_paraser_tb is
end serial_reg_7b_paraser_tb;

architecture arch of serial_reg_7b_paraser_tb is
    component serial_reg_7b_paraser is
        port(
            input, clk : in std_logic;
            out_ser : out std_logic;
            out_par : out std_logic_vector(0 to 6)
        );
    end component;
    
    signal input: std_logic_vector(0 to 6);
    signal w: std_logic;
    signal out_par: std_logic_vector(0 to 6);
    signal out_ser: std_logic;

    signal valid_in: std_logic := '0';
    constant clk_period : time := 10 ns;
    signal clk: std_logic;

begin
    dut: serial_reg_7b_paraser port map (
        clk => clk, input => w, out_par => out_par, out_ser => out_ser
    );

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    serial_input: process(clk)
        variable i: integer := 0;
    begin
        if clk'event and clk = '1' then
            if valid_in = '1' then
                w <= input(i mod 6);
                i := i + 1;
            else
                i := 0;
            end if ;
        end if ;
    end process;

    dut_process: process
    begin
        
        valid_in <= '1';
        input <= "1010111"; --p=1
        wait for clk_period * 7;

        input <= "0101000"; --p=1
        wait for clk_period * 7;

        input <= "1111100"; --p=0
        wait for clk_period * 7;

        input <= "1100111"; --p=1
        wait for clk_period * 7;

        input <= "1000100"; --p=1
        wait for clk_period * 7;

        input <= "0001111"; --p=0
        wait for clk_period * 7;

        valid_in <= '0';
        wait for clk_period/2;

        wait;
    end process;
end arch ; -- arch