'*******************************************************************************
'-------------------------------------------------------------------------------
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

'                IMT 9C PRACTICA 25

'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'-------------------------------------------------------------------------------
'*******************************************************************************
$regfile = "m328pdef.dat"
$crystal = 16000000
$baud = 2400

Dim Paso As Word

Config Portb.0 = Output
Config Portd.5 = Output
Config Portd.2 = Output
Config Pinb.1 = Input
Config Pinb.2 = Input

Xstep Alias Portd.2
Xdir Alias Portd.5
Xen Alias Portb.0

Sensor1 Alias Pinb.1
Sensor2 Alias Pinb.2

Do
If Sensor1 = 1 And Sensor2 = 1 Then Gosub Der
If Sensor1 = 1 And Sensor2 = 0 Then Gosub Izq
If Sensor1 = 0 And Sensor2 = 0 Then Gosub Der
If Sensor1 = 0 And Sensor2 = 1 Then Print "CC"
Loop

Der:
If Sensor1 = 1 And Sensor2 = 1 Then Print "AC"
If Sensor1 = 1 And Sensor2 = 0 Then Print "AB"
If Sensor1 = 0 And Sensor2 = 0 Then Print "CB"
Xen = 0
Xdir = 0
For Paso = 0 To 200
Xstep = 1
Waitms 1
Xstep = 0
Waitms 1
Next
Return

Izq:
If Sensor1 = 1 And Sensor2 = 1 Then Print "AC"
If Sensor1 = 1 And Sensor2 = 0 Then Print "AB"
If Sensor1 = 0 And Sensor2 = 0 Then Print "CB"

Xen = 0
Xdir = 1
For Paso = 0 To 200
Xstep = 1
Waitms 1
Xstep = 0
Waitms 1
Next
Return