'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 9
'                 Recepción de datos por Bluetooth.  .

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$baud = 4900


Config Portb.5 = Output
Config Portb.4 = Output
Config Portb.3 = Output
Config Portb.2 = Output

Led1 Alias Portb.5                                          '
Led2 Alias Portb.4
Led3 Alias Portb.3
Led4 Alias Portb.2

Dim Char As Byte

Inicio:

Char = Inkey()
If Char = 97 Then Led1 = 1
If Char = 98 Then Led2 = 1
If Char = 99 Then Led3 = 1
If Char = 100 Then Led4 = 1
If Char = 119 Then Led1 = 0
If Char = 120 Then Led2 = 0
If Char = 121 Then Led3 = 0
If Char = 122 Then Led4 = 0
If Char = 109 Then Goto Secuenciaon
If Char = 110 Then Goto Alloff
Goto Inicio

Secuenciaon:


Led1 = 1
Wait 1
Led2 = 1
Wait 1
Led3 = 1
Wait 1
Led4 = 1
Goto Inicio

Alloff:

Led1 = 0
Led2 = 0
Led3 = 0
Led4 = 0
Goto Inicio