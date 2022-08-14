library ieee;
use ieee.std_logic_1164.all;

entity codificador_tb is
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
    
    signal input: std_logic_vector(0 to 5);
    signal w: std_logic;
    signal output: std_logic;
    signal valid_out: std_logic;

    constant clk_period : time := 10 ns;
    signal clk: std_logic;

begin
    dut: codificador port map (
        clk => clk, input => w, output => output, valid_out => valid_out
    );

    -- Clock process definition
    clk_process: process
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process;

    -- dut process
    test: process
    begin

        input <= "101011";
        for i in input'range loop
            w <= input(i);
            wait for clk_period;
        end loop;

        input <= "010100";
        for i in input'range loop
            w <= input(i);
            wait for clk_period;
        end loop;

        input <= "111110";
        for i in input'range loop
            w <= input(i);
            wait for clk_period;
        end loop;

        wait;
    end process;
end arch ; -- arch