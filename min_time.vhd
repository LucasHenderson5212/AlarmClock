library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity min_time is
	port(
		MIN_CLK : in std_logic;
		SET : in std_logic;
		MinTensDigitSet, MinOnesDigitSet : in std_logic_vector(3 downto 0);
		ALARM : in std_logic;
		CLOCK : in std_logic;
		MinTensDigitOut, MinOnesDigitOut : out std_logic_vector(3 downto 0);
		HR_CLK : out std_logic
	);
end min_time;

architecture a of min_time is
	signal min_flag : std_logic;
	signal hr_flag : std_logic;
	signal MinOnesDigit : std_logic_vector(3 downto 0);
	signal MinTensDigit : std_logic_vector(3 downto 0);
	signal IsStartup : std_logic_vector(3 downto 0) := "0000";
begin
	
    process(MIN_CLK, SET, CLOCK)
    begin
		  if IsStartup<14 then
            MinOnesDigit <= "0101"; -- Set MinOnesDigit to "0001" at power-on
				MinTensDigit <= "0010";
            IsStartup <= IsStartup+1; -- Set IsStartup to indicate power-on initialization done
        elsif(SET='0' and ALARM='0') then -- reset
             MinOnesDigit<=MinOnesDigitSet;
             MinTensDigit<=MinTensDigitSet;
        elsif(MIN_CLK'event and MIN_CLK='1') then
            if (MinOnesDigit=9) then
                MinOnesDigit<="0000";
                if (MinTensDigit=5) then
                    MinTensDigit<="0000";
                    hr_flag <= not hr_flag;
                else MinTensDigit<=MinTensDigit+'1';
                end if;
            else
                MinOnesDigit<=MinOnesDigit+'1';
            end if;
        end if;
		  HR_CLK <= hr_flag;
		  MinOnesDigitOut <= MinOnesDigit;
		  MinTensDigitOut <= MinTensDigit;
    end process;
end a;