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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity char_driver is
    Port ( hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           reset: in STD_LOGIC;
           score : in STD_LOGIC_VECTOR(11 downto 0);
           round : in STD_LOGIC_VECTOR(7 downto 0);
           ASCII_CHAR : out STD_LOGIC_VECTOR (6 downto 0));
end char_driver;

architecture Behavioral of char_driver is

signal char_col : std_logic_vector(6 downto 0);
signal char_row : std_logic_vector(5 downto 0);
signal charOut : STD_LOGIC_VECTOR(6 downto 0);
--signal ones, tens, hundreds : STD_LOGIC_VECTOR(6 downto 0) := "0000000";
signal roundOnes, roundTens, roundHundreds :  STD_LOGIC_VECTOR(6 downto 0) := "0000000";
--variable ones, tens, hundreds : unsigned(6 downto 0);
begin

--                        --Process to update score
---------------------------------------------------------------------
--process (score) 
--begin
--if ( to_integer(unsigned(score)) mod 10 = 0) then
--tens <= tens + 1;
--ones <= "0000000";

--elsif ( to_integer(unsigned(score)) mod 100 = 0) then
--hundreds <= hundreds + 1;
--tens <= "0000000";
--ones <= "0000000";

--else 
--ones <= ones + 1;
--end if;
--end process;

--                        --Process to update round
---------------------------------------------------------------------
--process (round) 
--begin
--if ( unsigned(round) mod 10 = X"0000") then
--roundTens <= roundTens + 1;
--roundOnes <= "0000000";

--elsif ( unsigned(round) mod 100 = X"0000") then
--roundHundreds <= roundHundreds + 1;
--roundTens <= "0000000";
--roundOnes <= "0000000";

--else 
--roundOnes <= roundOnes + 1;
--end if;
--end process;

                        --Process to generate ROM address
-------------------------------------------------------------------
process(hcount, score)
variable ones, tens, hundreds : unsigned(6 downto 0);

begin
 char_col <= hcount(9 downto 3);  -- Character column in [0,79]
 char_row <= vcount(8 downto 3);  -- Character row in [0,59]
 ones := unsigned(score (6 downto 0)) mod 10;
 tens := unsigned(score (6 downto 0)) mod 100;
 hundreds := unsigned(score (6 downto 0)) mod 1000;
 
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
         charOut<= roundHundreds + "0001000";         -- num
      elsif(char_col="0001010") then
         charOut<= roundTens + "0001000";         -- num
      elsif(char_col="0001011") then
         charOut<= round (6 downto 0) + "0001001";         -- num
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
       charOut<= std_logic_vector(hundreds) + "0001000";     -- num
    elsif(char_col="0001010") then
       charOut<= std_logic_vector(tens) + "0001000";         -- num
    elsif(char_col="0001011") then
       charOut<= std_logic_vector(ones) + "0001000";         -- num
    else
       charOut<="0010100";         -- blank
    end if;
    
else
   charOut<="0010100";
end if;

 ASCII_CHAR <= charOut;
 
 end process;


end Behavioral;
