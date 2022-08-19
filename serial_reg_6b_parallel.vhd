library ieee;
use ieee.std_logic_1164.all;

entity serial_reg_6b_parallel is
    generic(
        k : integer := 6
    );
    port(
        input, clk : in std_logic;
        output : out std_logic_vector(0 to k - 1)
    );
end serial_reg_6b_parallel;

architecture rtl of serial_reg_6b_parallel is
    component flipflopD is
        port(
            clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
	    );
    end component;

    signal q : std_logic_vector(0 to k - 1) := "000000";
begin

    q(0) <= input;
    ff1: flipflopD port map(clk => clk, D => input, Q => q(1));
    ff2: flipflopD port map(clk => clk, D => q(1), Q => q(2));
    ff3: flipflopD port map(clk => clk, D => q(2), Q => q(3));
    ff4: flipflopD port map(clk => clk, D => q(3), Q => q(4));
    ff5: flipflopD port map(clk => clk, D => q(4), Q => q(5));
    output <= q;
end rtl ; -- rtl