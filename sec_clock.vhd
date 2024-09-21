library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sec_clock is
	port(
		CLK_50 : in std_logic;
		SEC_CLK : out std_logic
	);
end sec_clock;

architecture a of sec_clock is
   signal internal_count: std_logic_vector(28 downto 0);
	signal clk_flag: std_logic;
begin

    process(CLK_50)
    begin
        if(CLK_50'event and CLK_50 = '1') then
            if internal_count<25000000 then
                internal_count <= internal_count + 1;
            else
                internal_count <= (others => '0');
                clk_flag <= not clk_flag;
					 SEC_CLK <= clk_flag;
            end if;
        end if;
    end process;
end a;