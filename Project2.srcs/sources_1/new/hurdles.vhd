----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2018 03:17:44 PM
-- Design Name: 
-- Module Name: hurdles - Behavioral
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


entity hurdles is
    Port ( reset : in STD_LOGIC;
           VS : in STD_LOGIC;
           blank : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0);
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end hurdles;

architecture Behavioral of hurdles is

signal Object_X_pos, Object_X_pos2, Object_X_pos3 : STD_LOGIC_VECTOR(10 downto 0) := B"01001101100"; -- Decimal 620
signal Object_Y_pos : STD_LOGIC_VECTOR(10 downto 0) := B"00011110101"; -- Decimal 245
signal speed : integer := 1;
signal flag : STD_LOGIC := '1';
signal flag2, flag3 : STD_LOGIC := '0';
signal red1, red2, red3 : STD_LOGIC_VECTOR(3 downto 0);
signal green1, green2, green3 : STD_LOGIC_VECTOR(3 downto 0);
signal blue1, blue2, blue3 : STD_LOGIC_VECTOR(3 downto 0);

begin

 process(hcount,vcount,blank)       -- Displaying hurdle 1
 begin
 
   ------------------------------------------------------------------------------
 if (flag = '1') then
 if((((hcount - Object_X_pos) <= 15) and ((Object_X_pos - hcount) >= 15) and -- Lower rectangle
    ((vcount - 35 - Object_Y_pos) <= 2) and ((Object_Y_pos - 35 - vcount) >= 2) and (blank = '0'))
 or (((hcount - 10 - Object_X_pos) <= 5) and ((Object_X_pos - hcount) >= 5) and -- Vertical Bar
    ((vcount - 5 - Object_Y_pos) <= 32) and (blank = '0'))) then
      Red1 <= X"F";
      Green1 <= X"F";
      Blue1 <= X"F";
 else
    Red1 <= X"0";
    Green1 <= X"0";
    Blue1 <= X"0";
  end if; 
  end if;
 
   ------------------------------------------------------------------------------ 
 if (flag2 = '1') then
  if((((hcount - Object_X_pos2) <= 15) and ((Object_X_pos2 - hcount) >= 15) and -- Lower rectangle
     ((vcount - 35 - Object_Y_pos) <= 2) and ((Object_Y_pos - 35 - vcount) >= 2) and (blank = '0'))
  or (((hcount - 10 - Object_X_pos2) <= 5) and ((Object_X_pos2 - hcount) >= 5) and -- Vertical Bar
     ((vcount - 5 - Object_Y_pos) <= 32) and (blank = '0'))) then
       Red2 <= X"F";
       Green2 <= X"F";
       Blue2 <= X"F";
  else
     Red2 <= X"0";
     Green2 <= X"0";
     Blue2 <= X"0";
   end if; 
   end if;
   
   ------------------------------------------------------------------------------  
 if (flag3 = '1') then
   if((((hcount - Object_X_pos3) <= 15) and ((Object_X_pos3 - hcount) >= 15) and -- Lower rectangle
      ((vcount - 35 - Object_Y_pos) <= 2) and ((Object_Y_pos - 35 - vcount) >= 2) and (blank = '0'))
   or (((hcount - 10 - Object_X_pos3) <= 5) and ((Object_X_pos3 - hcount) >= 5) and -- Vertical Bar
      ((vcount - 5 - Object_Y_pos) <= 32) and (blank = '0'))) then
        Red3 <= X"F";
        Green3 <= X"F";
        Blue3 <= X"F";
   else
      Red3 <= X"0";
      Green3 <= X"0";
      Blue3 <= X"0";
    end if;
    end if;   
    
    
    
    

 end process;
 
 -------------------------------------------------------------------------------
 process(VS, reset) -- Moving the hurdles from right to left and back on Vertical sync
 begin
  if(reset = '1') then
     Object_X_pos <= B"01001101100";    -- Decimal 620
     Object_X_pos2 <= B"01001101100";    -- Decimal 620
     Object_X_pos3<= B"01001101100";    -- Decimal 620
     speed <= 1;
      flag <= '1';
      flag2 <= '0';
      flag3 <= '0';
        
  elsif(rising_edge(VS)) then
  ------------------------------------------------------------------------------
  if (flag = '1') then
  if(Object_X_pos  > 20 and Object_X_pos > 200) then        -- Move from R -> L
      Object_X_pos <= Object_X_pos - speed;
   elsif(Object_X_pos <= 200) then             -- Checkpoint 1       
    Object_X_pos <= Object_X_pos - speed;
    flag2 <= '1'; 
  elsif(Object_X_pos <= 20) then             -- Reach extreme LEFT POSITION
      --Object_X_pos <= B"01001101100";        
       Object_X_pos <= Object_X_pos;
       flag <= '0';   
    end if;
  end if;
  
------------------------------------------------------------------------------
  if (flag2 = '1') then
  if(Object_X_pos2  > 20 and Object_X_pos2 > 200) then        -- Move from R -> L
      Object_X_pos2 <= Object_X_pos2 - speed;
   elsif(Object_X_pos2 <= 200) then             -- Checkpoint 2  
   Object_X_pos2 <= Object_X_pos2 - speed;   
   flag3 <= '1';  
  elsif(Object_X_pos2 <= 20) then             -- Reach extreme LEFT POSITION
      Object_X_pos2 <= Object_X_pos2;    
      flag2 <= '0';         
    end if;
  end if;
  
  ------------------------------------------------------------------------------  
  if (flag3 = '1') then
  if(Object_X_pos3  > 20) then        -- Move from R -> L
      Object_X_pos3 <= Object_X_pos3 - speed;
  elsif(Object_X_pos3 <= 20) then             -- Reach extreme LEFT POSITION
      flag <= '1';
      flag2 <= '0';
      flag3 <='0';     
      Object_X_pos <= B"01001101100";    -- Decimal 620
      Object_X_pos2 <= B"01001101100";    -- Decimal 620
      Object_X_pos3<= B"01001101100";    -- Decimal 620   
      speed <= speed + 1; 
    end if;
  end if;
  
  
 
  
  
  end if;
  end process;

Red <= red1 or red2 or red3;
Green <= green1 or green2 or green3;
Blue <= blue1 or blue2 or blue3;


end Behavioral;
