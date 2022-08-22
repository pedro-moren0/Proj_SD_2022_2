-- Calcula a paridade impar para uma sequencia
-- de 6 bits.
--
-- Recebe um vetor de 6 bits.
-- Retorna a paridade impar da entrada.
library ieee;
use ieee.std_logic_1164.all;

entity paridade_impar_6b is
  port (
    input : in std_logic_vector(0 to 5);
    output: out std_logic
  ) ;
end paridade_impar_6b;

architecture gatelvl of paridade_impar_6b is
begin
  output <= 
      not(input(0) xor input(1) xor input(2) xor input(3) xor input(4) xor input(5));
end gatelvl ; -- gatelvl