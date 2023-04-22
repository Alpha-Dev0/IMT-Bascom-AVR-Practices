'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT 9C PRACTICA 12
'Detector de nivel de agua con el sensor ultrasónico HC-SR04, alarma y visualización en el LCD 16x2..

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328Pdef.dat"
$crystal = 16000000


Dim Var As Byte
Dim Cm As Byte


Config Lcdpin = Pin , Rs = Portd.2 , E = Portd.3 , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , Db7 = Portd.7
Config Lcdbus = 4
Config Lcd = 16 * 2

Initlcd

Config Pinc.0 = Input
Config Portb.0 = Output
Config Portb.5 = Output

Eco Alias Pinc.0
Buzzer Alias Portb.0
Trigger Alias Portb.5

Inicio:
Buzzer = 0
Trigger = 1
Waitus 100
Trigger = 0

Pulsein Var , Pinc , 0 , 1

If Var >= 64 Then Goto Bajo
If Var = 63 Then Goto Bajo
If Var = 56 Then Goto Bajo
If Var = 49 Then Goto Bajo
If Var = 42 Then Goto Medio
If Var = 35 Then Goto Medio
If Var = 28 Then Goto Medio
If Var = 21 Then Goto Medio
If Var <= 20 Then Goto Alto
Waitus 200
Goto Inicio

Bajo:
If Var >= 64 Then Cm = 0
If Var = 63 Then Cm = 1
If Var = 56 Then Cm = 2
If Var = 49 Then Cm = 3
If Var = 42 Then Cm = 4

Cls
Locate 1 , 1
Lcd "NIVEL BAJO"
Locate 1 , 14
Lcd Var
Locate 2 , 6
Lcd Cm
Locate 2 , 7
Lcd "CM"
Waitms 20
Goto Inicio

Medio:

If Var = 42 Then Cm = 5
If Var = 35 Then Cm = 6
If Var = 28 Then Cm = 7
If Var = 21 Then Cm = 8

Cls
Locate 1 , 1
Lcd "NIVEL MEDIO"
Locate 1 , 14
Lcd Var
Locate 2 , 6
Lcd Cm
Locate 2 , 7
Lcd "CM"
Waitms 20
Goto Inicio

Alto:

If Var <= 20 Then Cm = 9
Cls
Locate 1 , 1
Lcd "NIVEL ALTO"
Locate 1 , 14
Lcd Var
Locate 2 , 6
Lcd Cm
Locate 2 , 7
Lcd "CM"
Nya = 1
Waitms 20
Goto Inicio