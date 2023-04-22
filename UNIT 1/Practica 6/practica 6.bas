'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                              IMT PRACTICA 6
'Control de un ventilador mediante sensor de flama KY-026 y visualización en el LCD 16x2.   .

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Config Lcdpin = Pin , Rs = Portc.0 , E = Portc.1 , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5

Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Config Pind.7 = Input
Sensorflamitaxd Alias Pind.7

Config Portb.5 = Output
Ventilador Alias Portb.5

Config Portb.4 = Output
Buzzer Alias Portb.4

Inicio:
Buzzer = 0
Ventilador = 0

If Sensorflamitaxd = 0 Then Goto Fuego

Cls
Lcd "Area Segura"
Goto Inicio

Fuego:
Cls
Waitms 100
Buzzer = 1
Locate 1 , 1
Lcd "Se Ha Detectado"
Locate 2 , 1
Lcd "Fuego"
Wait 5
Cls
Ventilador = 1
Locate 1 , 1
Lcd "   Ventilador "
Locate 2 , 1
Lcd "   Encendido"
Wait 10
Ventilador = 0
Buzzer = 0
Cls
Waitms 100
Goto Inicio