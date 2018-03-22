----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 03/21/2018 06:06:33 PM
-- Design Name: Hurry Hurdles
-- Module Name: Collision_Detection
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component handles the collision detection mechanic of the game
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Collision_Detection is
  Port (
            hurdle_X_pos,hurdle_Y_pos : in STD_LOGIC_VECTOR(10 downto 0); --Hurdle1 coordinates
            hurdle2_X_pos,hurdle2_Y_pos : in STD_LOGIC_VECTOR(10 downto 0); --Hurdle2 coordinates
            hurdle3_X_pos,hurdle3_Y_pos : in STD_LOGIC_VECTOR(10 downto 0); --Hurdle3 coordinates
            runner_X_pos,runner_Y_pos : in STD_LOGIC_VECTOR(10 downto 0); --Runner coordinates
            reset : in STD_LOGIC; --Reset button
            collision : out STD_LOGIC --Collision flag
        );
end Collision_Detection;

architecture Behavioral of Collision_Detection is

-- Collision flag --
signal tempCollision : STD_LOGIC := '0';

-- Hurdle and runner dimension --
constant HURDLE_WIDTH : INTEGER := 15;
constant HURDLE_HEIGHT : INTEGER := 37;
constant RUNNER_WIDTH : INTEGER := 35;
constant RUNNER_HEIGHT : INTEGER := 50;

begin
    -- Check for collisions and set collision flag if detected
    process(hurdle_X_pos, hurdle2_X_pos, hurdle3_X_pos, runner_Y_pos, reset)
    begin
        -- Check if user pressed reset
        if(reset = '1') then
            tempCollision <= '0';
            
        -- Check for collision between runner and hurdle 1
        elsif((hurdle_Y_pos + HURDLE_HEIGHT >= runner_Y_pos) and   -- Bottom of hurdle is near runner's bottom edge
          (hurdle_Y_pos <= runner_Y_pos + RUNNER_HEIGHT) and  -- Top of hurdle touch the runner
          (hurdle_X_pos + HURDLE_WIDTH >= runner_X_pos) and    -- Right of hurdle touching the runner
          (hurdle_X_pos <= runner_X_pos + RUNNER_WIDTH))       -- Left of hurdle touching the runner 
        
        -- Check for collision between runner and hurdle 2
        or((hurdle2_Y_pos + HURDLE_HEIGHT >= runner_Y_pos) and
          (hurdle2_Y_pos <= runner_Y_pos + RUNNER_HEIGHT) and
          (hurdle2_X_pos + HURDLE_WIDTH >= runner_X_pos) and
          (hurdle2_X_pos <= runner_X_pos + RUNNER_WIDTH))
        
        -- Check for collision between runner and hurdle 3
        or((hurdle3_Y_pos + HURDLE_HEIGHT >= runner_Y_pos) and
          (hurdle3_Y_pos <= runner_Y_pos + RUNNER_HEIGHT) and
          (hurdle3_X_pos + HURDLE_WIDTH >= runner_X_pos) and
          (hurdle3_X_pos <= runner_X_pos + RUNNER_WIDTH))
       
        then
            tempCollision <= '1';
            
        -- Save current state if no collision was detected
        else
            tempCollision <= tempCollision;
        end if;
    end process;

  --Set output of collision flag
  collision <= tempCollision;
    
end Behavioral;