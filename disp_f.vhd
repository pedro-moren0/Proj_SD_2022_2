-- Encapsulamento para a logica de conexao dos ffs
-- do registrador modificado.
--
-- Recebe um sinal serial main, um sinal serial q1
-- que vem de um ff, e um bit enable s1.
-- Quando s1 esta alto, retorna main, e caso contrario,
-- retorna o sinal q1.
library ieee;
use ieee.std_logic_1164.all;

entity disp_f is
    port (
        main_in, s1, q1 : in std_logic;
        d : out std_logic
      ) ;
end disp_f ;

architecture gatelvl of disp_f is
    signal inputs: std_logic_vector(0 to 1);
begin
    inputs(0) <= main_in and s1;
    inputs(1) <= q1 and not s1;
    d <= inputs(0) or inputs(1);
end architecture ; -- gatelvl