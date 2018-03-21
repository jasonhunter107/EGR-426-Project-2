----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2018 04:47:11 PM
-- Design Name: 
-- Module Name: Speed_Controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Speed_Controller is
    Port ( round : in STD_LOGIC_VECTOR (7 downto 0);
           speed : out STD_LOGIC_VECTOR (3 downto 0));
end Speed_Controller;

architecture Behavioral of Speed_Controller is

signal tempSpeed : STD_LOGIC_VECTOR (3 downto 0);

begin

process (round) --Round 4 is when current jumping speed (+- 10) is usable
begin
    case (round) is
    when X"00" => tempSpeed <= "0001"; --Round 1 Set runner speed to 1
    when X"01" => tempSpeed <= "0011"; --Round 2 Set runner speed to 3
    when X"02" => tempSpeed <= "0101"; --Round 3 Set runner speed to 5
    when X"03" => tempSpeed <= "1010"; --Round 4 Set runner speed to 10
    when others => tempSpeed <= "1010"; --Round 5 and above Set runner speed to 10
    
    end case;

end process;

speed <= tempSpeed;
end Behavioral;
