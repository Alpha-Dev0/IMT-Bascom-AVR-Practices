'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT 9C PRACTICA 19
' Control de un servomotor mediante sensor de temperatura y ultrasónico.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m2560def.dat"
$crystal = 16000000

Dim Var As Word
Dim Lect As Word
Dim Voltaje As Single
Dim Temp As Single


Config Lcdpin = Pin , Rs = Porth.1 , E = Porth.0 , Db4 = Porta.1 , Db5 = Porta.3 , Db6 = Porta.5 , Db7 = Porta.7
Config Lcdbus = 4
Config Lcd = 20 * 4
Initlcd

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc
Config Portg.1 = Output
Config Pinf.5 = Input
Config Pinf.0 = Input
Config Portb.5 = Output
Servo Alias Portb.5
Trigger Alias Portg.1


Inicio:
Trigger = 1
Waitus 20
Trigger = 0

Lect = Getadc(0)
Pulsein Var , Pinf , 5 , 1
Voltaje = Lect * 5
Temp = Voltaje / 10
If Temp >= 30 And Temp <= 32 Then Goto Grado1
If Var >= 40 And Var <= 52 Then Goto Grado2
Locate 4 , 1
Lcd Temp
Locate 4 , 10
Lcd Var
Goto Inicio


Grado1:
Cls
Lcd "0 GRADOS"
Locate 2 , 1
Lcd Temp
Locate 2 , 4
Lcd "CENTIGRADOS"
Servo = 1
Waitms 0.3
Servo = 0
Goto Inicio

Grado2:
Cls
Lcd "180 GRADOS"
Locate 2 , 1
Lcd "DISTANCIA= 8 cm"
Servo = 1
Waitms 2.1
Servo = 0
Waitms 22
Goto Inicio