----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 01/31/2016 04:30:49 PM
-- Design Name: Hurry Hurdles
-- Module Name: staticBackground
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component creates the background of the game. The background 
-- includes the sun, sky, ground, dirt and dirt.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 


entity staticBackground is
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC; --hcount, vcount, and blank
      Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0)); --RGB values of the background
end staticBackground;


architecture Behavioral of staticBackground is

begin

--No blue is used for the background
Blue <= "0000"; 
                      
                      --Assign the Red values of the background  		    
-----------------------------------------------------------------------------------
Red <= "0100"   when (vcount >= 300 and vcount < 560 and blank='0') --dirt

                else "1111" when  (vcount < 30 and blank='0') --top of sky
                or (vcount >= 30  and vcount < 280 and hcount <= 640 and blank='0') --sky           
   
                else "1100" when (vcount >= 280 and vcount < 300 and blank='0') --grass
                   
                else "0000";	
                     
                     --Assign the Green values of the background
 ---------------------------------------------------------------------------------------------               
Green <= "0011" when (vcount >= 280 and vcount < 300 and blank='0') --grass
                else "0010" when (vcount >= 300 and vcount < 560 and blank='0') --dirt
                
                else "1111"
                when ((vcount >= 30) and (vcount < 54) and (hcount >= 470) and (hcount < 580) and blank='0') --sun 
                or ((vcount >= 54) and (vcount < 78) and (hcount >= 460) and (hcount < 590) and blank='0') --sun 
                or ((vcount >= 78) and (vcount < 102) and (hcount >= 450) and (hcount < 600) and blank='0') --sun 
                or ((vcount >= 102) and (vcount < 126) and (hcount >= 440) and (hcount < 610) and blank='0') --sun 
                or ((vcount >= 126) and (vcount < 150) and (hcount >= 450) and (hcount < 600) and blank='0') --sun 
                or ((vcount >= 150) and (vcount < 174) and (hcount >= 460) and (hcount < 590) and blank='0') --sun 
                or ((vcount >= 174) and (vcount < 198) and (hcount >= 470) and (hcount < 580) and blank='0') --sun 
                
                else "0111"
                when  (vcount < 30 and blank='0') --top of sky
                or (vcount >= 30  and vcount < 280 and hcount <= 640 and blank='0') --sky
                
                
                else "0000";			
				 
end Behavioral;
