----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2018 06:06:33 PM
-- Design Name: 
-- Module Name: Collision_Detection - Behavioral
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

entity Collision_Detection is
  Port (
            hurdle_X_pos,hurdle_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            hurdle2_X_pos,hurdle2_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            hurdle3_X_pos,hurdle3_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            runner_X_pos,runner_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            reset : in STD_LOGIC;
            collision_detected : out STD_LOGIC
        );
end Collision_Detection;

architecture Behavioral of Collision_Detection is

-- Signals --
signal collision_local : STD_LOGIC := '0';

-- Hurdle and runner dimension --
constant HURDLE_WIDTH : INTEGER := 15;
constant HURDLE_HEIGHT : INTEGER := 37;
constant RUNNER_WIDTH : INTEGER := 35;
constant RUNNER_HEIGHT : INTEGER := 50;

begin

    collision_detected <= collision_local;

    -- Check for collisions and set flag  if any detected
    process(hurdle_X_pos, hurdle2_X_pos, hurdle3_X_pos, runner_Y_pos, reset)
    begin
        -- Check for reset
        if(reset = '1') then
            collision_local <= '0';
            
        -- Check for collision between runner and hurdle 1
        elsif((hurdle_Y_pos + HURDLE_HEIGHT >= runner_Y_pos) and   -- Bottom NPC edge > user top edge
          (hurdle_Y_pos <= runner_Y_pos + RUNNER_HEIGHT) and  -- Top NPC edge < user bottom edge
          (hurdle_X_pos + HURDLE_WIDTH >= runner_X_pos) and    -- Right NPC edge > user left edge
          (hurdle_X_pos <= runner_X_pos + RUNNER_WIDTH))       -- Left NPC edge < user right edge
        
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
            collision_local <= '1';
            
        -- if no collision or reset detected, save current state
        else
            collision_local <= collision_local;
        end if;
    end process;

end Behavioral;