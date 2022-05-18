
# Clock signal
set_property PACKAGE_PIN W5 [get_ports {clk}];
set_property IOSTANDARD LVCMOS33 [get_ports {clk}];

#reset
set_property PACKAGE_PIN R2 [get_ports {rst}];
set_property IOSTANDARD LVCMOS33 [get_ports {rst}];


#UP
set_property PACKAGE_PIN W19 [get_ports {up}];
set_property IOSTANDARD LVCMOS33 [get_ports {up}];

#DOWN
set_property PACKAGE_PIN T17 [get_ports {down}];
set_property IOSTANDARD LVCMOS33 [get_ports {down}];

#LEFT
set_property PACKAGE_PIN T18 [get_ports {left}];
set_property IOSTANDARD LVCMOS33 [get_ports {left}];

#RIGHT
set_property PACKAGE_PIN U17 [get_ports {right}];
set_property IOSTANDARD LVCMOS33 [get_ports {right}];

#SHAPE

set_property PACKAGE_PIN T1 [get_ports {shape[1]}];
set_property IOSTANDARD LVCMOS33 [get_ports {shape[1]}];

set_property PACKAGE_PIN U1 [get_ports {shape[0]}];
set_property IOSTANDARD LVCMOS33 [get_ports {shape[0]}];

#COLOR

set_property PACKAGE_PIN W2 [get_ports {color[1]}];
set_property IOSTANDARD LVCMOS33 [get_ports {color[1]}];

set_property PACKAGE_PIN R3 [get_ports {color[0]}];
set_property IOSTANDARD LVCMOS33 [get_ports {color[0]}];

#RED
set_property PACKAGE_PIN G19 [get_ports {r}]				
set_property IOSTANDARD LVCMOS33 [get_ports {r}]

set_property PACKAGE_PIN H19 [get_ports {r}]				
set_property IOSTANDARD LVCMOS33 [get_ports {r}]

set_property PACKAGE_PIN J19 [get_ports {r}]				
set_property IOSTANDARD LVCMOS33 [get_ports {r}]

set_property PACKAGE_PIN N19 [get_ports {r}]				
set_property IOSTANDARD LVCMOS33 [get_ports {r}]

#GREEN

set_property PACKAGE_PIN J17 [get_ports {g}]				
set_property IOSTANDARD LVCMOS33 [get_ports {g}]

set_property PACKAGE_PIN H17 [get_ports {g}]				
set_property IOSTANDARD LVCMOS33 [get_ports {g}]

set_property PACKAGE_PIN G17 [get_ports {g}]				
set_property IOSTANDARD LVCMOS33 [get_ports {g}]

set_property PACKAGE_PIN D17 [get_ports {g}]				
set_property IOSTANDARD LVCMOS33 [get_ports {g}]

#BLUE
	
set_property PACKAGE_PIN N18 [get_ports {b}]				
set_property IOSTANDARD LVCMOS33 [get_ports {b}]

set_property PACKAGE_PIN L18 [get_ports {b}]				
set_property IOSTANDARD LVCMOS33 [get_ports {b}]

set_property PACKAGE_PIN K18 [get_ports {b}]				
set_property IOSTANDARD LVCMOS33 [get_ports {b}]

set_property PACKAGE_PIN J18 [get_ports {b}]				
set_property IOSTANDARD LVCMOS33 [get_ports {b}]
	

#SYNC
	
set_property PACKAGE_PIN P19 [get_ports {hsync}]						
set_property IOSTANDARD LVCMOS33 [get_ports {hsync}]
	
set_property PACKAGE_PIN R19 [get_ports {vsync}]						
set_property IOSTANDARD LVCMOS33 [get_ports {vsync}]



