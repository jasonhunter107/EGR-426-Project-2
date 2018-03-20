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
 
  if(char_row="000011") then 
    if(char_col="0000011") then
       charOut<="0000000";         -- H 
    elsif(char_col="0000100") then
       charOut<="0000001";         -- U
    elsif(char_col="0000101") then
       charOut<="0000010";         -- R
    elsif(char_col="0000110") then
       charOut<="0000010";         -- R
    elsif(char_col="0000111") then
       charOut<="0000011";         -- Y
    elsif(char_col="0001000") then
       charOut<="0010100";         -- space
    elsif(char_col="0001001") then
       charOut<="0000000";         -- H
    elsif(char_col="0001010") then
       charOut<="0000001";         -- U
    elsif(char_col="0001011") then
       charOut<="0000010";         -- R
    elsif(char_col="0001100") then
       charOut<="0000100";         -- D
    elsif(char_col="0001101") then
        charOut<="0000101";         -- L
    elsif(char_col="0001110") then
        charOut<="0000110";         -- E
    elsif(char_col="0001111") then
        charOut<="0000111";         -- S
    elsif(char_col="0010000") then
       charOut<="0010100";         -- space       
     else charOut<="0010100";         -- space
     end if;
     
     --New line   
    elsif (char_row="000101") then 
      if(char_col="0000011") then
         charOut<="0000010";         -- R
      elsif(char_col="0000100") then
         charOut<="0010011";         -- o
      elsif(char_col="0000101") then
         charOut<="0000001";         -- u
      elsif(char_col="0000110") then
         charOut<="0010110";         -- n
      elsif(char_col="0000111") then
         charOut<="0000100";         -- d
      elsif(char_col="0001000") then
         charOut<="0010101";         -- -
      elsif(char_col="0001001") then
         charOut<="0001000";         -- num
      elsif(char_col="0001010") then
         charOut<="0001000";         -- num
      elsif(char_col="0001011") then
         charOut<="0001000";         -- num
      else
         charOut<="0010100";         -- blank
      end if;
       
    --New line   
   elsif (char_row="000111") then 
     if(char_col="0000011") then
       charOut<="0000111";         -- s
    elsif(char_col="0000100") then
       charOut<="0010010";         -- c
    elsif(char_col="0000101") then
       charOut<="0010011";         -- o
    elsif(char_col="0000110") then
       charOut<="0000010";         -- r
    elsif(char_col="0000111") then
       charOut<="0000110";         -- e
    elsif(char_col="0001000") then
       charOut<="0010101";         -- -
    elsif(char_col="0001001") then
       charOut<="0001000";         -- num
    elsif(char_col="0001010") then
       charOut<="0001000";         -- num
    elsif(char_col="0001011") then
       charOut<="0001000";         -- num
    else
       charOut<="0010100";         -- blank
    end if;
    
    
else
   charOut<="0010100";
end if;

 ASCII_CHAR <= charOut;
 
 end process;


end Behavioral;
