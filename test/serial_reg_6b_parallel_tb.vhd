library ieee;
use ieee.std_logic_1164.all;

entity serial_reg_6b_parallel_tb is
end serial_reg_6b_parallel_tb;

architecture arch of serial_reg_6b_parallel_tb is
    component serial_reg_6b_parallel is
        generic(
            k : integer := 6
        );
        port(
            input, clk : in std_logic;
            output : out std_logic_vector(0 to k - 1)
        );
    end component;
    
    signal input: std_logic_vector(5 downto 0);
    signal w: std_logic;
    signal output: std_logic_vector(0 to 5);

    signal valid_in: std_logic := '0';
    constant clk_period : time := 10 ns;
    signal clk: std_logic;

begin
    dut: serial_reg_6b_parallel port map (
        clk => clk, input => w, output => output
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