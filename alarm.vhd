library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alarm is
	port(
		AP : in std_logic;
		ALARM_SET : in std_logic;
		ALARMED : in std_logic;
		CLOCK : in std_logic;
		HR_TENS, HRS_ONES, MIN_TENS, MIN_ONES : in std_logic_vector(3 downto 0);
		ALARM_HR, ALARM_MIN, ALARM_AP : in std_logic_vector(7 downto 0);
		ALARM : out std_logic
	);
end alarm;

architecture a of alarm is
    signal alarm_hr_tens : std_logic_vector(3 downto 0);
    signal alarm_hr_ones : std_logic_vector(3 downto 0);
    signal alarm_min_tens : std_logic_vector(3 downto 0);
    signal alarm_min_ones : std_logic_vector(3 downto 0);
    signal alarm_ap_time : std_logic;
	 signal alarm_setted : std_logic := '0';
begin	 
	process(CLOCK)
	begin

		if rising_edge(CLOCK) then
			if (ALARM_SET = '1' and alarm_setted = '0') then
					alarm_setted <= '1';
			end if;
			if alarm_setted = '0' then
				alarm_hr_tens <= "0001";
				alarm_hr_ones <= "0001";
				alarm_min_tens <= "0001";
				alarm_min_ones <= "0011";
				alarm_ap_time <= '0';
			elsif(alarm_setted = '1') then
				alarm_hr_tens <= ALARM_HR(7 downto 4);
				alarm_hr_ones <= ALARM_HR(3 downto 0);
				alarm_min_tens <= ALARM_MIN(7 downto 4);
				alarm_min_ones <= ALARM_MIN(3 downto 0);
				alarm_ap_time <= ALARM_AP(0);
			end if;
	
			if (HR_TENS = alarm_hr_tens) and (HRS_ONES = alarm_hr_ones) and (MIN_TENS = alarm_min_tens) and (MIN_ONES = alarm_min_ones) and (AP = alarm_ap_time) and ALARMED = '1' then
				 ALARM <= '1';
			else
				 ALARM <= '0';
			end if;
		end if;
	end process;
end a;