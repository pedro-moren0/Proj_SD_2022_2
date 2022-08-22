library ieee;
use ieee.std_logic_1164.all;

entity erro_signal is
  port (
    input, clk : in std_logic;
    output : out std_logic
  ) ;
end erro_signal ;

architecture rtl of erro_signal is
    component flipflopD is
        port(
            clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
	    );
    end component;

    signal q : std_logic;
    signal mux : std_logic;
    signal aux : std_logic := '1';
begin

    ff: flipflopD port map(
        clk => clk,
        D => mux,
        Q => q
    );

    process(clk)
        variable i : integer := 0;
    begin
        if clk'event and clk = '1' then
            i := i + 1;
            if i = 1 then
                aux <= '1';
            else
                aux <= '0';
                if i = 7 then
                    i := 0;
                end if ;
            end if ;
        end if ;
    end process;

    with aux select
        mux <= 
            input when '1',
            q when '0',
            'X' when others;

    output <= mux;
end architecture ; -- rtl