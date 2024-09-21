library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity min_clock is
	port(
		SEC_CLK : in std_logic;
		SET : in std_logic;
		SecTensDigitSet, SecOnesDigitSet : in std_logic_vector(3 downto 0);
		ALARM : in std_logic;
		CLOCK : in std_logic;
		SecTensDigitOut, SecOnesDigitOut : out std_logic_vector(3 downto 0);
		MIN_CLK : out std_logic
	);
end min_clock;

architecture a of min_clock is
	signal sec_flag : std_logic;
	signal min_flag : std_logic;
	signal SecOnesDigit : std_logic_vector(3 downto 0);
	signal SecTensDigit : std_logic_vector(3 downto 0);
	signal IsStartup : std_logic_vector(3 downto 0) := "0000";
begin

    process(SEC_CLK, SET, CLOCK)
    begin
			if IsStartup<14 then
            SecOnesDigit <= "0011"; -- Set MinOnesDigit to "0001" at power-on
				SecTensDigit <= "0001";
            IsStartup <= IsStartup+1; -- Set IsStartup to indicate power-on initialization done
        elsif(SET='0' and ALARM='0') then -- reset
             SecOnesDigit<=SecOnesDigitSet;
             SecTensDigit<=SecTensDigitSet;
        elsif(SEC_CLK'event and SEC_CLK='1') then
            if (SecOnesDigit=9) then
                SecOnesDigit<="0000";
                if (SecTensDigit=5) then
                    SecTensDigit<="0000";
                    min_flag <= not min_flag;
                else SecTensDigit<=SecTensDigit+'1';
                end if;
            else
                SecOnesDigit<=SecOnesDigit+'1';
            end if;
		  
        end if;
        MIN_CLK <= min_flag;
		  SecOnesDigitOut <= SecOnesDigit;
		  SecTensDigitOut <= SecTensDigit;
    end process;
end a;