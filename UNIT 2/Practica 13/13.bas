
'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                       IMT 9C PRACTICA 13
'Medidor de voltaje con el ADC, leds indicadores y visualización en el monitor serial.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
Dim Seeve As Byte

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc
Config Pinc.0 = Input
Dehoyos Alias Pinc.0

Config Portb.1 = Output
Config Portb.2 = Output
Config Portb.3 = Output

Alto Alias Portb.1
Medio Alias Portb.2
Bajo Alias Portb.3

Inicio:
Seeve = Getadc(0)

If Seeve <= 255 And Seeve >= 171 Then Alto = 1
If Seeve <= 170 And Seeve >= 86 Then Medio = 1
If Seeve <= 85 And Seeve >= 25 Then Bajo = 1
If Seeve <= 24 Then Goto Ledoff

Waitms 25
Goto Inicio


Ledoff:

Alto = 0
Medio = 0
Bajo = 0
Goto Inicio