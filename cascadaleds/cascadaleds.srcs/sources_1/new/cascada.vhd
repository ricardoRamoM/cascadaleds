library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CascadeLED is
    Port ( Clock : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Switch : in STD_LOGIC;
           LEDS : out STD_LOGIC_VECTOR (15 downto 0));
end CascadeLED;

architecture Behavioral of CascadeLED is

signal s_state: integer := 0;
signal s_clk_en: std_logic := '0';
signal s_count: integer := 0;

begin

s_clk_en <= Clock and Switch;

process (s_clk_en, Reset)
begin
    if Reset = '1' then
        s_state <= 0;
        s_count <= 0;
    elsif rising_edge(s_clk_en) then
        s_count <= s_count + 1;
        if s_count = 10000000  then --ajustar para ajustar la velocidad del cascada
            s_count <= 0;
            if s_state = 15 then
                s_state <= 0;
            else
                s_state <= s_state + 1;
            end if;
        end if;
    end if;
end process;

LEDS <= "0000000000000001" when s_state = 15 else
        "0000000000000011" when s_state = 14 else
        "0000000000000111" when s_state = 13 else
        "0000000000001111" when s_state = 12 else
        "0000000000011111" when s_state = 11 else
        "0000000000111111" when s_state = 10 else
        "0000000001111111" when s_state = 9 else
        "0000000011111111" when s_state = 8 else
        "0000000111111111" when s_state = 7 else
        "0000001111111111" when s_state = 6 else
        "0000011111111111" when s_state = 5 else
        "0000111111111111" when s_state = 4 else
        "0001111111111111" when s_state = 3 else
        "0011111111111111" when s_state = 2 else
        "0111111111111111" when s_state = 1 else
        "1111111111111111" when s_state = 0;

end Behavioral;
