library ieee;
use ieee.std_logic_1164.all;

entity Signal_Change_Detector is
    port (
        Input_Signal : in std_logic;
        Clock : in std_logic;
        Output_Signal : out std_logic
    );
end Signal_Change_Detector;

architecture a of Signal_Change_Detector is
    signal prev_signal : std_logic := '0';
    signal pulse_flag : std_logic := '0';
    signal counter : std_logic := '0';
begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            if pulse_flag = '1' then
                if counter = '0' then
                    Output_Signal <= '1';
                elsif counter = '1' then
                    Output_Signal <= '0';
                    pulse_flag <= '0';
                end if;
                counter <= not counter;
            else
                Output_Signal <= '0';
            end if;
            
            if Input_Signal /= prev_signal then
                pulse_flag <= '1';
            end if;
            prev_signal <= Input_Signal;
        end if;
    end process;
end a;
