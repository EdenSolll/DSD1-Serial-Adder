library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    port ( a, b, cin : in  STD_LOGIC;
           sum, cout : out  STD_LOGIC);
end full_adder;

architecture bhv of full_adder is
begin
    sum <= a xor b xor cin after 8 ns;
    cout <= (a and b) or (b and cin) or (a and cin) after 8 ns;
end bhv;
