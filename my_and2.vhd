library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_and2 is
    Port ( a, b : in  STD_LOGIC;
           y : out  STD_LOGIC);
end my_and2;

architecture bhv of my_and2 is
begin
    y <= a and b after 4 ns;
end bhv;
