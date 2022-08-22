library ieee;
use ieee.std_logic_1164.all;

entity detector is
    port(
        clk: in std_logic;
        input: in std_logic;
        output: out std_logic;
        erro: out std_logic;
        valid_out : out std_logic
    );
end entity detector;

architecture rtl of detector is
    component delayer_6 is
        port (
            input, clk : in std_logic;
            output : out std_logic
        );
    end component;

    component detector_valid_signal is
        port (
            clk: in std_logic;
            output: out std_logic
        );
    end component;

    component serial_reg_7b_paraser is
        port(
            input, clk : in std_logic;
            out_ser : out std_logic;
            out_par : out std_logic_vector(0 to 6)
        );
    end component;

    component paridade_impar_6b is
		port (
			input : in std_logic_vector(0 to 5);
			output: out std_logic
		) ;
	end component;

    component erro_signal is
        port (
            input, clk : in std_logic;
            output : out std_logic
        );
    end component ;

    signal pacote: std_logic_vector(0 to 6);
    signal par_out: std_logic;
    signal detector_valid_signal_out : std_logic;
    signal delay_clk_out: std_logic;
    signal aux : std_logic;
begin
    srg: serial_reg_7b_paraser port map(
        input => input,
        clk => clk,
        out_par => pacote,
        out_ser => output
    );

    par: paridade_impar_6b port map(
        input => pacote(1 to 6),
        output => par_out
    );

    valid_signal: detector_valid_signal port map(
        clk => clk,
        output => detector_valid_signal_out
    );
    delay_valid: delayer_6 port map(
        input => detector_valid_signal_out,
        clk => clk,
        output => valid_out
    );
    
    aux <= pacote(0) xor par_out;
    
    erro_out: erro_signal port map(
        input => aux,
        clk => delay_clk_out,
        output => erro
    );

    clk_delay: process(clk)
        variable i : integer := 0;
    begin
        if clk'event and clk = '1' then
            if i < 7 then
                i := i + 1;
            end if ;
        end if;
        if i < 7 then
            delay_clk_out <= '0';
        else
            delay_clk_out <= clk;
        end if ;
    end process;
end rtl ; -- rtl