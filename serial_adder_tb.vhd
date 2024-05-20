library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_shift_register is
end tb_shift_register;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_serial_adder is
end tb_serial_adder;

architecture bhv of tb_serial_adder is

    component serial_adder is
        port (
            in_a : in std_logic_vector(3 downto 0);
            in_b : in std_logic_vector(3 downto 0);
            control : in std_logic_vector(1 downto 0);
            clk : in std_logic;
            clear : in std_logic;
            sum : out std_logic_vector(3 downto 0);
            carry : out std_logic
        );
    end component;

    function vec2str(vec: std_logic_vector) return string is
        variable stmp: string(vec'high+1 downto 1);
        variable counter : integer := 1;
    begin
        for i in vec'reverse_range loop
            stmp(counter) := std_logic'image(vec(i))(2);
            counter := counter + 1;
        end loop;
        return stmp;
    end vec2str;

    constant clk_period : time := 200 ns;
    signal in_a : std_logic_vector(3 downto 0) := (others => '0');
    signal in_b : std_logic_vector(3 downto 0) := (others => '0');
    signal control : std_logic_vector(1 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    signal clear : std_logic := '0';
    signal sum : std_logic_vector(3 downto 0);
    signal carry : std_logic;

begin
    UUT: serial_adder
    port map (
        in_a => in_a,
        in_b => in_b,
        control => control,
        clk => clk,
        clear => clear,
        sum => sum,
        carry => carry
    );

    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process clk_process;

    stim_process: process
    begin
        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        wait until rising_edge(clk);

        control <= "11";
        in_a <= X"0";
        in_b <= X"4";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"4" and carry = '0'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
               ". Expected sum: " & vec2str(X"4") & " expected carry: " & std_logic'image('0')(2) &
               ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        control <= "11";
        in_a <= X"C";
        in_b <= X"E";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"A" and carry = '1'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
                   ". Expected sum: " & vec2str(X"A") & " expected carry: " & std_logic'image('1')(2) &
		   ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        control <= "11";
        in_a <= X"8";
        in_b <= X"A";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"2" and carry = '1'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
                   ". Expected sum: " & vec2str(X"2") & " expected carry: " & std_logic'image('1')(2) &
		   ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        control <= "11";
        in_a <= X"F";
        in_b <= X"F";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"E" and carry = '1'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
                   ". Expected sum: " & vec2str(X"E") & " expected carry: " & std_logic'image('1')(2) &
		   ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        control <= "11";
        in_a <= X"F";
        in_b <= X"1";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"0" and carry = '1'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
                   ". Expected sum: " & vec2str(X"0") & " expected carry: " & std_logic'image('1')(2) &
		   ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        control <= "11";
        in_a <= X"A";
        in_b <= X"5";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"2" and carry = '0'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
                   ". Expected sum: " & vec2str(X"2") & " expected carry: " & std_logic'image('0')(2) &
		   ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

        control <= "11";
        in_a <= X"8";
        in_b <= X"7";
        wait for clk_period;
        control <= "01";
        wait for clk_period * 4;
        control <= "00";
        wait for clk_period;
        assert sum = X"F" and carry = '0'
        report "Serial adder failed to produce correct result at: " & time'image(now) &
                   ". Expected sum: " & vec2str(X"F") & " expected carry: " & std_logic'image('0')(2) &
		   ". Got sum: " & vec2str(sum) & " got carry: " & std_logic'image(carry)(2)
        severity error;

        clear <= '1';
        wait for clk_period/4;
        clear <= '0';

            assert false
            report "Simulation finished"
            severity failure;
    end process stim_process;
end bhv;
