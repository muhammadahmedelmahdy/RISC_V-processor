set_property package_pin H17 [get_ports leds[0]]
set_property iostandard LVCMOS33 [get_ports leds[0]]
set_property package_pin K15 [get_ports leds[1]]
set_property iostandard LVCMOS33 [get_ports leds[1]] 
set_property package_pin J13 [get_ports leds[2]]
set_property iostandard LVCMOS33 [get_ports leds[2]]
set_property package_pin N14 [get_ports leds[3]]
set_property iostandard LVCMOS33 [get_ports leds[3]]
set_property package_pin R18 [get_ports leds[4]]
set_property iostandard LVCMOS33 [get_ports leds[4]]
set_property package_pin V17 [get_ports leds[5]]
set_property iostandard LVCMOS33 [get_ports leds[5]]
set_property package_pin U17 [get_ports leds[6]]
set_property iostandard LVCMOS33 [get_ports leds[6]]
set_property package_pin U16 [get_ports leds[7]]
set_property iostandard LVCMOS33 [get_ports leds[7]]
set_property package_pin V16 [get_ports leds[8]]
set_property iostandard LVCMOS33 [get_ports leds[8]]
set_property package_pin T15 [get_ports leds[9]]
set_property iostandard LVCMOS33 [get_ports leds[9]]
set_property package_pin U14 [get_ports leds[10]]
set_property iostandard LVCMOS33 [get_ports leds[10]]
set_property package_pin T16 [get_ports leds[11]]
set_property iostandard LVCMOS33 [get_ports leds[11]]
set_property package_pin V15 [get_ports leds[12]]
set_property iostandard LVCMOS33 [get_ports leds[12]]
set_property package_pin V14 [get_ports leds[13]]
set_property iostandard LVCMOS33 [get_ports leds[13]]
set_property package_pin V12 [get_ports leds[14]]
set_property iostandard LVCMOS33 [get_ports leds[14]]
set_property package_pin V11 [get_ports leds[15]]
set_property iostandard LVCMOS33 [get_ports leds[15]]

#Led_out
set_property package_pin T10 [get_ports LED_out[6]]
set_property iostandard LVCMOS33 [get_ports LED_out[6]]
set_property package_pin R10 [get_ports LED_out[5]]
set_property iostandard LVCMOS33 [get_ports LED_out[5]]
set_property package_pin K16 [get_ports LED_out[4]]
set_property iostandard LVCMOS33 [get_ports LED_out[4]]
set_property package_pin K13 [get_ports LED_out[3]]
set_property iostandard LVCMOS33 [get_ports LED_out[3]]
set_property package_pin P15 [get_ports LED_out[2]]
set_property iostandard LVCMOS33 [get_ports LED_out[2]]
set_property package_pin T11 [get_ports LED_out[1]]
set_property iostandard LVCMOS33 [get_ports LED_out[1]]
set_property package_pin L18 [get_ports LED_out[0]]
set_property iostandard LVCMOS33 [get_ports LED_out[0]]


#100Mhz clk
set_property package_pin E3 [get_ports clk]
set_property iostandard LVCMOS33 [get_ports clk]

#reset
set_property package_pin V10 [get_ports rst]
set_property iostandard LVCMOS33 [get_ports rst]

#Anode
set_property package_pin J17 [get_ports Anode[0]]
set_property iostandard LVCMOS33 [get_ports Anode[0]]
set_property package_pin J18 [get_ports Anode[1]]
set_property iostandard LVCMOS33 [get_ports Anode[1]]
set_property package_pin T9 [get_ports Anode[2]]
set_property iostandard LVCMOS33 [get_ports Anode[2]]
set_property package_pin J14 [get_ports Anode[3]]
set_property iostandard LVCMOS33 [get_ports Anode[3]]

#ledSel
set_property package_pin J15 [get_ports ledSel[0]]
set_property iostandard LVCMOS33 [get_ports ledSel[0]]
set_property package_pin L16 [get_ports ledSel[1]]
set_property iostandard LVCMOS33 [get_ports ledSel[1]] 

#ssdSel
set_property package_pin M13 [get_ports ssdSel[0]]
set_property iostandard LVCMOS33 [get_ports ssdSel[0]]
set_property package_pin R15 [get_ports ssdSel[1]]
set_property iostandard LVCMOS33 [get_ports ssdSel[1]]
set_property package_pin R17 [get_ports ssdSel[2]]
set_property iostandard LVCMOS33 [get_ports ssdSel[2]]
set_property package_pin T18 [get_ports ssdSel[3]]
set_property iostandard LVCMOS33 [get_ports ssdSel[3]]

#SSDclk
set_property package_pin N17 [get_ports SSDclk]
set_property iostandard LVCMOS33 [get_ports SSDclk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets SSDclk] 

#numsel
set_property package_pin U11 [get_ports numsel]
set_property iostandard LVCMOS33 [get_ports numsel]


