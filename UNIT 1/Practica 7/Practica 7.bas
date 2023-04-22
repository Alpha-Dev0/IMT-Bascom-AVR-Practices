'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                             IMT PRACTICA 7
'Control de un servomotor mediante dos sensores FC-51 y visualización en el LCD 16x2.   .

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Config Lcdpin = Pin , Rs = Portc.0 , E = Portc.1 , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5

Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Config Pind.7 = Input
Config Pind.6 = Input

Sensor1 Alias Pind.7
Sensor2 Alias Pind.6

Config Portb.0 = Output
Servo Alias Portb.0
Config Portb.1 = Output
Portb.1 = 1
Inicio:

If Sensor1 = 0 Then Goto Grado0
If Sensor2 = 1 Then Goto Grado180
Goto Inicio

Grado0:
Cls
Locate 1 , 1
Lcd "0 GRADOS"
Servo = 1
Waitms 0.7                                                  '0.7 sale 1.5 entra
Servo = 0
Waitms 22
Goto Inicio

Grado180:
Cls
Locate 1 , 1
Lcd "180 GRADOS"
Servo = 1
Waitms 0.3
Servo = 0
Waitms 22
Goto Inicio