-- Implementa a logica de validacao de saida do detector.
-- Gera uma onda de valor alto por 6 clocks, seguida por
-- uma onda de valor baixo por um clock.
--
-- Recebe um sinal de clock.
-- Retorna o sinal de validacao caracteristico do detector.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity detector_valid_signal is
    port (
        clk: in std_logic;
        output: out std_logic
    );
end detector_valid_signal ;

architecture bhv of detector_valid_signal is
    signal s: std_logic := '1';
begin

    process(clk)
        variable i : integer := 0;
    begin
        if clk'event and clk = '1' then
            i := i + 1;
            if i < 6 then
                s <= '1';
            elsif i = 7 then
                s <= '0';
                i := 0;
            end if ;
        end if ;

    end process;

    output <= s;
end architecture ; -- bhv