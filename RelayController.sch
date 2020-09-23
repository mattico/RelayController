EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Wireless-less Smart Switch"
Date "2020-09-12"
Rev "1"
Comp "Matt Ickstadt"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_ST_STM32L0:STM32L011D4Px U1
U 1 1 5F5D065C
P 6100 4300
F 0 "U1" H 6550 4950 50  0000 C CNN
F 1 "STM32L011D4Px" H 6550 4800 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 5800 3800 50  0001 R CNN
F 3 "http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00206508.pdf" H 6100 4300 50  0001 C CNN
	1    6100 4300
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 5F5D11F5
P 2050 3750
F 0 "J2" H 2130 3742 50  0000 L CNN
F 1 "Conn_01x02" H 2130 3651 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B02B-XH-AM_1x02_P2.50mm_Vertical" H 2050 3750 50  0001 C CNN
F 3 "~" H 2050 3750 50  0001 C CNN
	1    2050 3750
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x07_Counter_Clockwise J1
U 1 1 5F5D1BCF
P 6100 6000
F 0 "J1" H 6150 6517 50  0000 C CNN
F 1 "Conn_02x05_Odd_Even" H 6150 6426 50  0000 C CNN
F 2 "RelayController:BoardEdgeSolderConnector" H 6100 6000 50  0001 C CNN
F 3 "~" H 6100 6000 50  0001 C CNN
	1    6100 6000
	0    1    1    0   
$EndComp
$Comp
L power:+3V3 #PWR0101
U 1 1 5F5D2C50
P 6100 3300
F 0 "#PWR0101" H 6100 3150 50  0001 C CNN
F 1 "+3V3" H 6100 3450 50  0000 C CNN
F 2 "" H 6100 3300 50  0001 C CNN
F 3 "" H 6100 3300 50  0001 C CNN
	1    6100 3300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F5D3507
P 6100 4900
F 0 "#PWR0102" H 6100 4650 50  0001 C CNN
F 1 "GND" H 6100 4750 50  0000 C CNN
F 2 "" H 6100 4900 50  0001 C CNN
F 3 "" H 6100 4900 50  0001 C CNN
	1    6100 4900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 5F5D3ECE
P 5750 3500
F 0 "C2" H 5842 3546 50  0000 L CNN
F 1 "10uF" H 5842 3455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5750 3500 50  0001 C CNN
F 3 "~" H 5750 3500 50  0001 C CNN
	1    5750 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 5F5D4195
P 5600 3500
F 0 "C1" H 5500 3550 50  0000 R CNN
F 1 "100nF" H 5500 3450 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5600 3500 50  0001 C CNN
F 3 "~" H 5600 3500 50  0001 C CNN
	1    5600 3500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5F5D43D6
P 5600 3600
F 0 "#PWR0103" H 5600 3350 50  0001 C CNN
F 1 "GND" H 5600 3450 50  0000 C CNN
F 2 "" H 5600 3600 50  0001 C CNN
F 3 "" H 5600 3600 50  0001 C CNN
	1    5600 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5F5D4733
P 5750 3600
F 0 "#PWR0104" H 5750 3350 50  0001 C CNN
F 1 "GND" H 5750 3450 50  0000 C CNN
F 2 "" H 5750 3600 50  0001 C CNN
F 3 "" H 5750 3600 50  0001 C CNN
	1    5750 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 3400 5600 3350
Wire Wire Line
	5600 3350 5750 3350
Wire Wire Line
	6100 3350 6100 3300
Wire Wire Line
	5750 3400 5750 3350
Connection ~ 5750 3350
Wire Wire Line
	5750 3350 6100 3350
Wire Wire Line
	6100 3350 6100 3800
Connection ~ 6100 3350
Wire Wire Line
	2250 3750 2350 3750
Wire Wire Line
	2350 3850 2350 3950
Wire Wire Line
	2350 3950 2750 3950
Wire Wire Line
	2350 3850 2250 3850
$Comp
L Device:R_US R1
U 1 1 5F5DCB2E
P 2500 3750
F 0 "R1" V 2295 3750 50  0000 C CNN
F 1 "100" V 2386 3750 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2540 3740 50  0001 C CNN
F 3 "~" H 2500 3750 50  0001 C CNN
	1    2500 3750
	0    -1   1    0   
$EndComp
Wire Wire Line
	2650 3750 2750 3750
$Comp
L power:+3V3 #PWR0105
U 1 1 5F5DFD69
P 3400 3100
F 0 "#PWR0105" H 3400 2950 50  0001 C CNN
F 1 "+3V3" H 3400 3250 50  0000 C CNN
F 2 "" H 3400 3100 50  0001 C CNN
F 3 "" H 3400 3100 50  0001 C CNN
	1    3400 3100
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5F5E066B
P 3400 4000
F 0 "#PWR0106" H 3400 3750 50  0001 C CNN
F 1 "GND" H 3400 3850 50  0000 C CNN
F 2 "" H 3400 4000 50  0001 C CNN
F 3 "" H 3400 4000 50  0001 C CNN
	1    3400 4000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3400 4000 3400 3950
Wire Wire Line
	3400 3950 3350 3950
Text GLabel 5700 4700 0    50   Input ~ 0
PB9
Text GLabel 5700 4400 0    50   Input ~ 0
PC14
Text GLabel 5700 4500 0    50   Input ~ 0
PC15
Text GLabel 5700 4000 0    50   Input ~ 0
~RST
Text GLabel 6500 4300 2    50   Input ~ 0
PA7|AUDIO_EN
Text GLabel 6500 4500 2    50   Input ~ 0
PA10
Text GLabel 6500 4600 2    50   Input ~ 0
PA13|SWDIO
Text GLabel 6500 4700 2    50   Input ~ 0
PA14|SWCLK
$Comp
L Connector_Generic:Conn_01x05 J4
U 1 1 5F5FA7E0
P 8300 3100
F 0 "J4" V 8550 2850 50  0000 L CNN
F 1 "Conn_01x05" V 8450 2850 50  0000 L CNN
F 2 "Connector_PinHeader_2.00mm:PinHeader_1x05_P2.00mm_Vertical" H 8300 3100 50  0001 C CNN
F 3 "~" H 8300 3100 50  0001 C CNN
	1    8300 3100
	1    0    0    1   
$EndComp
$Comp
L power:+3V3 #PWR01
U 1 1 5F5FF0D7
P 8100 3200
F 0 "#PWR01" H 8100 3050 50  0001 C CNN
F 1 "+3V3" V 8100 3400 50  0000 C CNN
F 2 "" H 8100 3200 50  0001 C CNN
F 3 "" H 8100 3200 50  0001 C CNN
	1    8100 3200
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5F5FFB85
P 8100 3300
F 0 "#PWR02" H 8100 3050 50  0001 C CNN
F 1 "GND" V 8100 3100 50  0000 C CNN
F 2 "" H 8100 3300 50  0001 C CNN
F 3 "" H 8100 3300 50  0001 C CNN
	1    8100 3300
	0    1    -1   0   
$EndComp
$Comp
L Isolator:LTV-817S U2
U 1 1 5F611F93
P 3050 3850
F 0 "U2" H 3050 4175 50  0000 C CNN
F 1 "TLP383" H 3050 4084 50  0000 C CNN
F 2 "Package_DIP:SMDIP-4_W9.53mm" H 3050 3550 50  0001 C CNN
F 3 "http://www.us.liteon.com/downloads/LTV-817-827-847.PDF" H 2700 4150 50  0001 C CNN
	1    3050 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R2
U 1 1 5F613B0B
P 3400 3250
F 0 "R2" H 3332 3204 50  0000 R CNN
F 1 "4.7k" H 3332 3295 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3440 3240 50  0001 C CNN
F 3 "~" H 3400 3250 50  0001 C CNN
	1    3400 3250
	1    0    0    1   
$EndComp
Wire Wire Line
	3400 3400 3400 3550
Wire Wire Line
	3400 3750 3350 3750
Wire Wire Line
	3550 3550 3400 3550
Connection ~ 3400 3550
Wire Wire Line
	3400 3550 3400 3750
Text GLabel 6500 4200 2    50   Input ~ 0
PA4|BUTTON
Text GLabel 6500 4400 2    50   Input ~ 0
PA9|LED
Text GLabel 6500 4100 2    50   Input ~ 0
PA1|RELAY_2
Text GLabel 6400 1850 3    50   Input ~ 0
~RST
Text GLabel 6200 1850 3    50   Input ~ 0
PC14
Text GLabel 6300 1850 3    50   Input ~ 0
PC15
Text GLabel 6100 1850 3    50   Input ~ 0
PB9
Text GLabel 6700 1850 3    50   Input ~ 0
PA4|BUTTON
Text GLabel 6600 1850 3    50   Input ~ 0
PA1|RELAY_2
Text GLabel 6800 1850 3    50   Input ~ 0
PA14|SWCLK
Text GLabel 8100 2900 0    50   Input ~ 0
PA13|SWDIO
Text GLabel 8100 3000 0    50   Input ~ 0
PA10
Text GLabel 8100 3100 0    50   Input ~ 0
PA9|LED
Text GLabel 6500 4000 2    50   Input ~ 0
PA0|RELAY_1
Text GLabel 6500 1850 3    50   Input ~ 0
PA0|RELAY_1
Text GLabel 3550 3550 2    50   Input ~ 0
PA7|AUDIO_EN
Text Label 2700 3950 2    50   ~ 0
CAT
NoConn ~ 6400 6300
NoConn ~ 6100 6300
NoConn ~ 6100 5800
NoConn ~ 6400 5800
$Comp
L Connector_Generic:Conn_01x08 J3
U 1 1 5F5F410B
P 6400 1650
F 0 "J3" V 6600 1900 50  0000 R CNN
F 1 "Conn_01x08" V 6500 1900 50  0000 R CNN
F 2 "Connector_PinHeader_2.00mm:PinHeader_1x08_P2.00mm_Vertical" H 6400 1650 50  0001 C CNN
F 3 "~" H 6400 1650 50  0001 C CNN
	1    6400 1650
	0    -1   -1   0   
$EndComp
NoConn ~ 5900 6300
NoConn ~ 6200 6300
NoConn ~ 6300 5800
Text GLabel 6300 6300 3    50   Input ~ 0
PA1|RELAY_2
Text GLabel 6200 5800 1    50   Input ~ 0
PA4|BUTTON
Text GLabel 6000 6300 3    50   Input ~ 0
PA0|RELAY_1
Text GLabel 6000 5800 1    50   Input ~ 0
PA9|LED
$Comp
L power:GND #PWR0107
U 1 1 5F5E7BF4
P 5800 6300
F 0 "#PWR0107" H 5800 6050 50  0001 C CNN
F 1 "GND" V 5800 6100 50  0000 C CNN
F 2 "" H 5800 6300 50  0001 C CNN
F 3 "" H 5800 6300 50  0001 C CNN
	1    5800 6300
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0108
U 1 1 5F631E73
P 5800 5800
F 0 "#PWR0108" H 5800 5650 50  0001 C CNN
F 1 "+3V3" V 5800 6050 50  0000 C CNN
F 2 "" H 5800 5800 50  0001 C CNN
F 3 "" H 5800 5800 50  0001 C CNN
	1    5800 5800
	1    0    0    -1  
$EndComp
NoConn ~ 5900 5800
$EndSCHEMATC
