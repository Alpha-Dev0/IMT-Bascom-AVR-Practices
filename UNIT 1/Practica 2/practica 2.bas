'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 2
'      Control de un servomotor mediante dos sensores FC-51.  .

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Config Pinc.0 = Input
Config Pinc.1 = Input

Sensor1 Alias Pinc.0
Sensor2 Alias Pinc.1

Config Portb.0 = Output
Servo Alias Portb.0

Inicio:
If Sensor1 = 1 Then Goto Grado0
If Sensor2 = 1 Then Goto Grado180
Goto Inicio


Grado0:
Servo = 1
Waitms 0.3
Servo = 0
Waitms 22
Goto Inicio

Grado180:
Servo = 1
Waitms 2.1
Servo = 0
Waitms 22
Goto Inicio
