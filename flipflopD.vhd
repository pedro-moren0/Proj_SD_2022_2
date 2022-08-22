library ieee;
use ieee.std_logic_1164.all;

entity flipflopD is
  port (
    D, clk : in std_logic;
    Q      : out std_logic
  ) ;
end flipflopD;

architecture bhv of flipflopD is
  signal reset : std_logic := '0';
begin
    ff : process
    begin
      if reset = '0' then
        Q <= '0';
      end if ;
      wait until clk'event and clk = '1';
      Q <= D;
      reset <= '1';
    end process ; -- ff
end bhv ; -- bhv