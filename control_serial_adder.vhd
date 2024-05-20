library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_serial_adder is
    Port (
      clk : in std_logic;
      start : in std_logic;
      clear_sm : in std_logic;
      inA : in std_logic_vector(3 downto 0);
      inB : in std_logic_vector(3 downto 0);
      ready : out std_logic;
      cout : out std_logic;
      sum : out std_logic_vector(3 downto 0)
    );
end entity control_serial_adder;

architecture struct of control_serial_adder is

  component state_machine is
    port(
      clk : in std_logic;
      start : in std_logic;
      reset_sm : in std_logic;
      output : out std_logic_vector(3 downto 0)
    );
  end component;

  component serial_adder is
    port (
        in_a : in std_logic_vector(3 downto 0);
        in_b : in std_logic_vector(3 downto 0);
        control : std_logic_vector(1 downto 0);
        clk : in std_logic;
        clear : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        carry : out std_logic
    );
  end component;

  signal control_line : std_logic_vector(3 downto 0);

begin

  control_unit : state_machine port map (clk => clk, reset_sm => clear_sm, start => start, output => control_line);
  serial_adderA : serial_adder port map (in_a => inA, in_B => inB, control => control_line(1 downto 0), clk => clk, clear => control_line(2), sum => sum, carry => cout);
  ready <= control_line(3);
end architecture;
