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