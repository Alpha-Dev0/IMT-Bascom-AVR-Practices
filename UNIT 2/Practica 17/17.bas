'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                        IMT 9C PRACTICA 17
'Medidor de corriente con el sensor ACS712 y visualización en el LCD.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Dim C As Integer                                            'contador del bucle for
Dim Irms As Single                                          'amps
Dim P As Single                                             'potencia

Dim Voltajesensor As Single
Dim Valorsensor As Long
Dim Corriente As Single
Dim Imax As Single
Dim Imin As Single

Dim Obtenercorriente As Single

Dim Operacion1 As Single
Dim Operacion2 As Single

Const Sensibilidad = 0.066
Const Voltaje = 110

Dim 5entre1023 As Single

Config Lcdpin = Pin , Rs = Portd.2 , E = Portd.3 , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , Db7 = Portd.7
Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Config Single = Scientific , Digits = 2

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc

Config Pinc.0 = Input

Do
Corriente = 0
Imin = 0
Imax = 0
5entre1023 = 5 / 1023
Obtenercorriente = 0
Operacion1 = 0
Operacion2 = 0


For C = 0 To 500

 Valorsensor = Getadc(0)

 Voltajesensor = Valorsensor * 5entre1023
 Operacion1 = Voltajesensor - 2.5
 Corriente = Operacion1 / Sensibilidad


 If Corriente > Imax Then
 Imax = Corriente
 End If

 If Corriente < Imin Then
 Imin = Corriente
 End If


Next

Operacion2 = Imax - Imin
Obtenercorriente = Operacion2 / 2
Obtenercorriente = Obtenercorriente - 0.180

Irms = Obtenercorriente * 0.707
P = Irms * Voltaje

Locate 1 , 1
   Lcd " Amps"
Locate 1 , 7
   Lcd "Volt"
Locate 1 , 14
   Lcd "Pot"

Locate 2 , 1
   Lcd Irms ; "A"
Locate 2 , 7
   Lcd Voltaje ; "V"
Locate 2 , 12
   Lcd P ; "W"



Print Irms ; " Amps"
Print P ; " P"
Print Valorsensor ; " ValorSensor"
Print " - - -  -- -  - "
Wait 1





Loop