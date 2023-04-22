'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 1
'      Control de un ventilador mediante sensor de flama KY-026.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Config Pinc.0 = Input
Sensor Alias Pinc.0

Config Portb.3 = Output                                     'pin 11                              'buzzer
Config Portb.4 = Output                                     'pin 12                              'ventilador

Buzzer Alias Portb.3
Ventilador Alias Portb.4

Inicio:
Buzzer = 0
Ventilador = 0

If Sensor = 1 Then Goto Encendido
Goto Inicio

Encendido:
Buzzer = 1
Wait 5
Ventilador = 1
Wait 10
Goto Inicio