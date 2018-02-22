# EGR-426-Project-2
This project utilizes system components in VHDL to implement a video game on the BASYS 3 FPGA board. The components will generate the necessary timings for driving a VGA display. The game that is created is the mini game from Wario Ware Inc. called "Hurry Hurdles".

# Background
A standard VGA video display requires 5 inputs: two digital inputs named HSYNC and VSYNC and three
analog inputs named R, G, B for the three colors red, green, and blue. At a frame rate of 60 Hz a single frame
(i.e., screen) of video information is encoded every 16.67 ms. Higher frame rates, which provide less flicker and
interference with fluorescent lights, may be supported depending upon the monitor’s capabilities. Frame rates of
70 Hz and higher are standard on today’s monitors.
Each frame is initialized with a low-going pulse on the VSYNC input. This tells the monitor to begin drawing
pixels at the top-left of the screen. This low-going VSYNC pulse causes the monitor’s electron beam (unless it’s
an LCD display) to effect a vertical trace, i.e., move from the bottom right to the top-left of the screen.
The monitor’s electron beam then moves from left to right horizontally across the face of the monitor at a
predefined speed. When a low-going pulse on the HSYNC input is received, the beam moves down one row and
effects a horizontal retrace to the left side of the screen. After all of the rows of the screen have been drawn
(with an HSYNC at the end of each one), the frame is complete and the next VSYNC pulse arrives to initiate
the next frame.
The number of pixels in each row is determined by the period of HSYNC, while the number of rows on the
screen is determined by the number of HSYNC periods in one VSYNC period. Different resolutions may be
obtained by changing the periods of these “clocks”.
As the electron beam scans across the screen from left to right, the analog voltage of the R, G, and B inputs
determine the intensity of red, green, and blue pixels at the beam’s position. 
The Digilent BASYS-3 boards are well suited for generating VGA video signals with a resolution of 640x480
pixels at a frame rate (i.e., VSYNC frequency) of 60 Hz1
. At this resolution, the left-to-right speed of the
monitor’s electron beam ideally draws pixels at a rate of 25.175 MHz, which is known as the pixel clock
frequency (or 39.72 ns/pixel). A 25 MHz clock is easily derived on the Basys-3 board and has a period of 40 ns
which is close enough to this ideal value for our purposes
At 640x480 resolution, each horizontal row actually occupies 800 pixels, though only 640 of them are meant to
be visible. The remaining pixel times are used for the blank areas on the screen surrounding the image, plus the
time it takes to retrace the electron beam (if there is one). Thus, at 800 pixels per row, an HSYNC pulse should
be generated every 800 • 39.72 = 31.78 µs. The blank areas before the 640-pixel active video area are known as
the “back porch” and “front porch” respectively. By adjusting, the width of these inactive areas, the screen
position can be moved horizontally on the display. Similarly, at 640x480 resolution an entire frame occupies
1/60 of a second, 16.67 ms, hence 524 lines, of which only 480 are meant to be visible. The remaining lines are
the back porch, front porch, and vertical retrace times.
The red, green and blue channels use four I/O pins each to create 16 intensity levels for red, green and blue
colors. Thus, a total of 12 I/O pins are used to drive the R, G, and B analog VGA signals allowing for 4096
color choices. The R, G, and B color signals use resistor-divider circuits that work in conjunction with the 75-
ohm termination resistance of the VGA display to create 16 signal levels each on the red, green, and blue VGA
signals that proceed in equal increments between 0V (fully off) and 0.7V (fully on).
A video controller circuit must be created in the FPGA to drive the sync and color signals with the correct
timing in order to produce a working display system. A VGA controller circuit must generate the HSYNC and
VSYNC timings signals and coordinate the delivery of video data based on the pixel clock. The pixel clock
defines the time available to display one pixel of information. The VSYNC signal defines the “refresh”
frequency of the display, or the frequency at which all information on the display is redrawn. The minimum
refresh frequency is a function of the display’s phosphor and electron beam intensity, with practical refresh
frequencies falling in the 50Hz to 120Hz range.
The 14 inputs to the monitor (HSYNC, VSYNC, 4 R’s, 4 G’s, 4 B’s) are hardwired to pins on the FPGA. Take
care to assign these pins correctly in your XDC (constraints) file otherwise damage may result to the monitor
