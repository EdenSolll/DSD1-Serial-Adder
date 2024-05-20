library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    port(
        SL : in std_logic;
        SR : in std_logic;
        clk : in std_logic;
        clear : in std_logic;
        mode : in std_logic_vector(1 downto 0);
        parallel : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0)
    );

end entity shift_register;

architecture bhv of shift_register is
	signal Q_shift : std_logic_vector(3 downto 0);
begin
	process(clk, clear)
	begin
		if clear = '1' then
			Q_shift <= (others => '0');
	       elsif rising_edge(clk) then
		       case mode is
				when "01" =>
				    Q_shift <= SR & Q_shift(3 downto 1);
				when "10" =>
				    Q_shift <= Q_shift(2 downto 0) & SL;
				when "11" =>
				    Q_shift <= parallel;
				when others =>
              Q_shift <= Q_shift;
			end case;
		end if;
	end process;
	Q <= Q_shift after 22 ns;
end architecture bhv;
