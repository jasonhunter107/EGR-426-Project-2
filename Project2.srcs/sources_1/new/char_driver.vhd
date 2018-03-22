----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 02/28/2018 09:14:50 PM
-- Design Name: Hurry Hurdles
-- Module Name: char_driver
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component will assign the 7-bit ASCII character value from ROM.
-- It will find the character that will need to be printed on the screen in ROM and 
-- get its address
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity char_driver is
    Port ( hcount : in STD_LOGIC_VECTOR (10 downto 0); --hcount
           vcount : in STD_LOGIC_VECTOR (10 downto 0); --vcount
           reset: in STD_LOGIC; --reset button
           score : in STD_LOGIC_VECTOR(11 downto 0); --score of game
           round : in STD_LOGIC_VECTOR(7 downto 0); --round of game
           ASCII_CHAR : out STD_LOGIC_VECTOR (6 downto 0)); --ASCII Character in ROM
end char_driver;

architecture Behavioral of char_driver is

--Declaring signals
signal char_col : std_logic_vector(6 downto 0);
signal char_row : std_logic_vector(5 downto 0);
signal charOut : STD_LOGIC_VECTOR(6 downto 0);


begin

                --Process to generate ROM address
-------------------------------------------------------------------
process(hcount, score, round)
--Score numbers
variable tempOnes, tempTens, tempHundreds : Integer;
variable ones, tens, hundreds : STD_LOGIC_VECTOR(11 downto 0);

--Round numbers
variable tempRoundOnes, tempRoundTens, tempRoundHundreds : Integer;
variable roundOnes, roundTens, roundHundreds : STD_LOGIC_VECTOR(11 downto 0);

begin
 char_col <= hcount(9 downto 3);  -- Character column in [0,79]
 char_row <= vcount(8 downto 3);  -- Character row in [0,59]
 
  --Getting the hundreds, tens, and ones place of score
 ----------------------------------------------------------
 tempOnes := to_integer(unsigned(score)) mod 10;
 tempTens := (to_integer(unsigned(score)) / 10) mod 10;
 tempHundreds := to_integer(unsigned(score)) / 100;
 
 --One the ones, tens, and hundreds place is extracted from the score then
 -- add them to the score ASCII character address
 ones := std_logic_vector(to_unsigned(tempOnes,ones'length));
 tens := std_logic_vector(to_unsigned(tempTens,tens'length));
 hundreds := std_logic_vector(to_unsigned(tempHundreds,hundreds'length));
 
   --Getting the hundreds, tens, and ones place of round
----------------------------------------------------------
tempRoundOnes := to_integer(unsigned(round)) mod 10;
tempRoundTens := (to_integer(unsigned(round)) / 10) mod 10;
tempRoundHundreds := to_integer(unsigned(round)) / 100;

 --One the ones, tens, and hundreds place is extracted from the round then
 -- add them to the score ASCII character address
roundOnes := std_logic_vector(to_unsigned(tempRoundOnes,ones'length));
roundTens := std_logic_vector(to_unsigned(tempRoundTens,tens'length));
roundHundreds := std_logic_vector(to_unsigned(tempRoundHundreds,hundreds'length));

--Start at the y coordinate of 24 (Top left hand of screen)
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
         charOut<= roundHundreds (6 downto 0) + "0001000";     -- num
      elsif(char_col="0001010") then
         charOut<= roundTens (6 downto 0) + "0001000";         -- num
      elsif(char_col="0001011") then
         charOut<= roundOnes (6 downto 0) + "0001000";         -- num; print out round number accordingly
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
       charOut<= hundreds (6 downto 0) + "0001000";     -- num
    elsif(char_col="0001010") then
       charOut<= tens (6 downto 0) + "0001000";         -- num
    elsif(char_col="0001011") then
       charOut<= ones(6 downto 0) + "0001000";         -- num; print out score number accordingly
    else
       charOut<="0010100";         -- blank
    end if;
    
else
   charOut<="0010100";
end if;

--Assign the ASCII character address to output
 ASCII_CHAR <= charOut;
 
 end process;


end Behavioral;