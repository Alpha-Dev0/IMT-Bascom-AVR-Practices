'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 11
'Control de un motor a pasos mediante recepción de datos por Bluetooth y visualización en el LCD 16x2..

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$baud = 4900

Config Lcdpin = Pin , Rs = Portc.0 , E = Portc.1 , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5

Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Config Portb.5 = Output
Config Portb.4 = Output
Config Portb.3 = Output
Config Portb.2 = Output

Out1 Alias Portb.5
Out2 Alias Portb.4
Out3 Alias Portb.3
Out4 Alias Portb.2

Dim Char As Byte
Inicio:
Char = Inkey()
If Char = 1 Then Goto Derecha
If Char = 2 Then Goto Izquierda

Cls
Lcd "ESPERANDO DATO"
Wait 1

Goto Inicio

Derecha:
Cls
Locate 1 , 1
Lcd "GIRO A LA"
Locate 2 , 6
Lcd "DERECHA"
Waitms 50
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
Out1 = 1
Out2 = 0
Out3 = 0
Out4 = 1
Goto Inicio

Izquierda:
Cls
Locate 1 , 1
Lcd "GIRO A LA"
Locate 2 , 6
Lcd "IZQUIERDA"
Waitms 50:
Out1 = 1
Out2 = 1
Out3 = 0
Out4 = 0
Waitms 30
Out1 = 0
Out2 = 1
Out3 = 0
Out4 = 1
Waitms 30
Out1 = 0
Out2 = 0
Out3 = 1
Out4 = 1
Waitms 30
Out1 = 1
Out2 = 0
Out3 = 1
Out4 = 0
Waitms 30
Out1 = 1
Out2 = 1
Out3 = 0
Out4 = 0
Goto Inicio