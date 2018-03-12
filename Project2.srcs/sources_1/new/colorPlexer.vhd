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
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0);
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end colorPlexer;

architecture Behavioral of colorPlexer is
begin

Red <= Red_bgnd or Red_char or Red_hurd;
-- Red(3) <= Red_bgnd(3) or Red_char(3);
-- Red(2) <= Red_bgnd(2) or Red_char(2);
-- Red(1) <= Red_bgnd(1) or Red_char(1);
-- Red(0) <= Red_bgnd(0) or Red_char(0);
 
Green <= Green_bgnd or Green_char or Green_hurd;
-- Green(3) <= Green_bgnd(3) or Green_char(3);
-- Green(2) <= Green_bgnd(2) or Green_char(2);
-- Green(1) <= Green_bgnd(1) or Green_char(1);
-- Green(0) <= Green_bgnd(0) or Green_char(0);
 
Blue <= Blue_bgnd or Blue_char or Blue_hurd;
-- Blue(3) <= Blue_bgnd(3) or Blue_char(3);
-- Blue(2) <= Blue_bgnd(2) or Blue_char(2);
-- Blue(1) <= Blue_bgnd(1) or Blue_char(1);
-- Blue(0) <= Blue_bgnd(0) or Blue_char(0);



end Behavioral;
