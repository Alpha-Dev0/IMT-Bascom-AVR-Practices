'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                          IMT PRACTICA 8
'Control de un motor a pasos mediante dos sensores FC-51 y visualización en el LCD 16x2.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"                                   'ARDUINO UNO
$crystal = 16000000                                         'CRYSTAL 16Mhz

'PINES DE LCD
Config Lcdpin = Pin , Rs = Portc.0 , E = Portc.1 , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5

Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Config Pind.7 = Input                                       'ENTRADAS NOTA: PARA ENTRADAS USAR "PIN" Y SALIDAS "PORT"
Config Pind.6 = Input


Sensor1 Alias Pind.7
Sensor2 Alias Pind.6

'SALIDAS
Config Portb.5 = Output
Config Portb.4 = Output
Config Portb.3 = Output
Config Portb.2 = Output
'NOMBRES DE LAS SALIDAS
Out1 Alias Portb.5
Out2 Alias Portb.4
Out3 Alias Portb.3
Out4 Alias Portb.2


Inicio:

Out1 = 0
Out2 = 0
Out3 = 0
Out4 = 0

If Sensor1 = 0 Then Goto Derecha
If Sensor2 = 0 Then Goto Izquierda

Cls
Locate 1 , 1
Lcd "MOTOR APAGADO"
Wait 1
Goto Inicio

'MOTOR A PASOS HACIA LA DERECHA
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
Goto Inicio                                                 'IR HACIA LA ETIQUETA INICIO

'MOTOR HACIA LA IZQUIERDA
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