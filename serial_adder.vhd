library ieee;
use ieee.std_logic_1164.all;

entity serial_adder is
    port (
        in_a : in std_logic_vector(3 downto 0);
        in_b : in std_logic_vector(3 downto 0);
        control : std_logic_vector(1 downto 0);
        clk : in std_logic;
        clear : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        carry : out std_logic
    );
end entity serial_adder;

architecture struct of serial_adder is

    component shift_register is
        port (
            SL : in std_logic;
            SR : in std_logic;
            clk : in std_logic;
            clear : in std_logic;
            mode : in std_logic_vector(1 downto 0);
            parallel : in std_logic_vector(3 downto 0);
            Q : out std_logic_vector(3 downto 0)
        );
    end component;

    component my_dff is
        port (
            d : in std_logic;
            clk : in std_logic;
            clear : in std_logic;
            en : in std_logic;
            q : out std_logic
        );
    end component;

    component my_and2 is
        port (
            a : in std_logic;
            b : in std_logic;
            y : out std_logic
        );
    end component;

    component invert is
        port (
            a : in std_logic;
            y : out std_logic
        );
    end component;

    component full_adder is
        port (
            a : in std_logic;
            b : in std_logic;
            cin : in std_logic;
            sum : out std_logic;
            cout : out std_logic
        );
    end component;

    signal Q_regA : std_logic_vector(3 downto 0);
    signal Q_regB : std_logic_vector(3 downto 0);
    signal Q_cout : std_logic;
    signal Q_invert : std_logic;
    signal Q_and2 : std_logic;
    signal Q_dff : std_logic;
    signal Q_sum : std_logic;


begin
    shift_regA : shift_register port map (SL => '0', SR => Q_sum, clk => clk, clear => clear, mode => control, parallel => in_a, Q => Q_regA);
    shift_regB : shift_register port map (SL => '0', SR => '0', clk => clk, clear => clear, mode => control, parallel => in_b, Q => Q_regB);

    invert_A : invert port map (a => control(1), y => Q_invert);
    and2_A : my_and2 port map (a => Q_invert, b => control(0), y => Q_and2);

    dff_A : my_dff port map (d => Q_cout, clk => clk, clear => clear, en => Q_and2, q => Q_dff);

    full_adder_A : full_adder port map (a => Q_regA(0), b => Q_regB(0), cin => Q_dff, sum => Q_sum, cout => Q_cout);

    sum <= Q_regA;
    carry <= Q_dff;
end architecture struct;
