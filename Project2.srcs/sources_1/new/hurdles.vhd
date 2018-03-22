----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 03/08/2018 03:17:44 PM
-- Design Name: Hurry Hurdles
-- Module Name: Hurdles
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component displays and moves the hurdles across the screen. The
-- component also includes keeping track of the round the player is in and how much
-- hurdles the player jumped.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity hurdles is
    Port ( reset : in STD_LOGIC; --Reset button
           VS : in STD_LOGIC; --Vertical sync
           blank : in STD_LOGIC; --Blank
           hcount : in STD_LOGIC_VECTOR (10 downto 0); --Horizontal count
           vcount : in STD_LOGIC_VECTOR (10 downto 0); --Vertical count
           collision: in STD_LOGIC; --Collision flag
           round : out STD_LOGIC_VECTOR(7 downto 0); --Round
           score : out STD_LOGIC_VECTOR(11 downto 0); --Score
           hurdle_X_pos,hurdle_Y_pos : out STD_LOGIC_VECTOR(10 downto 0);
           hurdle2_X_pos,hurdle2_Y_pos : out STD_LOGIC_VECTOR(10 downto 0); --X and Y coordinates of all the hurdles
           hurdle3_X_pos,hurdle3_Y_pos : out STD_LOGIC_VECTOR(10 downto 0);
           Red : out STD_LOGIC_VECTOR (3 downto 0); -- Red value of hurdle
           Green : out STD_LOGIC_VECTOR (3 downto 0); --Green value of hurdle
           Blue : out STD_LOGIC_VECTOR (3 downto 0)); --Blue value of hurdle
end hurdles;

architecture Behavioral of hurdles is

--Signal declaration and instantiation
signal Object_X_pos, Object_X_pos2, Object_X_pos3 : STD_LOGIC_VECTOR(10 downto 0) := B"01001101100"; -- Decimal 620; X position of hurdles
signal Object_Y_pos : STD_LOGIC_VECTOR(10 downto 0) := B"00011110101"; -- Decimal 245; Y position of hurdles
signal tempRound : STD_LOGIC_VECTOR(7 downto 0) := X"01"; --Round
signal speed : integer := 1; --Speed of hurdles
signal flag : STD_LOGIC := '1'; --display flag for hurdle1
signal flag2, flag3 : STD_LOGIC := '0'; --display flag for hurdle1
signal red1, red2, red3 : STD_LOGIC_VECTOR(3 downto 0); --Red value for hurdles
signal green1, green2, green3 : STD_LOGIC_VECTOR(3 downto 0); --White values for hurdles
signal blue1, blue2, blue3 : STD_LOGIC_VECTOR(3 downto 0); --Blue values for hurdles
signal tempScore : STD_LOGIC_VECTOR (11 downto 0) := X"000"; --Score of the game

begin

            --Procss for displaying hurdles
 process(hcount,vcount,blank) 
 begin
                             --Displaying First Hurdle
   ------------------------------------------------------------------------------
  --If first hurdle is allowed to be displayed then print out hurdle
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
                            --Displaying Second Hurdle
   ------------------------------------------------------------------------------ 
  --If second hurdle is allowed to be displayed then print out hurdle
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
                            --Displaying Third Hurdle
   ------------------------------------------------------------------------------  
  --If third hurdle is allowed to be displayed then print out hurdle
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
 
 
                           --Process of Hurdle physics
 -------------------------------------------------------------------------------
 process(VS, reset, collision) -- Moving the hurdles from right to left and back on Vertical sync
 begin
 -- If user pressed the reset button then reset the hurdles, round, score and speed
  if(reset = '1') then
     Object_X_pos <= B"01001101100";    -- Decimal 620
     Object_X_pos2 <= B"01001101100";    -- Decimal 620
     Object_X_pos3<= B"01001101100";    -- Decimal 620
     speed <= 1;
     flag <= '1';
     flag2 <= '0';
     flag3 <= '0';
     tempScore <= X"000";
     tempRound <= X"01";
     
  --If the runner collided onto a hurdle, stop the game by freezing the hurdles  
  elsif (collision = '1') then
    Object_X_pos <= Object_X_pos;
    Object_X_pos2 <= Object_X_pos2;
    Object_X_pos3 <= Object_X_pos3;
        
  elsif(rising_edge(VS)) then
                              --Physics for first hurdle
  ------------------------------------------------------------------------------
  if (flag = '1') then
  if(Object_X_pos  > 20 and Object_X_pos > 200) then        -- Move from R -> L
      Object_X_pos <= Object_X_pos - speed;
   elsif(Object_X_pos > 20 and Object_X_pos <= 200) then             -- Checkpoint 1; Spawn the second hurdle       
    Object_X_pos <= Object_X_pos - speed;
    flag2 <= '1'; 
  elsif(Object_X_pos <= 20) then             -- Reach extreme LEFT POSITION    
       tempScore <= tempScore + 1;
       Object_X_pos <= Object_X_pos;    --Stop the hurdle and stop displaying it     
       flag <= '0';   
    end if;
  end if;
                              --Physics for second hurdle
------------------------------------------------------------------------------
  if (flag2 = '1') then
  if(Object_X_pos2  > 20 and Object_X_pos2 > 200) then        -- Move from R -> L
      Object_X_pos2 <= Object_X_pos2 - speed;
   elsif(Object_X_pos2 > 20 and Object_X_pos2 <= 200) then             -- Checkpoint 2; Spawn the third hurdle
   Object_X_pos2 <= Object_X_pos2 - speed;   
   flag3 <= '1';  
  elsif(Object_X_pos2 <= 20) then             -- Reach extreme LEFT POSITION
      tempScore <= tempScore + 1;
      Object_X_pos2 <= Object_X_pos2;    --Stop the hurdle and stop displaying it
      flag2 <= '0';         
    end if;
  end if;
                             --Physics for third hurdle
  ------------------------------------------------------------------------------  
  if (flag3 = '1') then
  if(Object_X_pos3  > 20) then        -- Move from R -> L
      Object_X_pos3 <= Object_X_pos3 - speed;
  elsif(Object_X_pos3 <= 20) then             -- Reach extreme LEFT POSITION
  
  --Once the last hurdle reaches the end, display hurdle 1 again and increase the speed and round
      flag <= '1';
      flag2 <= '0';
      flag3 <='0';     
      Object_X_pos <= B"01001101100";    -- Decimal 620
      Object_X_pos2 <= B"01001101100";    -- Decimal 620
      Object_X_pos3<= B"01001101100";    -- Decimal 620   
      tempScore <= tempScore + 1;
      speed <= speed + 1; 
      tempRound <= tempRound + 1;
    end if;
  end if;
  
  end if;
  end process;

                    --Set all the output values
---------------------------------------------------------------------------
--OR all the hurdles together to have them display at the same time
Red <= red1 or red2 or red3;
Green <= green1 or green2 or green3;
Blue <= blue1 or blue2 or blue3;
round <= tempRound;
score <= tempScore;
hurdle_X_pos <= Object_X_pos;
hurdle_Y_pos <= Object_Y_pos;
hurdle2_X_pos <= Object_X_pos2;
hurdle2_Y_pos <= Object_Y_pos;
hurdle3_X_pos <= Object_X_pos3;
hurdle3_Y_pos <= Object_Y_pos;

end Behavioral;
