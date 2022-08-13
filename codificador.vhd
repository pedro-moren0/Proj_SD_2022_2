-- teste git push
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
	signal a: std_logic_vector(0 to 60);
	signal s: std_logic_vector(0 to 5);
	signal P: std_logic;
begin
	calcula_paridade: process(clk)
			variable idx : integer := 0;
	begin
		if clk'event and clk = '1' then
			s(idx) <= input;
			idx := idx + 1;
			if idx = 6 then
				output <= NOT(s(0) xor s(1) xor s(2) xor s(3) xor s(4) xor s(5));
				idx := 0;
			end if;
		end if;
	end process;
	
	buffer_saida: process(clk)
	begin
	end process;
end Comportamental;

