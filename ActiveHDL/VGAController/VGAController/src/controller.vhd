library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;	 

entity vgaDriver is
	port( clk: in STD_LOGIC;
	rst: in STD_LOGIC;
    hsync: inout STD_LOGIC;
	vsync: inout STD_LOGIC;
	up: in STD_LOGIC;
	down: in STD_LOGIC;
	left: in STD_LOGIC;
	right: in STD_LOGIC;
	shape: in STD_LOGIC_VECTOR( 1 downto 0);
	color: in STD_LOGIC_VECTOR ( 1 downto 0);
	r: inout STD_LOGIC;
	g: inout STD_LOGIC;
	b: inout STD_LOGIC);
end vgaDriver;

architecture controller of vgaDriver is

signal clk25: std_logic := '0'; -- initializing the clock will be obtain after division

--horizontal parameters		

constant hd: integer := 639; -- horizontal display( 640)
constant hfp: integer := 16; -- right border or front porch
constant hsp: integer := 96; -- sync pulse or retrace
constant hbp: integer := 48; -- left border or back porch  

--vertical parameters

constant vd: integer := 479; -- vertical display(480)
constant vfp: integer := 10; -- right border or front porch
constant vsp: integer := 2; -- sync pulse or retrace
constant vbp: integer := 33; -- left border or back porch

signal hPos: integer := 0;
signal vPos: integer := 0; 

signal videoOn: std_logic := '0';
	
signal R1, G1, B1: std_logic; -- color coordinates buffer

signal x: integer := 320;-- horizontal reference position for the shape
signal y: integer := 240;-- vertical reference position for the shape

constant step: integer := 5;

signal lastUp, lastDown, lastLeft, lastRight: std_logic := '0';

begin 
	
	clkDiv: process( clk ) -- frequency divider from 50MHz to 25Mhz
	begin
		if ( clk = '1' and clk'event ) then
			clk25 <= not ( clk25 );
		end if;
	end process; 
	
	horizontalPositionCounter: process( clk25, rst ) -- the counter for horizontal traversal
	begin
		if( rst = '1') then 
			hPos <= 0;
		elsif(clk25 = '1' and clk25'event ) then 
			if( hPos = ( hd + hfp + hsp + hbp ) ) then 
				hPos <= 0;
			else hPos <= hPos + 1;
			end if;
		end if;	
	end process; 
	
	verticalPositionCounter: process( clk25, rst ) -- the counter for vertical traversal
	begin
		if( rst = '1') then 
			vPos <= 0;
		elsif(clk25 = '1' and clk25'event ) then 
			if( vPos = ( vd + vfp + vsp + vbp ) ) then 
				vPos <= 0;
			else vPos <= vPos + 1;
			end if;
		end if;	
	end process;
	
	horizontalSynchronisation: process( clk25, rst, hPos ) -- setting the horizontal timing
	begin
		if( rst = '1' ) then 
			hsync <= '0';
		elsif( clk25 = '1' and clk25'event) then 
			if( (hPos <= ( hd + hfp )) or (hPos > ( hd + hfp + hsp ))) then 
				hsync <= '1';
			else 
				hsync <= '0';
			end if;
		end if;	
	end process;   
	
	verticalSynchronisation: process( clk25, rst, vPos ) -- setting the vertical timing
	begin
		if( rst = '1' ) then 
			vsync <= '0';
		elsif( clk25 = '1' and clk25'event )then
			if( (vPos <= ( vd + vfp) ) or ( vPos > ( vd + vfp + vsp ))) then
				vsync <= '1';
			else 
				vsync <= '0';
			end if;
		end if;
	end process;  
	
	videoOnSet: process( clk25, rst, hPos, vPos ) -- setting the display area
	begin			
		if rst = '1' then 
			videoOn <= '0';
		elsif( clk25 = '1' and clk25'event ) then
			if ( hPos <= hd and vPos <= vd ) then
				videoOn <= '1';
			else 
				videoOn <= '0';
			end if;
		end if;
	end process;  
	
	colorSet: process( clk25, color ) -- setting the color of the shape
	begin
		if( clk25 = '1' and clk25'event ) then
			case color is
				when "00" =>  -- square
				R1 <= '1';
				G1 <= '0';	   
				B1 <= '0';
				
				when "01" =>  -- line
				R1 <= '0'; 
				G1 <= '1';	   
				B1 <= '0'; 
				
				when "10" =>  -- triangle
				R1 <= '0'; 
				G1 <= '0';	   
				B1 <= '1'; 
				
				when others =>	-- circle
				R1 <= '1'; 
				G1 <= '1';	   
				B1 <= '1'; 
			end case;	
		end if;
	end process;
	
	
	move: process( clk25, up, down, left, right, x, y )	 --- moving the shape 
	begin 			
		if( clk25 = '1' and clk25'event ) then 
			if( up = '1' and lastUp = '0' ) then 
				y <= y - step;
			elsif( down = '1' and lastDown = '0' ) then 
				y <= y + step;
			elsif( left = '1' and lastLeft = '0' ) then
				x <= x - step;
			elsif( right = '1' and lastRight = '0' ) then 
				x <= x + step;
			end if;
			lastUp <= up;
			lastDown <= down;
			lastLeft <= left;
			lastRight <= right;
		end if;		
	end process;
	
   draw: process( clk25, rst, hPos, vPos, videoOn, x, y )
   begin		   
	if rst = '1' then 
		r <= '0';
		g <= '0';
		b <= '0';
	elsif( clk25 = '1' and clk25'event ) then
		if videoOn = '1' then -- we are in the display area	
			case shape is 
				
				when "00" =>  -- square 
				if( ( hPos >= 10 + x and hPos <=60 + x) and (vPos>=10 + y and vPos<=60 + y)) then
					r <= R1;
					g <= G1;
					b <= B1;
				else 
					r <= '0';
					g <= '0';
					b <= '0';
				end if;	
				
				when "01" => -- line
				if( (hPos > x - 10) and (hpos < x + 10) and (vPos > y - 70) and (vPos < y + 70)) then
					r <= R1;
					g <= G1;
					b <= B1;
				else 
					r <= '0';
					g <= '0';
					b <= '0';
				end if;
				
				when "10" => -- triangle
				if	((hPos > y - 5) and (hpos < y + 5) and (vPos > x - 30) and (vPos < x + 10)) or
					((hPos > y - 20) and (hpos < y + 20) and (vPos > x - 50) and (vPos < x + 10)) or 
					((hPos > y - 30) and (hpos < y + 30) and (vPos > x - 20) and (vPos < x + 10)) then
					r <= R1;
					g <= G1;
					b <= B1;
				else 
					r <= '0';
					g <= '0';
					b <= '0';
				end if;
				
				when others => -- circle
				if	((hPos > y - 10) and (hpos < y + 10) and (vPos > x - 70) and (vPos < x + 10)) or
					((hPos > y - 20) and (hpos < y + 20) and (vPos > x - 50) and (vPos < x + 10)) or 
					((hPos > y - 30) and (hpos < y + 30) and (vPos > x -20 ) and (vPos < x + 10)) then
					r <= R1;
					g <= G1;
					b <= B1;
				else 
					r <= '0';
					g <= '0';
					b <= '0';
				end if;
				
			 end case;		
		end if;	  
	end if;
		
   end process;
	
	
end controller;
