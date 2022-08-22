-- Contador de 3 bits. A cada subida do clock
-- o contador e incrementado em 1 no bit mais
-- a direita (menos significativo). Quando ha overflow
-- o contador retorna a 000.
--
-- Recebe um sinal de clock.
-- Retorna um vetor que varia entre 000 e 111.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_3b is
  port (
    clk: in std_logic;
    output: out std_logic_vector(0 to 2)
  ) ;
end contador_3b ;

architecture bhv of contador_3b is
    signal s: std_logic_vector(0 to 2) := "111";
begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            s <= std_logic_vector(unsigned(s) + "001");
        end if ;
    end process;

    output <= s;

end architecture ; -- bhv