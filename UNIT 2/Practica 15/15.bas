'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                           IMT 9C PRACTICA 15
'     Termómetro con el sensor LM35 y visualización en el LCD.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile "m328pdef.dat"
$crystal = 16000000

Dim Webito As Byte                                          'voltaje analogico del transistor
Dim Voltaje As Single                                       'voltaje multiplicado entre el 100% (5volts)
Dim Temp As Single                                          'Temperatura leida

Config Adc = Single , Prescaler = Auto , Reference = Avcc   'configuracion de pines como uso analogico
Start Adc                                                   'comienzo o ejecucion de lectura analogica

Config Pinc.0 = Input

Config Lcdpin = Pin , Rs = Portd.2 , E = Portd.3 , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , Db7 = Portd.7
Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Inicio:
Cls
Cursor Off                                                  'inicio de cursor en 0 chr es caracter &Hdf simbolo de grados
Lcd "TEMP =     " ; Chr(&Hdf) ; "C"

Webito = Getadc(0)                                          'lectura en adc 0
Voltaje = Webito * 5
Temp = Voltaje / 10                                         'regla de 3 simple
Locate 1 , 8
Lcd Temp
Wait 1
Goto Inicio