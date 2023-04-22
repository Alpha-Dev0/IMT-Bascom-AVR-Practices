'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                       IMT 9C PRACTICA 14
'         Termómetro con el sensor LM35 y leds indicadores.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile "m328pdef.dat"
$crystal = 16000000

Dim Lect As Byte                                            'voltaje analogico del transistor
Dim Voltaje As Single                                       'voltaje multiplicado entre el 100% (5volts)
Dim Temp As Single                                          'Temperatura leida

Config Adc = Single , Prescaler = Auto , Reference = Avcc   'configuracion de pines como uso analogico
Start Adc                                                   'comienzo o ejecucion de lectura analogica

Config Pinc.0 = Input

Config Portb.1 = Output
Config Portb.2 = Output
Config Portb.3 = Output

Alto Alias Portb.1
Medio Alias Portb.2
Bajo Alias Portb.3

Inicio:
Alto = 0
Medio = 0
Bajo = 0

Lect = Getadc(0)                                            'lectura en adc 0
Voltaje = Lect * 5
Temp = Voltaje / 10

If Temp >= 33 Then Alto = 1
If Temp = 32 Then Medio = 1
If Temp <= 31 Then Bajo = 1

Wait 1
Goto Inicio