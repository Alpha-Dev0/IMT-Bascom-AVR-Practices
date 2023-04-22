'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                IMT 9C PRACTICA 22

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m2560def.dat"
$crystal = 16000000
$baud = 9600

Config Lcdpin = Pin , Rs = Porth.1 , E = Porth.0 , Db4 = Porta.1 , Db5 = Porta.3 , Db6 = Porta.5 , Db7 = Porta.7
Config Lcdbus = 4
Config Lcd = 20 * 4
Initlcd

Dim Red As Word
Dim Green As Word
Dim Blue As Word
Dim White As Word
Dim Cryp As Word
Cryp = 0


Declare Sub Blanco()
Declare Sub Rojo()
Declare Sub Azul()
Declare Sub Naranja()
Declare Sub Wrong()
Declare Sub Cerradura()

Config Portf.0 = Output
Config Portf.1 = Output
Config Portd.7 = Output
Config Portc.3 = Output
Config Pinc.1 = Input

S0 Alias Portf.0
S1 Alias Portf.1
S2 Alias Portd.7
S3 Alias Portc.3
Config Portb.5 = Output
Servo Alias Portb.5

S0 = 1
S1 = 0
Do
Inicio:
Cls
'RED
S2 = 0
S3 = 0
Pulsein Red , Pinc , 1 , 1
Waitms 100
'BLUE
S2 = 0
S3 = 1
Pulsein Blue , Pinc , 1 , 1
Waitms 100
'GREEN
S2 = 1
S3 = 1
Pulsein Green , Pinc , 1 , 1
Waitms 100
'white
S2 = 1
S3 = 0
Pulsein White , Pinc , 1 , 1
Waitms 100
Cls
Locate 1 , 3
Lcd "PUERTA CERRADA"
Print "rojo " ; Red ; "azul " ; Blue ; "verde " ; Green ; "blanco " ; White

If Red <= 16 And Blue <= 52 And Green >= 34 And White = 7 Then Gosub Naranja
If Red >= 100 And Blue >= 20 And Green <= 60 And White >= 12 And White <= 15 Then Gosub Azul
If Red <= 20 And Blue >= 13 And Green <= 22 And White = 5 Then Gosub Blanco
If Red >= 35 And Blue >= 86 And Green >= 132 And White >= 22 Then Gosub Rojo
Waitms 100
Loop

'pass NARANJA, AZUL,BLANCO,ROJO
Sub Naranja()
           Cls
           Locate 2 , 3
           Lcd "COLOR NARANJA"
           Wait 5
           Locate 1 , 3
           Lcd "PUERTA CERRADA"
           Wait 1
           If Cryp = 0 Then Cryp = 1
           If Cryp = 1 Then Goto Inicio
           If Cryp >= 2 Then Gosub Wrong
           Wait 2
End Sub Naranja()

Sub Azul()
           Cls
           Locate 2 , 3
           Lcd "COLOR AZUL"
           Wait 5
           Locate 1 , 3
           Lcd "PUERTA CERRADA"
           Wait 1
           If Cryp = 1 Then Cryp = 6
           If Cryp = 6 Then Goto Inicio
           If Cryp >= 2 Then Gosub Wrong
           Wait 2
End Sub Azul()

Sub Blanco()
            Cls
            Locate 2 , 3
            Lcd "COLOR BLANCO"
            Locate 1 , 3
            Lcd "PUERTA CERRADA"
            Wait 1
            If Cryp = 6 Then Cryp = 10
            If Cryp = 10 Then Goto Inicio
            If Cryp <= 5 Then Gosub Wrong
            Wait 2
End Sub Blanco()

Sub Rojo()
            Cls
            Locate 2 , 3
            Lcd "COLOR ROJO"
            Wait 1
            If Cryp = 10 Then Gosub Cerradura
            If Cryp <= 9 Then Gosub Wrong
            Wait 2

End Sub Rojo()

Sub Cerradura()
            Cls
            Locate 1 , 3
            Lcd "PUERTA ABIERTA"
            Gosub Abrir
            Wait 4
            Gosub Cerrar
            Cls
            Locate 1 , 3
            Lcd "PUERTA CERRADA"
            Wait 1
            Cryp = 0
            Goto Inicio

End Sub Cerradura()

Abrir:
            Servo = 1
            Waitms 2.1
            Servo = 0
            Waitms 22
            Return

Cerrar:
            Servo = 1
            Waitms 0.3
            Servo = 0
            Waitms 22
            Return

Sub Wrong()
          Cls
          Locate 2 , 3
          Lcd "COLOR INCORRECTO"
          Wait 1
          Locate 1 , 3
          Lcd "PUERTA CERRADA"
          Locate 3 , 3
          Lcd "INTENTA NUEVAMENTE"
          Wait 1
          Cryp = 0
          Goto Inicio

End Sub Wrong()