library ieee;
use ieee.std_logic_1164.all;

entity flipflopD is
  port (
    D, clk : in std_logic;
    Q      : out std_logic
  ) ;
end flipflopD;

architecture bhv of flipflopD is
begin
    ff : process
    begin
      wait until clk'event and clk = '1';
      Q <= D;
    end process ; -- ff
end bhv ; -- bhv