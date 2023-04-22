'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                        IMT 9C PRACTICA 18
'      Detector de humo y gas, alarma y visualización en el LCD.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m2560def.dat"
$crystal = 16000000

Config Lcdpin = Pin , Rs = Porth.1 , E = Porth.0 , Db4 = Porta.1 , Db5 = Porta.3 , Db6 = Porta.5 , Db7 = Porta.7
Config Lcdbus = 4
Config Lcd = 20 * 4
Initlcd

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc


Config Pinf.0 = Input

Config Portb.5 = Output
Config Porte.3 = Output
Config Porth.3 = Output
Config Portc.0 = Output

Bajo Alias Portb.5
Medio Alias Porte.3
Alto Alias Porth.3
Buzzer Alias Portc.0

Inicio:

Dim Var As Word

Var = Getadc(0)

Locate 3 , 5
Lcd Var
Waitms 20

If Var <= 335 Then Goto Nivelbajo
If Var >= 400 And Var <= 450 Then Goto Nivelmedio
If Var >= 800 Then Goto Nivelalto
Goto Inicio

Nivelbajo:
Cls
Bajo = 1
Medio = 0
Alto = 0
Buzzer = 0
Lcd "   NIVEL BAJO"
Goto Inicio

Nivelmedio:
Cls
Bajo = 0
Medio = 1
Alto = 0
Lcd "  NIVEL MEDIO"
Buzzer = 1
Waitms 500
Buzzer = 0
Waitms 500
Goto Inicio

Nivelalto:
Cls
Bajo = 0
Medio = 0
Alto = 1
Buzzer = 1
Lcd "   NIVEL ALTO"
Locate 2 , 1
Lcd "   PELIGRO!"

Goto Inicio