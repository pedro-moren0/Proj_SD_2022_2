-- Atrasa um sinal de entrada em 6 clocks utilizando
-- ffs.

-- Recebe um sinal de entrada e um sinal de clock.
-- Retorna o sinal de entrada atrasado.
library ieee;
use ieee.std_logic_1164.all;

entity delayer_6 is
  port (
    input, clk : in std_logic;
    output : out std_logic
  ) ;
end delayer_6 ;

architecture rtl of delayer_6 is
    component flipflopD is
        port(
            clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
	    );
    end component;

    signal q : std_logic_vector(0 to 6) := "0000000";
begin
    q(0) <= input;
    ff1: flipflopD port map(clk => clk, D => q(0), Q => q(1));
    ff2: flipflopD port map(clk => clk, D => q(1), Q => q(2));
    ff3: flipflopD port map(clk => clk, D => q(2), Q => q(3));
    ff4: flipflopD port map(clk => clk, D => q(3), Q => q(4));
    ff5: flipflopD port map(clk => clk, D => q(4), Q => q(5));
    ff6: flipflopD port map(clk => clk, D => q(5), Q => q(6));
    output <= q(6);

end architecture ; -- rtl