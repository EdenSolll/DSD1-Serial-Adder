library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_dff is
    Port ( d, clk, clear, en : in STD_LOGIC;
           q : out STD_LOGIC);
end my_dff;

architecture bhv of my_dff is
begin
    process(clk, clear)
    begin
        if(clear='1') then
            q <= '0';
        elsif rising_edge(clk) then
            if en = '1' then
                q <= d after 6 ns;
            end if;
        end if;
    end process;
end bhv;
