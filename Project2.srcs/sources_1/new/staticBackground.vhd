----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2016 04:30:49 PM
-- Design Name: 
-- Module Name: colorbars - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity staticBackground is
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
      Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end staticBackground;

architecture Behavioral of staticBackground is
begin

--(vcount >= 150) and (vcount < 250) and (hcount >= 310) and (hcount < 410) and blank='0'

                           --Sky
---------------------------------------------------------------------------		
 Blue <= "1111" when (vcount < 30 and blank='0')
               or (vcount >= 30  and vcount < 280 and hcount < 440 and blank='0')
               or (vcount > 200 and vcount < 280 and blank='0')
               or (hcount > 610 and vcount < 280 and blank='0')
               else "0000"; --sun
                        
                           --Ground
---------------------------------------------------------------------------				    

Red <= "1100"  when (vcount >= 300 and vcount < 560 and blank='0') --dirt
                else "1111" when ((vcount >= 30) and (vcount < 200) and (hcount >= 440) and (hcount < 610) and blank='0') --sun
                else "0000";	
                
Green <= "0011" when (vcount >= 300 and vcount < 560 and blank='0') --dirt
                else "1111" when (vcount >= 280 and vcount < 300 and blank='0') --grass
                            or ((vcount >= 30) and (vcount < 200) and (hcount >= 440) and (hcount < 610) and blank='0') --sun
                else "0000";			

-- Red <= "1111"  when (vcount < 80 and blank='0') 
--				or (vcount >=160 and vcount < 240 and blank='0')
--				or (vcount >= 320 and vcount < 400 and blank='0')
--				or (vcount >= 480 and vcount < 560 and blank='0') 
--				else "0000";

-- Green <= "1111" when (vcount >= 80 and vcount < 240 and blank='0')
--				 or (vcount >= 400 and vcount < 560 and blank='0') 
--				 else "0000";
				 
end Behavioral;
