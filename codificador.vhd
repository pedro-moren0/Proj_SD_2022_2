-- Adiciona um bit redundante a um pacote de 6 bits
-- para possivel deteccao de erros de transmissao.
-- O bit redundante e calculado utilizando a paridade impar
-- do pacote. Esse modulo suporta o envio de ate 8 pacotes,
-- apos isso ha overflow, indicado pela negacao de valid_out.
--
-- Recebe pacotes de 6 bits serialmente e um sinal de clock.
-- Retorna o pacote mais paridade serialmente, e também um sinal
-- valid_out, que valida a saida.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity codificador is
	port(
		clk : in std_logic;
		input : in std_logic;
		output : out std_logic;
		valid_out : out std_logic
	);
end entity codificador;

architecture rtl of codificador is
	component contador_3b is
		port (
			clk: in std_logic;
			output: out std_logic_vector(0 to 2)
		) ;
	end component;

	component decoder_8b is
		port (
			input : in std_logic_vector(0 to 2);
			output : out std_logic_vector(0 to 7)
		) ;
	end component;

	component mod_reg_8b_serial is
		port (
			main_in, sec_in, clk : in std_logic;
			state : in std_logic_vector(0 to 7);
			output : out std_logic
		) ;
	end component;

	component paridade_impar_6b is
		port (
			input : in std_logic_vector(0 to 5);
			output: out std_logic
		) ;
	end component;

	component period_changer_6 is
		port (
			clk: in std_logic;
			output: out std_logic
		);
	end component;

	component serial_reg_6b_parallel is
		port(
			input, clk : in std_logic;
			output : out std_logic_vector(0 to 5)
		);
	end component;

	signal contador_3b_out : std_logic_vector(0 to 2);
	signal decoder_8b_out : std_logic_vector(0 to 7);
	signal par_out : std_logic;
	signal pchanger_out : std_logic;
	signal srg6_out : std_logic_vector(0 to 5);

	signal teste : std_logic_vector(0 to 7);
	signal overflow : std_logic := '1';
begin
	srg6: serial_reg_6b_parallel port map(
		input => input,
		clk => clk,
		output => srg6_out
	);

	par: paridade_impar_6b port map(
		input => srg6_out,
		output => par_out
	);

	clk6: period_changer_6 port map(
		clk => clk,
		output => pchanger_out
	);

	contador: contador_3b port map(
		clk => pchanger_out,
		output => contador_3b_out
	);

	decoder: decoder_8b port map(
		input => contador_3b_out,
		output => decoder_8b_out
	);

	modsrg8: mod_reg_8b_serial port map(
		main_in => input,
		sec_in => par_out,
		clk => clk,
		state => decoder_8b_out,
		output => output
	);

	overflow_process: process(clk)
		variable i : integer := 0;
	begin
		if clk'event and clk = '1' then
			if contador_3b_out = "111" then
				overflow <= '1';
				i := 1;
			elsif i = 0 then
				overflow <= '0';
			end if ;
		end if ;
	end process;

	-- valid_out_process: process(clk)
	-- begin
	-- 	if clk'event and clk = '1' then
	-- 		valid_out <= not overflow;
	-- 	else
	-- 		valid_out <
	-- 	end if ;
	-- end process;

	valid_out <= not overflow;
end rtl;

