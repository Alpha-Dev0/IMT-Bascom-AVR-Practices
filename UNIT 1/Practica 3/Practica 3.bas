'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 3
'      Control de un motor a pasos mediante el sensor FC-51.   .

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Config Pinc.0 = Input

Sensor Alias Pinc.0

Config Portb.5 = Output
Config Portb.4 = Output
Config Portb.3 = Output
Config Portb.2 = Output

Out1 Alias Portb.5
Out2 Alias Portb.4
Out3 Alias Portb.3
Out4 Alias Portb.2

Inicio:
If Sensor = 0 Then Goto Motoron

Goto Inicio

Motoron:
Out1 = 1
Out2 = 0
Out3 = 0
Out4 = 1
Waitms 30
Out1 = 0
Out2 = 0
Out3 = 1
Out4 = 1
Waitms 30
Out1 = 0
Out2 = 1
Out3 = 1
Out4 = 0
Waitms 30
Out1 = 1
Out2 = 1
Out3 = 0
Out4 = 0
Waitms 30
Goto Inicio