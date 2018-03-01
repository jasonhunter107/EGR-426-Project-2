----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter 
-- 
-- Create Date: 01/31/2016 04:32:11 PM
-- Design Name: Hurry Hurdles
-- Module Name: Game_Top - Behavioral
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: Top level of Game
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Game_Top is
Port(clk_100MHz,reset : in STD_LOGIC; 
     HSYNC,VSYNC,locked : out STD_LOGIC;
     RED,GREEN,BLUE : out STD_LOGIC_VECTOR(3 downto 0));
end Game_Top;


architecture Behavioral of Game_Top is
-- ---------------------------------------------------------------------
--25MHz clock
component clk_wiz_0
port(clk_in1,reset : in std_logic; clk_out1,locked : out std_logic);
end component;

--VGA Controller
component vga_controller_640_60 is
port(rst,pixel_clk : in std_logic; HS,VS,blank : out std_logic;
     hcount,vcount : out std_logic_vector(10 downto 0));
end component;

--Static background
component staticBackground is
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
      Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

--Character driver
component char_driver 
    Port ( hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           ASCII_CHAR : out STD_LOGIC_VECTOR (6 downto 0));
end component;

--Character generator
component Char_Gen 
    Port ( clk25 : in STD_LOGIC;
           blank : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           ASCII_CHAR : in STD_LOGIC_VECTOR (6 downto 0));
--           Red : out STD_LOGIC_VECTOR (3 downto 0);
--           Green : out STD_LOGIC_VECTOR (3 downto 0);
--           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal clk_25MHz,blank : STD_LOGIC;
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);
signal ASCII_CHAR : STD_LOGIC_VECTOR(6 downto 0);

                        --Instantiating Components
-- ---------------------------------------------------------------------
begin
c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                         locked => locked);

v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC, 
                                     VS => VSYNC, blank => blank, hcount => hcount, 
                                     vcount => vcount);

s1 : staticBackground PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                         Red => RED, Green => GREEN, Blue => BLUE);
                         
d1 : char_driver PORT MAP (hcount => hcount, vcount => vcount, ASCII_CHAR => ASCII_CHAR);

--m1 : CHAR_GEN PORT MAP (clk25 => clk_25MHz, blank => blank, hcount => hcount, vcount => vcount,
--                        ASCII_CHAR => ASCII_CHAR, Red => RED, Green => GREEN, Blue => BLUE);
                        
                        
m1 : CHAR_GEN PORT MAP (clk25 => clk_25MHz, blank => blank, hcount => hcount, vcount => vcount,
                       ASCII_CHAR => ASCII_CHAR);
end Behavioral;
