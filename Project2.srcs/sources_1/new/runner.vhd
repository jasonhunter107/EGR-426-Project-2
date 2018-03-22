----------------------------------------------------------------------------------
-- Company: GVSU
-- Engineer: Jason Hunter
-- 
-- Create Date: 03/16/2018 02:10:32 PM
-- Design Name: Hurry Hurdles
-- Module Name: Runner
-- Project Name: EGR-426-Project-2
-- Target Devices: Artix 7
-- Description: This component is responisble for displaying the runner on the
-- screen and handling the runner's jump physics.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity runner is
Port (clk25 : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); --clk, hcount, vcount
      blank : in STD_LOGIC; --blank
      btn_up : in STD_LOGIC; --jump button
      VS : in STD_LOGIC; --vertical sync clock
      collision : in STD_LOGIC; --collision flag
      speed : in STD_LOGIC_VECTOR(3 downto 0); --speed of runner
      RunnerX_pos : out STD_LOGIC_VECTOR( 10 downto 0); --runner x coordinate
      RunnerY_pos : out STD_LOGIC_VECTOR( 10 downto 0); --runner y coordinate
      Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0)); -- RGB value of runner
end runner;

architecture Behavioral of runner is

--Picture of runner coordinates
    signal Runner_X_Pos : STD_LOGIC_VECTOR (10 downto 0) := "00000111100"; --60
    signal Runner_Y_Pos : STD_LOGIC_VECTOR (10 downto 0) := "00011011001"; -- 217
    
-- Screen dimensions
    constant ROW_MAX : STD_LOGIC_VECTOR (10 downto 0) := "00111100000"; --480
    constant COL_MAX : STD_LOGIC_VECTOR (10 downto 0) := "01010000000"; --640

-- Image dimensions
    constant WIDTH : integer := 64;
    constant HEIGHT : integer := 64;    
    constant CROP : integer := 1; -- Remove outer pixel layers
    
  -- runner ROM Component
    COMPONENT runner_rom
      PORT (clka : IN STD_LOGIC; addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
    END COMPONENT;
    
    --ROM signals
    signal rom_address : STD_LOGIC_VECTOR(11 downto 0);
    signal rom_data : STD_LOGIC_VECTOR(11 downto 0);
    
    signal rom_row : STD_LOGIC_VECTOR(21 downto 0);
    signal rom_col : STD_LOGIC_VECTOR(10 downto 0);
    
    --Display flag for runner
    signal display_flag : STD_LOGIC;  
    
    --Jumping variable flags
    signal jump, falling, in_air : STD_LOGIC := '0';
    
    
begin

--Instantiate runner rom
rr : runner_rom port map(clka => clk25, addra => rom_address, douta => rom_data);

-- Generate ROM address
rom_row <= std_logic_vector(unsigned(vcount - Runner_Y_Pos) * WIDTH);
rom_col <= hcount - Runner_X_Pos;
rom_address <= rom_col + rom_row(11 downto 0);

display_flag <= '1' when blank = '0' and --inside screen
                         ((vcount - Runner_Y_Pos + CROP) < HEIGHT) and --height
                         ((Runner_Y_Pos - vcount + CROP) > HEIGHT) and
                         ((hcount - Runner_X_Pos + CROP) < WIDTH) and --width
                         ((Runner_X_Pos - hcount + CROP) > WIDTH)
                    else '0';
                    
--Process for displaying picture 
process (hcount, vcount, blank)
begin

--Draw the 64 x 64 runner picture
if((((hcount - Runner_X_Pos) <= 64) and ((Runner_X_Pos - hcount) >= 64) and -- draw user generated block
((vcount - Runner_Y_Pos) <= 64) and ((Runner_Y_Pos - vcount) >= 64) and (blank = '0') and (display_flag='1'))) then

--Get RGB values for picture from ROM
Red <= rom_data (11 downto 8);
Green <= rom_data (7 downto 4);
Blue <= rom_data (3 downto 0);

else
Red <= "0000";
Green <= "0000";
Blue <= "0000";

end if;
end process;
                            --Process for jumping
---------------------------------------------------------------------------
 process(VS) 
 begin
 --On rising edge of vertical sync
  if(rising_edge(VS)) then
    --If user presses button or if he is in mid air
    if ((btn_up = '1' or jump = '1' or falling = '1') and collision = '0') then
    
    --If the runner is on the ground then jump up 100 pixels
    if ((Runner_Y_Pos <= 217) and (Runner_Y_Pos > 117) and ((jump = '1') or (btn_up = '1'))) then
    Runner_Y_Pos <= Runner_Y_Pos - 10;
    jump <= '1';
    falling <= '0';
    in_air <= '1';
    
    --If runner reached the max height for jumping then fall down
    elsif (Runner_Y_Pos <= 117) then
     Runner_Y_Pos <= Runner_Y_Pos + speed;
    jump <= '0';
    falling <= '1';
    
    --If runner is still falling then keep falling
    elsif(Runner_Y_Pos < 217 and falling = '1') then
     Runner_Y_Pos <= Runner_Y_Pos + speed;
    jump <= '0';
    falling <= '1';
    
    --If the runner fell down to the ground then reset his position back to its initial value
    elsif (Runner_Y_Pos >= 217 and falling = '1') then
    Runner_Y_Pos <= B"00011011001"; --217
    jump <= '0';
    falling <= '0';
    end if;
    
    end if;
  end if;       -- rising_edge
  end process;

--Set the runner coordinates to the output
RunnerX_pos <= Runner_X_Pos;
RunnerY_pos <= Runner_Y_pos;

end Behavioral;
