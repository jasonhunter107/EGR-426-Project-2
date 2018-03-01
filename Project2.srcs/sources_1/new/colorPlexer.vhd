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
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0);
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end colorPlexer;

architecture Behavioral of colorPlexer is



begin


end Behavioral;
