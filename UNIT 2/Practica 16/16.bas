'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                        IMT 9C PRACTICA 16
'Termómetro con el sensor LM35, visualización en el LCD, alarma y ventilador de enfriamiento.

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000

Dim Verduras As Byte
Dim Voltaje As Single                                       'voltaje multiplicado entre el 100% (5volts)
Dim Temp As Single                                          'Temperatura leida

Config Lcdpin = Pin , Rs = Portd.2 , E = Portd.3 , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , Db7 = Portd.7
Config Lcdbus = 4
Config Lcd = 16 * 2
Initlcd

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc

Config Pinc.0 = Input

Config Portb.5 = Output
Config Portb.4 = Output

Buzzer Alias Portb.5                                        'buzzer
Ventilador Alias Portb.4                                    'ventilador

Inicio:
Cls
Cursor Off                                                  'inicio de cursor en 0 chr es caracter &Hdf simbolo de grados
Lcd "TEMP =     " ; Chr(&Hdf) ; "C"

Var = Getadc(0)
Voltaje = Var * 5
Temp = Voltaje / 10                                         'regla de 3 simple
Locate 1 , 8
Lcd Temp
Buzzer = 0
Ventilador = 0
If Temp >= 32 Then Goto Alert
Wait 1
Goto Inicio

Alert:
Buzzer = 1
Ventilador = 1
Wait 1
Goto Inicio