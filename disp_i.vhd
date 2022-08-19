library ieee;
use ieee.std_logic_1164.all;

entity disp_i is
    port (
        main_in, second_in, s1, s2 : in std_logic;
        d : out std_logic
      ) ;
end disp_i ;

architecture gatelvl of disp_i is
    signal inputs: std_logic_vector(0 to 1);
    signal in_sel: std_logic;
    signal state_sel: std_logic;
begin
    inputs(0) <= main_in and not s2;
    inputs(1) <= second_in and s2;
    in_sel <= inputs(0) or inputs(1);
    state_sel <= s1 or s2;
    d <= state_sel and in_sel;
end architecture ; -- gatelvl