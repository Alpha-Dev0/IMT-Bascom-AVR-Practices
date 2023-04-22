'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                IMT 9C PROYECTO

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************

$regfile = "m2560def.dat"
$crystal = 16000000
$baud = 2600

Config Lcdpin = Pin , Rs = Porth.1 , E = Porth.0 , Db4 = Porta.1 , Db5 = Porta.3 , Db6 = Porta.5 , Db7 = Porta.7
Config Lcdbus = 4
Config Lcd = 20 * 4
Initlcd

Enable Int2
On Int2 Stoplbl Nosave


'-------------------------------------------------------------------------------
'*******************************<VARIABLES>*************************************
Dim J As Byte
Dim Var As Byte
Dim Paso As Long
Dim Cont As Byte
Dim N As Byte
Dim A As Byte
Dim B As Byte
Dim Red As Word
Dim Green As Word
Dim Blue As Word
Dim White As Word
Dim Char As Byte
Dim Stepmotor As Byte

'-------------------------------------------------------------------------------
'*****************************<SUBRUTINAS>**************************************
Declare Sub Abajo()
Declare Sub Arriba()
Declare Sub Pauselow()
Declare Sub Pausehigh()
Declare Sub Stoplbl()

'-------------------------------------------------------------------------------
'****************************<DECLARACION DE PUERTOS>***************************
'=========================STEP-MOTOR============================================
Config Porta.6 = Output
Config Porta.4 = Output
Config Porta.2 = Output

Xstep Alias Porta.4
Xdir Alias Porta.6
Xen Alias Porta.2
'=================================SERVOS========================================

Config Porte.5 = Output
Config Porth.3 = Output

Servoejector Alias Porte.5
Servoselector Alias Porth.3


'==============================SENSOR===========================================
S0 Alias Portf.0
S1 Alias Portf.1
S2 Alias Portd.7
S3 Alias Portc.3

S0 = 1
S1 = 0
'==============================OTHER============================================
Config Pinc.6 = Input
Config Pinc.4 = Input
Config Pinc.2 = Input
Config Ping.0 = Input

Encoa Alias Pinc.6
Encob Alias Pinc.4
Encobt Alias Pinc.2
Buzzer Alias Portc.0
Botton Alias Ping.0

'-------------------------------------------------------------------------------
'*****************************<MENU-PRINCIPAL>**********************************

Cont = 0
N = 0
A = 0

Cls
Locate 1 , 5
Lcd "BIENVENIDOS"
Locate 2 , 7
Lcd "UTNC"
Locate 3 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 4 , 2
Lcd "CONTROL AUTOMATICO"
Var = 0
Wait 2
Do

B = Encoder(pinc.6 , Pinc.4 , Links , Rechts , 1)
If Var = 1 And Encobt = 1 Then Goto Production
If Var = 2 And Encobt = 1 Then Goto Rst
If Botton = 1 Then Goto Production
Char = Inkey()
If Char = 65 Then Goto Production
If Char = 67 Then Goto Rst
If Char = 80 Then Gosub Stoplbl
If Char = 0 Then Goto Production
Loop

Links:
Cursor Off
Cls
Locate 2 , 4
Lcd ">>  START <<"
Var = 1
Return

Rechts:
Cursor Off
Cls
Locate 2 , 4
Lcd ">>  START <<"
Var = 2
Return

'-------------------------------------------------------------------------------
'*****************************<PROGRAMA-PRINCIPAL>******************************

Production:
Gosub Modoespera
Var = 0
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "ELEVADOR SUBIENDO..."
Print "CCRCJ"
Wait 3
Gosub Arriba
Wait 1
Do
New:
Char = Inkey()
If Char = "A" Then Goto Production
If Char = "P" Then Gosub Stoplbl

'RED
S2 = 0
S3 = 0
Pulsein Red , Pinc , 1 , 1
Waitms 200
'BLUE
S2 = 0
S3 = 1
Pulsein Blue , Pinc , 1 , 1
Waitms 200
'GREEN
S2 = 1
S3 = 1
Pulsein Green , Pinc , 1 , 1
Waitms 200
'white
S2 = 1
S3 = 0
Pulsein White , Pinc , 1 , 1
Waitms 200
'Print "rojo " ; Red ; "azul " ; Blue ; "verde " ; Green ; "blanco " ; White
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "LECTURA DE SENSOR..."

If A = 5 Or N = 5 Then Goto Plsreset
If Red = 1 And Blue = 1 And Green = 1 And White = 1 Then Gosub Amarillo
If Red = 3 And Blue = 3 And Green = 3 And White = 3 Then Gosub Naranja
If Red = 2 And Blue = 2 And Green = 2 And White = 2 Then Gosub Naranja
Waitms 100
Loop Until Var = 1
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "ELEVADOR BAJANDO..."
Print "CCRCCO"
Gosub Abajo
Goto Production

Plsreset:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "ALERTA!! CONT FULL"
Char = Inkey()
If Char = "C" Then Goto Rst
If Char = "P" Then Gosub Stoplbl
Waitms 100
Goto Plsreset

Rst:
If A = 5 Then A = 0
If N = 5 Then N = 0
Cont = Cont - 5
Goto New

'-------------------------------------------------------------------------------
'********************************<SERVOS>***************************************
Amarillo:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "PIEZA AMARILLA.."
Wait 1
Gosub Modoespera
Gosub Expulsion
Wait 1
Gosub Retraccion
Wait 3
Gosub Der
Wait 3
Var = 1
Print "CBRCJ"
A = A + 1
Cont = A + N
Return

Naranja:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "PIEZA NARANJA..."
Wait 1
Gosub Expulsion
Wait 1
Gosub Retraccion
Gosub Modoespera
Wait 3
Gosub Izq
Wait 3
Var = 1
Print "ACRCJ"
N = N + 1
Cont = A + N
Return

Izq:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "SELECTOR NARANJA..."
For Var = 1 To 5
Servoselector = 1
Waitms 0.3
Servoselector = 0
Waitms 22
Next
Return

Der:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "SELECTOR AMARILLO..."
For Var = 1 To 10
Servoselector = 1
Waitms 0.3
Servoselector = 0
Waitms 22
Next
Return

Modoespera:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "SELECTOR EN ESPERA..."
For Var = 1 To 3
Servoselector = 1
Waitms 1
Servoselector = 0
Waitms 22
Next
Return


Expulsion:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "PISTON ACCIONADO..."
Print "CCCEJ"
Servoejector = 1
Waitms 0.7
Servoejector = 0
Waitms 22
Return

Retraccion:
Cls
Locate 1 , 1
Lcd "CLAS. D PZS X COLOR"
Locate 2 , 1
Lcd "PZS TOTALES   " ; Cont
Locate 3 , 1
Lcd A ; " AMARILLO " ; N ; " NARANJA"
Locate 4 , 1
Lcd "PISTON RETRAIDO..."
Print "CCRCJ"
Servoejector = 1
Waitms 2.1
Servoejector = 0
Waitms 22
Return

'-------------------------------------------------------------------------------
'*********************<STEPMOTOR-SUBRUTINAS>************************************

Sub Abajo()
         Xen = 0
         Xdir = 0
For Paso = 0 To 3200
         Xstep = 1
         Waitms 1
         Xstep = 0
         Waitms 1
         Next
         Stepmotor = 1
End Sub Abajo()


Sub Arriba()
         Xen = 0
         Xdir = 1
For Paso = 0 To 3200
         Xstep = 1
         Waitms 1
         Xstep = 0
         Waitms 1
         Next
         Stepmotor = 2
End Sub Arriba()

'-------------------------------------------------------------------------------
'********************************<PAUSES-SUB>***********************************

Sub Stoplbl()
     If J > 1 Then
         Exit Sub
     Else
          Gosub Apagado
     End If

     Apagado:
     Cursor Off
     Cls
     Lcd "PARO DE EMERGENCIA!!"
     Buzzer = 1
     Waitms 50
     Buzzer = 0
     Waitms 50
     Buzzer = 1
     Waitms 50
     Buzzer = 0
     Return

End Sub Stoplbl()