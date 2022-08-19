library ieee;
use ieee.std_logic_1164.all;

entity decoder_8b is
  port (
    input : in std_logic_vector(0 to 2);
    output : out std_logic_vector(0 to 7)
  ) ;
end decoder_8b ;

architecture bhv of decoder_8b is
begin
    with input select
        output <= "00000001" when "000",
                 "00000010" when "001",
                 "00000100" when "010",
                 "00001000" when "011",
                 "00010000" when "100",
                 "00100000" when "101",
                 "01000000" when "110",
                 "10000000" when "111",
                 "00000000" when others;
end architecture ; -- bhv