library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hr_time is
	port(
		HR_CLK : in std_logic;
		SET : in std_logic;
		HrTensDigitSet, HrOnesDigitSet : in std_logic_vector(3 downto 0);
		ALARM : in std_logic;
		HrTensDigitOut, HrOnesDigitOut : out std_logic_vector(3 downto 0);
		AP_CLK : out std_logic
	);
end hr_time;

architecture a of hr_time is
	signal ap_flag : std_logic;
	signal HrOnesDigit : std_logic_vector(3 downto 0) := "0001";
	signal HrTensDigit : std_logic_vector(3 downto 0) := "0001";
	signal IsStartup : std_logic_vector(3 downto 0) := "0000";
begin

    process(HR_CLK, SET)
    begin
			if IsStartup<14 then
            HrOnesDigit <= "0001";
				HrTensDigit <= "0001";
            IsStartup <= IsStartup+1;
        elsif(SET='0' and ALARM='0') then -- reset
             HrOnesDigit<=HrOnesDigitSet;
             HrTensDigit<=HrTensDigitSet;
        elsif(HR_CLK'event and HR_CLK='1') then
            if (HrOnesDigit=9) then
                HrOnesDigit<="0000";
					 if (HrTensDigit=1) then
						  HrTensDigit<="0000";
						  
					 else HrTensDigit<=HrTensDigit+'1';
					 end if;
            else
                HrOnesDigit<=HrOnesDigit+'1';
            end if;
				if HrOnesDigit=1 and HrTensDigit = 1 then
					ap_flag <= not ap_flag;
				end if;
				if HrOnesDigit=2 and HrTensDigit = 1 then
					HrTensDigit<="0000";
					HrOnesDigit<="0001";
				end if;
				
        end if;
		  AP_CLK <= ap_flag;
		  HrOnesDigitOut <= HrOnesDigit;
		  HrTensDigitOut <= HrTensDigit;
    end process;
end a;