library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity invert is
    Port ( a : in  STD_LOGIC;
           y : out  STD_LOGIC);
end invert;

architecture bhv of invert is
begin
    y <= not a after 2 ns;
end bhv;
