library ieee;
use ieee.std_logic_1164.all;

entity mod_reg_8b_serial_tb is
end mod_reg_8b_serial_tb;

architecture arch of mod_reg_8b_serial_tb is
    component mod_reg_8b_serial is
        port (
            main_in, sec_in, clk : in std_logic;
            state : in std_logic_vector(0 to 7);
            output : out std_logic
        ) ;
    end component;
    
    signal state : std_logic_vector(0 to 7) := "00000001";
    signal output: std_logic;
    signal s1: std_logic := '0';
    signal s2: std_logic := '1';

    signal valid_in: std_logic := '0';
    constant clk_period : time := 10 ns;
    signal clk: std_logic;

begin
    dut: mod_reg_8b_serial port map (
        main_in => s1,
        sec_in => s2,
        clk => clk,
        state => state,
        output => output
    );

    s1_process: process
    begin
        wait until clk'event and clk = '1';
        s1 <= not s1;
    end process;

    s2_process: process
    begin
        wait until s1'event and s1 = '1';
        s2 <= not s2;
    end process;

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

        valid_in <= '1';
        wait for clk_period * 6;

        state <= "00000010";
        wait for clk_period * 6;

        state <= "00000100";
        wait for clk_period * 6;

        valid_in <= '0';
        wait;
    end process;
end arch ; -- arch