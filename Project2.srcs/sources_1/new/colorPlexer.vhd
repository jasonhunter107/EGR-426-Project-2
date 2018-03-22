----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 02/28/2018 09:59:55 PM
-- Design Name: Hurry Hurdles
-- Module Name: colorPlexer
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component merges all the visual components onto the display.
-- this includes the sun, sky, ground, dirt, runner, text, and the hurdles.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity colorPlexer is
    Port ( Red_bgnd : in STD_LOGIC_VECTOR (3 downto 0);
           Green_bgnd : in STD_LOGIC_VECTOR (3 downto 0); --RGB values for background
           Blue_bgnd : in STD_LOGIC_VECTOR (3 downto 0);
           Red_char : in STD_LOGIC_VECTOR (3 downto 0);
           Green_char : in STD_LOGIC_VECTOR (3 downto 0); --RGB values for characters
           Blue_char : in STD_LOGIC_VECTOR (3 downto 0);
           Red_hurd : in STD_LOGIC_VECTOR (3 downto 0);
           Green_hurd : in STD_LOGIC_VECTOR (3 downto 0); --RGB values for the hurdles
           Blue_hurd : in STD_LOGIC_VECTOR (3 downto 0);
           Red_run : in STD_LOGIC_VECTOR (3 downto 0);
           Green_run : in STD_LOGIC_VECTOR (3 downto 0); --RGB values for the runner
           Blue_run: in STD_LOGIC_VECTOR (3 downto 0);
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0); --RGB values that is loaded onto the board
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end colorPlexer;

architecture Behavioral of colorPlexer is

begin

--All the Red values for the visual components were OR'd to switch between them
Red <= Red_char or Red_bgnd or Red_hurd or Red_run;

--All the Green values for the visual components were OR'd to switch between them
Green <= Green_char or Green_bgnd  or Green_hurd or Green_run;

--All the Blue values for the visual components were OR'd to switch between them
Blue <= Blue_char or Blue_bgnd or Blue_hurd or Blue_run;




end Behavioral;
