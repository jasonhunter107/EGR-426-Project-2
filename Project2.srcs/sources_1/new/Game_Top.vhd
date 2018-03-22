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
Port(clk_100MHz,reset, btn_up : in STD_LOGIC; --100 Mhz clock, reset button, jump button
     HSYNC,VSYNC,locked : out STD_LOGIC; --HSYNC, VSYNC, and locked
     RED,GREEN,BLUE : out STD_LOGIC_VECTOR(3 downto 0)); --RGB Values
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
           collision: in STD_LOGIC;
           score : out STD_LOGIC_VECTOR(11 downto 0);
           round : out STD_LOGIC_VECTOR(7 downto 0);
           hurdle_X_pos,hurdle_Y_pos : out STD_LOGIC_VECTOR(10 downto 0);
           hurdle2_X_pos,hurdle2_Y_pos : out STD_LOGIC_VECTOR(10 downto 0);
           hurdle3_X_pos,hurdle3_Y_pos : out STD_LOGIC_VECTOR(10 downto 0);
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
      collision : in STD_LOGIC;
      speed : in STD_LOGIC_VECTOR(3 downto 0);
      RunnerX_pos : out STD_LOGIC_VECTOR( 10 downto 0);
      RunnerY_pos : out STD_LOGIC_VECTOR( 10 downto 0);
      Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

--Speed controller
component Speed_Controller 
    Port ( round : in STD_LOGIC_VECTOR (7 downto 0);
           speed : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--Collision detection
component Collision_Detection 
  Port (
            hurdle_X_pos,hurdle_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            hurdle2_X_pos,hurdle2_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            hurdle3_X_pos,hurdle3_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            runner_X_pos,runner_Y_pos : in STD_LOGIC_VECTOR(10 downto 0);
            reset : in STD_LOGIC;
            collision : out STD_LOGIC
        );
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

                --Signal instantiation
----------------------------------------------------------
signal clk_25MHz,blank, VSYNC_temp : STD_LOGIC;--25Mhz clock, blank, Vertical sync
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0); --hcount, vcount
signal ASCII_CHAR : STD_LOGIC_VECTOR(6 downto 0); --ASCII_CHAR of ROM (letter in ROM)
signal score : STD_LOGIC_VECTOR (11 downto 0); --Score of game
signal round : STD_LOGIC_VECTOR (7 downto 0); --Round of game
signal speed : STD_LOGIC_VECTOR (3 downto 0); --Speed of the runner
signal collision : STD_LOGIC; --Collision flag
signal hurdle_X_pos,hurdle_Y_pos : STD_LOGIC_VECTOR(10 downto 0);
signal hurdle2_X_pos,hurdle2_Y_pos : STD_LOGIC_VECTOR(10 downto 0); --All the hurdle's X an dY coordinates
signal hurdle3_X_pos,hurdle3_Y_pos : STD_LOGIC_VECTOR(10 downto 0);
signal runner_X_pos,runner_Y_pos : STD_LOGIC_VECTOR(10 downto 0); --Runner's X and Y coordinates
signal Red_b,Green_b,Blue_b : STD_LOGIC_VECTOR(3 downto 0);
signal Red_c,Green_c,Blue_c : STD_LOGIC_VECTOR(3 downto 0); --All visual components RGB value
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
                                    
h1: hurdles PORT MAP (reset => reset, VS => VSYNC_temp, blank => blank, hcount => hcount, collision => collision,
                      vcount => vcount, round => round, score => score, hurdle_X_pos =>hurdle_X_pos , hurdle_Y_pos => hurdle_Y_pos ,hurdle2_X_pos => hurdle2_X_pos,
                      hurdle2_Y_pos => hurdle2_Y_pos ,hurdle3_X_pos => hurdle3_X_pos,hurdle3_Y_pos => hurdle3_Y_pos,Red => Red_h, Green => Green_h, Blue => Blue_h);
                                                             
r1 : runner port map ( clk25 => clk_25MHz, hcount => hcount, vcount => vcount,  blank => blank, btn_up => btn_up, speed => speed, VS => VSYNC_temp, collision => collision,
                      RunnerX_pos => Runner_X_pos, RunnerY_pos => Runner_Y_pos, Red => Red_r, Green => Green_r, Blue => Blue_r);

sp1: Speed_Controller port map (round => round, speed => speed);

cl1: Collision_Detection port map (hurdle_X_pos =>hurdle_X_pos , hurdle_Y_pos => hurdle_Y_pos ,hurdle2_X_pos => hurdle2_X_pos,
                      hurdle2_Y_pos => hurdle2_Y_pos ,hurdle3_X_pos => hurdle3_X_pos,hurdle3_Y_pos => hurdle3_Y_pos, runner_X_pos => runner_X_pos,runner_Y_pos =>runner_Y_pos, 
                      reset => reset, collision => collision);


   VSYNC <= VSYNC_temp;        
end Behavioral;
