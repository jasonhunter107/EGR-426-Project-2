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
Port(clk_100MHz,reset, btn_up : in STD_LOGIC; 
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
           score : in STD_LOGIC_VECTOR(11 downto 0);
           round : in STD_LOGIC_VECTOR(7 downto 0);
           ASCII_CHAR : out STD_LOGIC_VECTOR (6 downto 0));
end component;

--Character generator
component Char_Gen 
    Port ( clk25 : in STD_LOGIC;
           blank : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           ASCII_CHAR : in STD_LOGIC_VECTOR (6 downto 0);
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0);
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--Hurdles
component hurdles 
    Port ( reset : in STD_LOGIC;
           VS : in STD_LOGIC;
           blank : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           runnerEnable : in STD_LOGIC;
           score : out STD_LOGIC_VECTOR(11 downto 0);
           round : out STD_LOGIC_VECTOR(7 downto 0);
           Red : out STD_LOGIC_VECTOR (3 downto 0);
           Green : out STD_LOGIC_VECTOR (3 downto 0);
           Blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--Runner
component runner 
Port (clk25 : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
      blank : in STD_LOGIC;
      btn_up : in STD_LOGIC;
      VS : in STD_LOGIC;
      speed : in STD_LOGIC_VECTOR(3 downto 0);
      runnerEnable : out STD_LOGIC;
      Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component Speed_Controller 
    Port ( round : in STD_LOGIC_VECTOR (7 downto 0);
           speed : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--Color multiplexer
component colorPlexer
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
end component;

signal clk_25MHz,blank, VSYNC_temp : STD_LOGIC;
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);
signal ASCII_CHAR : STD_LOGIC_VECTOR(6 downto 0);
signal runnerEnable : STD_LOGIC;
signal score : STD_LOGIC_VECTOR (11 downto 0);
signal round : STD_LOGIC_VECTOR (7 downto 0);
signal speed : STD_LOGIC_VECTOR (3 downto 0);
signal Red_b,Green_b,Blue_b : STD_LOGIC_VECTOR(3 downto 0);
signal Red_c,Green_c,Blue_c : STD_LOGIC_VECTOR(3 downto 0);
signal Red_h,Green_h,Blue_h : STD_LOGIC_VECTOR(3 downto 0);
signal Red_r, Green_r, Blue_r : STD_LOGIC_VECTOR(3 downto 0);

                        --Instantiating Components
-- ---------------------------------------------------------------------
begin
c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                         locked => locked);

v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC, 
                                     VS => VSYNC_temp, blank => blank, hcount => hcount, 
                                     vcount => vcount);

s1 : staticBackground PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                         Red => Red_b, Green => Green_b, Blue => Blue_b);
                         
d1 : char_driver PORT MAP (hcount => hcount, vcount => vcount, score => score, round => round, ASCII_CHAR => ASCII_CHAR);

m1 : CHAR_GEN PORT MAP (clk25 => clk_25MHz, blank => blank, hcount => hcount, vcount => vcount,
                        ASCII_CHAR => ASCII_CHAR, Red => Red_c, Green => Green_c, Blue => Blue_c);
                        
cp1: colorPlexer port map (Red_bgnd => Red_b ,Green_bgnd => Green_b ,Blue_bgnd => Blue_b, 
                                    Red_char => Red_c, Green_char => Green_c, Blue_char => Blue_c, 
                                    Red_hurd => Red_h, Green_hurd => Green_h, Blue_hurd => Blue_h,
                                    Red_run => Red_r, Green_run => Green_r, Blue_run => Blue_r, 
                                    Red => RED,Green => GREEN ,Blue => BLUE);      
                                    
h1: hurdles PORT MAP (reset => reset, VS => VSYNC_temp, blank => blank, hcount => hcount,
                      vcount => vcount,  runnerEnable => runnerEnable, round => round, score => score, Red => Red_h, Green => Green_h, Blue => Blue_h);
                                                             
r1 : runner port map ( clk25 => clk_25MHz, hcount => hcount, vcount => vcount,  blank => blank, btn_up => btn_up, speed => speed, runnerEnable => runnerEnable, VS => VSYNC_temp, Red => Red_r, Green => Green_r, Blue => Blue_r);

sp1: Speed_Controller port map (round => round, speed => speed);


   VSYNC <= VSYNC_temp;        
end Behavioral;
