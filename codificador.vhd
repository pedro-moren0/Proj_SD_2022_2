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

architecture Comportamental of codificador is
	signal a: std_logic_vector(0 to 59); --inicializa o vetor com '0's
	signal s: std_logic_vector(0 to 5) := "000000";
	signal P: std_logic;
	signal s_idx: integer := -1;
	signal a_idx: integer := 0;

	signal teste: std_logic_vector(0 to 1) := "00";
begin
	
	P <= not(s(0) xor s(1) xor s(2) xor s(3) xor s(4) xor s(5));
	a(a_idx mod 60) <= input;
	a((a_idx + 1) mod 60) <= P;

	teste(a_idx mod 2) <= input;
	teste((a_idx + 1) mod 2) <= P;

	s(s_idx mod 6) <= input;
	output <= a(0);
	with input select
		valid_out <=
			'1' when '0' | '1',
			'0' when others;
	-- valid_out <= '1' when (input = '1' or input = '0') else	'0';
	
	teste_process: process(clk)
	begin
		if clk'event and clk = '1' then
			s_idx <= (s_idx + 1);
			if s_idx = 5 then
				a_idx <= (a_idx + 1);
				-- a(teste_a mod 60) <= P;
				s_idx <= 0;
			end if ;
		end if ;
	end process;

	-- cod_process: process(clk)
	-- 	variable aux : integer := 0;
	-- 	variable debug_count : integer := 0;
	-- begin
	-- 	if clk'event and clk = '1' then
	-- 		s_idx := (s_idx + 1) mod 6;
	-- 		aux := aux + 1;
	-- 		if aux = 6 then
	-- 			a_idx := a_idx + 1;
	-- 			aux := 0;
	-- 		end if;
	-- 		-- a <= a(1 to 59) & '0'; -- left shift
	-- 	end if;
	-- end process;
	
end Comportamental;

