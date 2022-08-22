-- Encapsulamento para a logica de conexao dos ffs
-- do registrador modificado.
--
-- Recebe um sinal serial main, um sinal serial secundario
-- second, um sinal de memoria q1, e dois bits enable s1 e s2.
-- Quando s1 alto e s2 baixo, retorna main,
-- quando s1 baixo e s2 alto, retorna secundario,
-- e quando ambos baixos, retorna q1.
-- s1 e s2 altos nao ocorre.
library ieee;
use ieee.std_logic_1164.all;

entity disp_m is
  port (
    main_in, second_in, s1, s2, q1 : in std_logic;
    d : out std_logic
  ) ;
end disp_m ;

architecture gatelvl of disp_m is
    signal inputs: std_logic_vector(0 to 1);
    signal in_sel: std_logic;
    signal state_sel: std_logic;
    signal mem_sel: std_logic;
begin
    inputs(0) <= main_in and not s2;
    inputs(1) <= second_in and s2;
    in_sel <= inputs(0) or inputs(1);
    state_sel <= s1 or s2;
    mem_sel <= q1 and not state_sel;
    d <= (state_sel and in_sel) or mem_sel;
end architecture ; -- gatelvl