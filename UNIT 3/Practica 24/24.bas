'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                IMT 9C PRACTICA 24

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m2560def.dat"
$crystal = 16000000
$baud = 9600

Dim Char As Byte
Dim Paso As Word

Config Porta.6 = Output
Config Porta.4 = Output
Config Porta.2 = Output

Xstep Alias Porta.4
Xdir Alias Porta.6
Xen Alias Porta.2

Inicio:
Char = Inkey()
If Char = "a" Then Goto Der
If Char = "b" Then Goto Izq
If Char = "c" Then Goto Inicio
Print "24"
Goto Inicio

Der:
Char = Inkey()
If Char = "a" Then Goto Der
If Char = "b" Then Goto Izq
If Char = "c" Then Goto Inicio
Xen = 0
Xdir = 0
For Paso = 0 To 200
Xstep = 1
Waitms 1
Xstep = 0
Waitms 1
Next
Goto Der

Izq:
Char = Inkey()
If Char = "a" Then Goto Der
If Char = "b" Then Goto Izq
If Char = "c" Then Goto Inicio
Xen = 0
Xdir = 1
For Paso = 0 To 200
Xstep = 1
Waitms 1
Xstep = 0
Waitms 1
Next
Goto Izq