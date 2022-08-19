library ieee;
use ieee.std_logic_1164.all;

entity mod_reg_8b_serial is
    port (
        main_in, sec_in, clk : in std_logic;
        state : in std_logic_vector(0 to 7);
        output : out std_logic
    ) ;
end mod_reg_8b_serial ;

architecture rtl of mod_reg_8b_serial is

    component flipflopD is
        port(
            clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
	    );
    end component;

    component disp_m is
        port (
            main_in, second_in, s1, s2, q1 : in std_logic;
            d : out std_logic
        ) ;
    end component;

    component disp_i is
        port (
            main_in, second_in, s1, s2 : in std_logic;
            d : out std_logic
        ) ;
    end component;

    component disp_f is
        port (
            main_in, s1, q1 : in std_logic;
            d : out std_logic
        ) ;
    end component;

    signal ds : std_logic_vector(0 to 7);
    signal qs : std_logic_vector(0 to 7);
begin

    dispI0: disp_i port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(0),
        s2 => state(1),
        d => ds(0)
    );
    ff0: flipflopD port map(
        D => ds(0), Q => qs(0), clk => clk
    );

    dispM1: disp_m port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(1),
        s2 => state(2),
        q1 => qs(0), d => ds(1)
    );
    ff1: flipflopD port map(
        D => ds(1), Q => qs(1), clk => clk
    );

    dispM2: disp_m port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(2),
        s2 => state(3),
        q1 => qs(1), d => ds(2)
    );
    ff2: flipflopD port map(
        D => ds(2), Q => qs(2), clk => clk
    );

    dispM3: disp_m port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(3),
        s2 => state(4),
        q1 => qs(2), d => ds(3)
    );
    ff3: flipflopD port map(
        D => ds(3), Q => qs(3), clk => clk
    );

    dispM4: disp_m port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(4),
        s2 => state(5),
        q1 => qs(3), d => ds(4)
    );
    ff4: flipflopD port map(
        D => ds(4), Q => qs(4), clk => clk
    );

    dispM5: disp_m port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(5),
        s2 => state(6),
        q1 => qs(4), d => ds(5)
    );
    ff5: flipflopD port map(
        D => ds(5), Q => qs(5), clk => clk
    );

    dispM6: disp_m port map(
        main_in => main_in,
        second_in => sec_in,
        s1 => state(6),
        s2 => state(7),
        q1 => qs(5), d => ds(6)
    );
    ff6: flipflopD port map(
        D => ds(6), Q => qs(6), clk => clk
    );

    dispF7: disp_f port map(
        main_in => main_in,
        s1 => state(7), q1 => qs(6), d => ds(7)
    );

    output <= ds(7);
end architecture ; -- rtl