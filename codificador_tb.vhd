library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;

entity codificador_tb is
    generic(
        in_size : integer := 6
    );
end codificador_tb;

architecture arch of codificador_tb is
    component codificador is
        port(
            clk : in std_logic;
            input : in std_logic;
            output : out std_logic;
            valid_out : out std_logic
	    );
    end component;
    
    signal input: std_logic_vector(0 to in_size - 1);
    signal w: std_logic;
    signal output: std_logic;
    signal valid_out: std_logic;

    signal valid_in: std_logic := '0';
    constant clk_period : time := 10 ns;
    signal clk: std_logic;

begin
    dut: codificador port map (
        clk => clk, input => w, output => output, valid_out => valid_out
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
                w <= input(i mod in_size);
                i := i + 1;
            else
                i := 0;
            end if ;
        end if ;
    end process;

    dut_process: process
    begin
        
        valid_in <= '1';
        input <= "101011"; --p=1
        wait for clk_period * in_size;

        input <= "010100"; --p=1
        wait for clk_period * in_size;

        input <= "111110"; --p=0
        wait for clk_period * in_size;

        input <= "110011"; --p=1
        wait for clk_period * in_size;

        input <= "100010"; --p=1
        wait for clk_period * in_size;

        input <= "000111"; --p=0
        wait for clk_period * in_size;
        valid_in <= '0';
        wait for clk_period/2;

        wait;
    end process;
end arch ; -- arch