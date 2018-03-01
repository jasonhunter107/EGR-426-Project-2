----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2018 09:17:47 PM
-- Design Name: 
-- Module Name: Char_Gen - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;       -- For unsigned()

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Char_Gen is
    Port ( clk25 : in STD_LOGIC;
           blank : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           ASCII_CHAR : in STD_LOGIC_VECTOR (6 downto 0));
--           Red : out STD_LOGIC_VECTOR (3 downto 0);
--           Green : out STD_LOGIC_VECTOR (3 downto 0);
--           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end Char_Gen;

architecture Behavioral of Char_Gen is

signal pixel_row : STD_LOGIC_VECTOR(2 downto 0);
signal pixel_col : STD_LOGIC_VECTOR(2 downto 0);

signal ROM_ADDRESS : STD_LOGIC_VECTOR(9 downto 0);
signal ROM_DATA : STD_LOGIC_VECTOR(7 downto 0);
signal INTENSITY : STD_LOGIC;

COMPONENT rom1kx8
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

begin
my_rom : rom1kx8 PORT MAP (clka => clk25, addra => ROM_ADDRESS, douta => ROM_DATA);

pixel_row <= vcount(2 downto 0);
pixel_col <= hcount(2 downto 0);
ROM_ADDRESS <= ASCII_CHAR & pixel_row;  -- Generating ROM address

 process(clk25)
  variable col1,col2,col3 : NATURAL range 0 to 7;
  begin
   if rising_edge(clk25) then
	  col3 := col2;
	  col2 := col1;
	  col1 := conv_integer(pixel_col);
	  INTENSITY <= ROM_DATA(col3);
   end if;
 end process;

--Red <= (others => INTENSITY) when blank='0';

--Green <= (others => INTENSITY) when blank='0';

--Blue <= (others => INTENSITY) when blank='0';
 



end Behavioral;