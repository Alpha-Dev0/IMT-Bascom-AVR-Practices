'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 10
'Control de un servomotor mediante recepción de datos por Bluetooth y visualización en el LCD 16x2..

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$baud = 4900


Config Portb.0 = Output
Servo Alias Portb.0

Config Lcdpin = Pin , Rs = Portc.0 , E = Portc.1 , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5

Config Lcdbus = 4
Config Lcd = 16 * 2

Initlcd

Dim Char As Byte

Inicio:

Char = Inkey()
If Char = 1 Then Goto Cero
If Char = 2 Then Goto Cienochenta
Goto Inicio

Cero:

              Cls
              Locate 1 , 1
              Lcd "0 GRADOS"
              Servo = 1
              Waitms 0.3
              Servo = 0
              Waitms 22
              Goto Inicio

 Cienochenta:
              Cls
              Locate 1 , 1
              Lcd "180 GRADOS"
              Servo = 1
              Waitms 2.1
              Servo = 0
              Waitms 22
              Goto Inicio