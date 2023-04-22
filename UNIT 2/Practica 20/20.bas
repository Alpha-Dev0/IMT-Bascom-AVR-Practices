'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                        IMT 9C PRACTICA 20
'Arranque de motor paso a paso por distancia y paro mediante temperatura y detección de gas con visualización en el LCD.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m2560def.dat"
$crystal = 16000000

Dim Var As Word
Dim Lect As Word                                            'voltaje analogico del transistor
Dim Voltaje As Single                                       'voltaje multiplicado entre el 100% (5volts)
Dim Temp As Single
Dim Paso As Long
Dim Gas As Word

Declare Sub Izquierda()

Config Lcdpin = Pin , Rs = Porth.1 , E = Porth.0 , Db4 = Porta.1 , Db5 = Porta.3 , Db6 = Porta.5 , Db7 = Porta.7
Config Lcdbus = 4
Config Lcd = 20 * 4
Initlcd

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc

Config Pinf.5 = Input
Config Pinf.3 = Input
Config Pinf.0 = Input

'Config Portf.1 = Output
'Config Portd.7 = Output
Config Porta.4 = Output
Config Porta.2 = Output
Config Porta.6 = Output

Xstep Alias Porta.4
Xdir Alias Porta.6
Xen Alias Porta.2

Config Portg.1 = Output
Trig Alias Portg.1
Xen = 0

Inicio:
Trig = 1
Waitus 20
Trig = 0

Pulsein Var , Pinf , 3 , 1
Cls
Lcd "MOTOR APAGADO"
Locate 4 , 1
Lcd Var
If Var <= 75 And Var >= 60 Then Gosub Izquierda
Wait 1
Goto Inicio

Peligro:
Cls
Lcd "TEMPERATURA ALTA"
Locate 2 , 1
Lcd "PELIGRO"
Wait 2
Goto Inicio

Sub Izquierda()
         Cls
         Lcd "MOTOR ENCENDIDO"
         Locate 2 , 1
         Lcd "DISTANCIA 10cm"
         Xdir = 0
For Paso = 0 To 3200
         Xstep = 1
         Waitms 1
         Xstep = 0
         Waitms 1
         Next

Gas = Getadc(5)
Lect = Getadc(0)                                            'lectura en adc 0
Voltaje = Lect * 5
Temp = Voltaje / 10
Cls
Locate 4 , 1
Lcd Temp
Locate 4 , 10
Lcd Gas
If Temp >= 33 And Gas >= 300 Then Goto Peligro
Gosub Izquierda

End Sub