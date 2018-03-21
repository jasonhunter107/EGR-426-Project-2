----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2018 09:59:55 PM
-- Design Name: 
-- Module Name: colorPlexer - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity colorPlexer is
    Port ( Red_bgnd : in STD_LOGIC_VECTOR (3 downto 0);
           Green_bgnd : in STD_LOGIC_VECTOR (3 downto 0);
           Blue_bgnd : in STD_LOGIC_VECTOR (3 downto 0);
           Red_char : in STD_LOGIC_VECTOR (3 downto 0);
           Green_char : in STD_LOGIC_VECTOR (3 downto 0);
           Blue_char : in STD_LOGIC_VECTOR (3 downto 0);
           Red_hurd : in STD_LOGIC_VECTOR (3 downto 0);
           Green_hurd : in STD_LOGIC_VECTOR (3 downto 0);
           Blue_hurd : in STD_LOGIC_VECTOR (3 downto 0);
           Red_run : in STD_LOGIC_VECTOR (3 downto 0);
           Green_run : in STD_LOGIC_VECTOR (3 downto 0);
           Blue_run: in STD_LOGIC_VECTOR (3 downto 0);
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0);
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
         --colision : out STD_LOGIC;  
end colorPlexer;

architecture Behavioral of colorPlexer is

signal collisionFlag : STD_LOGIC := '0';

begin

Red <= Red_char or Red_bgnd or Red_hurd or Red_run;

 
Green <= Green_char or Green_bgnd  or Green_hurd or Green_run;

 
Blue <= Blue_char or Blue_bgnd or Blue_hurd or Blue_run;




end Behavioral;
