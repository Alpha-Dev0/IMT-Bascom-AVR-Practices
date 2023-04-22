'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                IMT 9C PRACTICA 23

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m2560def.dat"                                   'ARDUINO MEGA
$crystal = 16000000                                         'FRECUENCIA
$baud = 9600                                                'VELOCIDAD DE COMUNICACION SERIAL

'PINES DE LCD PARA ARDUINO MEGA
Config Lcdpin = Pin , Rs = Porth.1 , E = Porth.0 , Db4 = Porta.1 , Db5 = Porta.3 , Db6 = Porta.5 , Db7 = Porta.7
Config Lcdbus = 4
Config Lcd = 20 * 4
Initlcd

'VARIABLES DEL SENSOR DE COLOR
Dim Red As Word                                             'FILTRO ROJO
Dim Green As Word                                           'FILTRO VERDE
Dim Blue As Word                                            'FILTRO AZUL
Dim White As Word                                           'FILTRO SIN COLOR
'VARIABLES DE CONTADOR DE PIEZAS
Dim Cont As Byte
Dim Contn As Word
Dim Contb As Word
Dim J As Byte

'SUBRUTINAS
Declare Sub Blanco()
Declare Sub Naranja()
Declare Sub Resetcont()

'SALIDAS
Config Portf.0 = Output
Config Portf.1 = Output
Config Portd.7 = Output
Config Portc.3 = Output
Config Porte.5 = Output
'ENTRADAS
Config Pinc.1 = Input
Config Pine.4 = Input


Servo Alias Porte.5

Encobt Alias Pine.4

'NOMBRES DE PUERTOS DEL SENSOR DE COLOR
S0 Alias Portf.0
S1 Alias Portf.1
S2 Alias Portd.7
S3 Alias Portc.3

'FRECUENCIA DE SENSOR DE COLOR
S0 = 1
S1 = 0

'LIMPIAR LCD Y CONTADOR EN 0
Cls
Cont = 0

'BUCLE DO-LOOP
Do
Inicio:
'RED
S2 = 0                                                      'LEER FILTRO ROJO
S3 = 0
Pulsein Red , Pinc , 1 , 1                                  'TOMAR VALOR DEL FILTRO Y GUARDARLO EN VARIABLE RED
Waitms 100
'BLUE
S2 = 0                                                      'LEER FILTRO AZUL
S3 = 1                                                      'GUARDAR VALOR DEL FILTRO
Pulsein Blue , Pinc , 1 , 1
Waitms 100
'GREEN                                                         'LEER FILTRO VERDE
S2 = 1                                                      'GUARDAR VALOR DEL FILTRO
S3 = 1
Pulsein Green , Pinc , 1 , 1
Waitms 100                                                  'LEER FILTRO SIN COLOR
'white                                                        'GUARDAR VALOR DEL FILTRO
S2 = 1
S3 = 0
Pulsein White , Pinc , 1 , 1
Waitms 100

'IMPRIMIR EN EL MONITOR SERIAL VALORES GUARDADOS DE LOS FILTROS

Print "rojo " ; Red ; "azul " ; Blue ; "verde " ; Green ; "blanco " ; White
Locate 3 , 1
Lcd "ESPERANDO PIEZA..."

'CONDICIONES SEGUN LOS VALORES
If Red <= 20 And Blue >= 11 And Blue <= 20 And Green <= 22 And White <= 5 Then Gosub Blanco
If Red <= 16 And Blue <= 52 And Green >= 34 And White >= 7 Then Gosub Naranja

Locate 2 , 3
Lcd Cont ; " PIEZAS TOTAL"
Locate 1 , 5
Lcd Contn ; " NA " ; Contb ; " BL"
Waitms 50
Loop Until J = 1
Goto Resetcont

'SUBRUTINAS
Sub Blanco()
            Cls
            Locate 2 , 3
            Lcd Cont ; " PIEZAS TOTAL"
            Locate 1 , 5
            Lcd Contn ; " NA " ; Contb ; " BL "
            Locate 3 , 3
            Lcd "PIEZA BLANCA"
            Gosub Cienochenta
            Wait 1
            Gosub Noventa
            Contb = Contb + 1
            Cont = Contb + Contn
            If Contb = 3 Then Gosub Resetcont
            Wait 3

End Sub Blanco()

Sub Naranja()
           Cls
           Locate 2 , 3
           Lcd Cont ; " PIEZAS TOTAL"
           Locate 1 , 5
           Lcd Contn ; " NA " ; Contb ; " BL "
           Locate 3 , 3
           Lcd "PIEZA NARANJA"
           Gosub Cero
           Wait 1
           Gosub Noventa
           Contn = Contn + 1
           Cont = Contb + Contn
           If Contn = 3 Then Gosub Resetcont
           Wait 3
End Sub Naranja()
Cero:
           Servo = 1
           Waitms 1.5
           Servo = 0
           Waitms 22
           Return
Noventa:
           Servo = 1
           Waitms 0.7
           Servo = 0
           Waitms 22
           Return
Cienochenta:
            Servo = 1
            Waitms 1.8
            Servo = 0
            Waitms 22
            Return

Resetcont:
           J = 1
           Cls
           Locate 2 , 3
           Lcd Cont ; " PIEZAS TOTAL"
           Locate 1 , 5
           Lcd Contn ; " NA " ; Contb ; " BL "
           Locate 3 , 3
           Lcd "CONTENEDOR LLENO"
           Jj:
           If Encobt = 0 Then Gosub Rest
           Print Encobt
           Wait 1
           Goto Jj
Gosub Resetcont


           Rest:
           If Contb = 3 Then Contb = 0
           If Contn = 3 Then Contn = 0
           Cont = Cont - 3
           J = 0
           Goto Inicio