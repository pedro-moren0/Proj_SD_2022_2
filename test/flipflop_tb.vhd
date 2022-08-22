library ieee;
use ieee.std_logic_1164.all;

entity flipflop_tb is
end flipflop_tb;

architecture arch of flipflop_tb is
    component flipflopD is
        port(
            clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
	    );
    end component;
    
    signal input: std_logic_vector(0 to 5);
    signal w: std_logic;
    signal output: std_logic;
    signal output2: std_logic;

    signal valid_in: std_logic := '0';
    constant clk_period : time := 10 ns;
    signal clk: std_logic;
    signal s1 : std_logic :='0';

begin
    dut: flipflopD port map (
        clk => clk, D => w, Q => output
    );

    dut2: flipflopD port map (
        clk => s1, D => w, Q => output2
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

    s1_process: process
    begin
        wait until clk'event and clk = '1';
        s1 <= not s1;
    end process;

    dut_process: process
    begin
        
        valid_in <= '1';
        input <= "101011";
        wait for clk_period * 6;

        input <= "010100";
        wait for clk_period * 6;

        input <= "111110";
        wait for clk_period * 6;
        wait for clk_period/2;

        valid_in <= '0';
        wait;
    end process;
end arch ; -- arch