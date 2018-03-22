----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 02/28/2018 09:17:47 PM
-- Design Name: Hurry Hurdles
-- Module Name: Char_gen
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component generates the rom address for the characters in ROM
-- and prints them to the screen
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;     

entity Char_Gen is
    Port ( clk25 : in STD_LOGIC; --clk 25 MHz
           blank : in STD_LOGIC; --blank
           hcount : in STD_LOGIC_VECTOR (10 downto 0); --hcount 
           vcount : in STD_LOGIC_VECTOR (10 downto 0); --vcount
           ASCII_CHAR : in STD_LOGIC_VECTOR (6 downto 0); --ASCII character in ROM
           Red : out STD_LOGIC_VECTOR (3 downto 0); --R value for character
           Green : out STD_LOGIC_VECTOR (3 downto 0);--G value for character
           Blue : out STD_LOGIC_VECTOR (3 downto 0)); --B value for character
end Char_Gen;

architecture Behavioral of Char_Gen is

--Row and column of the screen
signal pixel_row : STD_LOGIC_VECTOR(2 downto 0);
signal pixel_col : STD_LOGIC_VECTOR(2 downto 0);

--ROM signals
signal ROM_ADDRESS : STD_LOGIC_VECTOR(9 downto 0);
signal ROM_DATA : STD_LOGIC_VECTOR(7 downto 0);
signal INTENSITY : STD_LOGIC;

--Declare the ROM component
COMPONENT rom1kx8
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

begin

--Instantiate the ROM component
my_rom : rom1kx8 PORT MAP (clka => clk25, addra => ROM_ADDRESS, douta => ROM_DATA);

--Assign the row and columm to the 3 LSB of the vertical and horizontal pixels
pixel_row <= vcount(2 downto 0);
pixel_col <= hcount(2 downto 0);

--Generate the ROM address by concatenating the first 7 bits of the ROM char address to the 3 LSB pixel row/column
ROM_ADDRESS <= ASCII_CHAR & pixel_row;

--Wait 3 clock cycles to take the data from ROM
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

--Generate the Red value of the character
Red <= (INTENSITY & INTENSITY & INTENSITY & INTENSITY) when (blank = '0') else X"0";

--Generate the Green Value of the character
Green <= (INTENSITY & INTENSITY & INTENSITY & INTENSITY) when (blank = '0') else X"0";

--Generate the Blue value of the character
Blue <= (INTENSITY & INTENSITY & INTENSITY & INTENSITY) when (blank = '0') else X"0";
 

end Behavioral;
