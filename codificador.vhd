library ieee;
use ieee.std_logic_1164.all;

entity codificador
	is port(
		clk : in std_logic;
		input : in std_logic;
		output : out std_logic;
		valid_out : out std_logic
	);
end entity codificador;

architecture Comportamental of codificador is
	signal a: std_logic_vector(0 downto 59) := (others => '0'); --inicializa o vetor com '0's
	signal s: std_logic_vector(0 downto 5);
	signal P: std_logic;
begin
	cod_process: process(clk)
		variable s_idx : integer := 0;
		variable a_idx : integer := 0;
	begin
		if clk'event and clk = '1' then
			s(s_idx) <= input;
			a(a_idx) <= input;
			s_idx := s_idx + 1;
			if s_idx = 6 then
				a_idx := a_idx + 1;
				a(a_idx) <= not(s(0) xor s(1) xor s(2) xor s(3) xor s(4) xor s(5));
				s_idx := 0;
			end if;
			-- this might be a problem
			output <= a(0);
			a <= a(0 downto 58) & '0'; -- left shift
		end if;
	end process;
	valid_out <= '1';
end Comportamental;

