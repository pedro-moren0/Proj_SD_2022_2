-- Gera um sinal de clock mais lento com base
-- em um sinal de clock de entrada. O periodo
-- do sinal de saida equivale a 6 periodos do
-- sinal de entrada.
--
-- Recebe um sinal de clock.
-- Retorna um sinal de clock mais lento conforme
-- descricao.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity period_changer_6 is
    port (
        clk: in std_logic;
        output: out std_logic
    );
end period_changer_6 ;

architecture bhv of period_changer_6 is
    signal s: std_logic := '1';
begin

    process(clk)
        variable i : integer := -1;
    begin
        if clk'event and clk = '1' then
            i := i + 1;
            if i = 3 then
                s <= not s;
                i := 0;
            end if ;
        end if ;

    end process;

    output <= s;
end architecture ; -- bhv