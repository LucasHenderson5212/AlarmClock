library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ap_time is
	port(
		AP_CLK : in std_logic;
		SET : in std_logic;
		AP_SET : in std_logic_vector(0 downto 0);
		ALARM : in std_logic;
		CLOCK : in std_logic;
		AP : out std_logic
	);
end ap_time;

architecture a of ap_time is
	signal ap_time : std_logic;
	signal IsStartup : std_logic_vector(3 downto 0) := "0000";
begin
	
	process(AP_CLK, SET, CLOCK)
	begin
		if IsStartup<14 then
			ap_time <= '0';
			IsStartup <= IsStartup+1;
		elsif(SET='0' and ALARM='0') then -- reset
			ap_time <= AP_SET(0);
		elsif(AP_CLK'event and AP_CLK='1') then
			ap_time <= not ap_time;
		end if;
		AP <= ap_time;
	end process;
end a;