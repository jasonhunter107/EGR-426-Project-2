----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2018 09:14:50 PM
-- Design Name: 
-- Module Name: char_driver - Behavioral
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

entity char_driver is
    Port ( hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           ASCII_CHAR : out STD_LOGIC_VECTOR (6 downto 0));
end char_driver;

architecture Behavioral of char_driver is

signal char_col : std_logic_vector(6 downto 0);
signal char_row : std_logic_vector(5 downto 0);
signal charOut : STD_LOGIC_VECTOR(6 downto 0);
begin
process(hcount) begin
 char_col <= hcount(9 downto 3);  -- Character column in [0,79]
 char_row <= vcount(8 downto 3);  -- Character row in [0,59]
 
  if(char_row="0110010") then --Was 24
     if(char_col="110010") then
        charOut<="0001000";         -- H 
     elsif(char_col="110011") then
        charOut<="0010111";         -- U
     elsif(char_col="110100") then
        charOut<="0010010";         -- R
     elsif(char_col="110101") then
        charOut<="0010010";         -- R
     elsif(char_col="110110") then
        charOut<="0011011";         -- Y
     elsif(char_col="110111") then
        charOut<="0100000";         -- space
     elsif(char_col="111000") then
        charOut<="0001000";         -- H
     elsif(char_col="111001") then
        charOut<="0010111";         -- U
     elsif(char_col="111010") then
        charOut<="0010010";         -- R
     elsif(char_col="111011") then
        charOut<="0000100";         -- D
     elsif(char_col="111100") then
         charOut<="0001100";         -- L
     elsif(char_col="111110") then
         charOut<="0000101";         -- E
     elsif(char_col="111110") then
         charOut<="0010011";         -- S
     elsif(char_col="111111") then
        charOut<="0100000";         -- space       
      else charOut<="0100000";         -- space
      end if;
        
    elsif (char_row="0110100") then --was 40
      if(char_col="110010") then
        charOut<="0010011";         -- s
     elsif(char_col="110011") then
        charOut<="0000011";         -- c
     elsif(char_col="110100") then
        charOut<="0001111";         -- o
     elsif(char_col="110101") then
        charOut<="0010010";         -- r
     elsif(char_col="110110") then
        charOut<="0000101";         -- e
     elsif(char_col="110111") then
        charOut<="0101101";         -- -
     elsif(char_col="111000") then
        charOut<="0110000";         -- num
     elsif(char_col="111001") then
        charOut<="0110000";         -- num
     elsif(char_col="111010") then
        charOut<="0110000";         -- num
     else
        charOut<="0100000";         -- blank
     end if;
     
     
 else
    charOut<="0100000";
 end if;

 ASCII_CHAR <= charOut;
 
 end process;


end Behavioral;
