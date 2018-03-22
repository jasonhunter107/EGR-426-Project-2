----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 03/19/2018 04:47:11 PM
-- Design Name: Hurry Hurdles
-- Module Name: Speed_Controller
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component handles the speed of the runner. As the round
--- increases, the speed of the runner increases also.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Speed_Controller is
    Port ( round : in STD_LOGIC_VECTOR (7 downto 0); --Round of current game
           speed : out STD_LOGIC_VECTOR (3 downto 0)); --Speed of character
end Speed_Controller;

architecture Behavioral of Speed_Controller is

--temp speed
signal tempSpeed : STD_LOGIC_VECTOR (3 downto 0);

begin

--As the round increase, increase the runner's speed
process (round) 
begin
    case (round) is
    when X"01" => tempSpeed <= "0001"; --Round 1 Set runner speed to 1
    when X"02" => tempSpeed <= "0010"; --Round 2 Set runner speed to 2
    when X"03" => tempSpeed <= "0100"; --Round 3 Set runner speed to 4    
    when X"04" => tempSpeed <= "0110"; --Round 4 Set runner speed to 6 
    when others => tempSpeed <= "1000"; --Round 5 and above Set runner speed to 10
    
    end case;

end process;

--Set output speed
speed <= tempSpeed;

end Behavioral;
