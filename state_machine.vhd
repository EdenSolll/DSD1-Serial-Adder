library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
port(
  clk : in std_logic;
  start : in std_logic;
  reset_sm : in std_logic;
  output : out std_logic_vector(3 downto 0)
);
end entity state_machine;

architecture bhv of state_machine is
  -- Build an enumerated type for the state machine
  type state_type is (IDLE, RESET, LOAD, S1, S2, S3, S4, HOLD);
  -- Register to hold the current state
  signal next_state, state : state_type;

begin
  sync_proc : process (clk, reset_sm)
begin
  if reset_sm = '0' then
    state <= IDLE;
  elsif clk'event and clk='1' then
    state <= next_state;
  end if;
end process;
next_state_proc : process (state, start)
begin
  case state is
    when IDLE=>
      if start = '1' then
        next_state <= RESET after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when RESET=>
      if start = '1' then
        next_state <= LOAD after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when LOAD=>
      if start = '1' then
        next_state <= S1 after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when S1=>
      if start = '1' then
        next_state <= S2 after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when S2=>
      if start = '1' then
        next_state <= S3 after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when S3=>
      if start = '1' then
        next_state <= S4 after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when S4=>
      if start = '1' then
        next_state <= HOLD after 10 ns;
      else
        next_state <= IDLE after 10 ns;
      end if;
    when others=> next_state <= IDLE after 10 ns;
  end case;
end process;

output_proc : process (clk) begin
  if clk'event and clk = '1' then
    case next_state is
      when IDLE => output <= "1000";
      when RESET => output <= "0100";
      when LOAD => output <= "0011";
      when HOLD => output <= "0000";
      when others => output <= "0001";
    end case;
  end if;
end process;
end bhv;
