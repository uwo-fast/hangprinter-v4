
; Communication and general
G21              ; Work in millimetres
G90              ; Send absolute coordinates...
M83              ; ...but relative extruder moves

; Kinematics
G4 S1                           ; Wait 1 second because expansion boards might not be ready to receive CAN signal yet.
M584 X40.0 Y41.0 Z42.0 U43.0 P4 ; map ABCD-axes to CAN addresses, and set four visible axes. Please excuse that ABCD motors are called XYZU here.
M584 E121.0:0:1:2:3:4:5         ; Regard all built in stepper drivers as extruder drives
M669 K6                         ; "This is a Hangprinter"
M669 P2000.0                    ; Printable radius (unused by Hangprinters for now)
M669 S430 T0.1                  ; Segments per second and min segment length

; Output of auto calibration script for Hangprinter
;MAN CAL of mar 21/2023
M669 A0.0:-595:-29.3 B866:488:-29.3 C-831:493:-29.3 D0:0:2378.075

M666 Q0.03125 R76.0:76.0:76.0:76.0
; Explanation:
; ; M669 defines the positions of the anchors, expressed as X:Y:Z distances between a line's pivot points, when the machine is homed.
; ; M666 sets Q=spool buildup, R=spool radii (incl buildup, when homed)

M208 Z2158.72  ; set maximum Z somewhere below D anchor. See M669 ... D<number>
M208 S1 Z-20.0 ; set minimum Z

; The following values must also be in the auto calibration script for Hangprinter (if you plan to use it)
M666 U2:2:2:4         ; Mechanical advantages on ABCD
M666 O1:1:1:1         ; Number of lines per spool
M666 L20:20:20:20     ; Motor gear teeth of ABCD axes
M666 H255:255:255:255 ; Spool gear teeth of ABCD axes

; Flex compensation
; M666 W0.0
; AS OF MAY 14TH 2024, NEEDS TO UPDATE for alum and new extruder
M666 W1.3715                 ; Mover weighs 1 kg. Set to 0 to disable flex compensation.
M666 S49540.66713            ; Spring constant (rough approximation) for Garda 1.1 mm line (unit N/m).
                          ; The real value is somewhere between 20k and 100k.
                          ; Lower value gives more flex compensation.
M666 I0.0:0.0:0.0:0.0     ; Min planned force in four directions (unit N).
                          ; This is a safety limit. Should affect only exceptional/wrong moves,
                          ; for example moves outside of the reachable volume.
M666 X70.0:70.0:70.0:70.0 ; Max planned force in four directions (unit N)
                          ; This is a safety limit. Will affect moves close to
                          ; the limits of the reachable volume.
M666 T13.715                ; Desired target force (unit N).
                          ; The flex compensation algorithm aims for at least
                          ; this amount of force in the ABC line directions at all times.
                          ; It can be thought of as a minimum pre-tension value.
                          ; It's recommended to set it around 10 times higher
                          ; than your W (mover weight in kg) value.

; Guy wire lengths. Needed for flex compensation.
; Guy wires go between spool and final line roller.
; If your spools are all mounted on the D-anchor, on the ceiling plate, then you're all good,
; and you don't need to configure M666 Y values explicitly.
; If your spools are not all on the D-anchor then you must measure guy wire
; lengths and set them here.
; If your spools are all mounted on their respective anchors, so that you have no guy wires,
; then you should configure zeroed guy wire lengths M666 Y0.0:0.0:0.0:0.0.
;M666 Y-1.0:-1.0:-1.0:-1.0
M666 Y0.0:0.0:0.0:0.0

; Torque constants. These are required for reading motor forces from ODrives
; They are the same values as is configured in the ODrives themselves (8.27/330 for motors in the standard  HP4 BOM)
M666 C0.025061:0.025061:0.025061:0.025061

; Uncomment M564 S0 if you don't want G0/G1 moves to be be limited to a software defined volume
; M564 S0

; Drives
M666 J25:25:25:25 ; Full steps per ABCD motor revolution (match with ODrives...)

M569 P0 S0 ; Drive 0 goes forwards SIKE BACKWARDS
M569 P1 S1 ; Drive 1 goes forwards
M569 P2 S1 ; Drive 2 goes forwards
M569 P3 S1 ; Drive 3 goes forwards
M569 P4 S1 ; Drive 4 goes forwards
M569 P5 S1 ; Drive 5 goes forwards

;; Warning: On a Hangprinter, ABCD motor directions shouldn't be changed, at least not
;;          via this config.g file.
;;          They are duplicated and hard coded into the firmware
;;          to make ODrive's torque mode go the right way.
;;          Please connect BLDC wires, from left to right, looking at the board
;;          from the front, so that ODrive silk screen is readable from left to right:
;;          |---------------------------------------------------------------|
;;          |DC                                                             |
;;          |-                    ODrive                                    |
;;          |+                                                              |
;;          |                          AUX                                  |
;;          |--||---||---||------------------------------------||---||---||-|
;;             ||   ||   ||                                    ||   ||   ||
;; ALT 1:   Black, Red, Blue                                Black, Red, Blue
;; ALT 2:  Yellow, Black, Red                              Yellow, Black, Red

M569 P40.0 S1 ; Drive 40.0 (A) goes forwards
M569 P41.0 S1 ; Drive 41.0 (B) goes forwards
M569 P42.0 S0 ; Drive 42.0 (C) goes backwards
M569 P43.0 S0 ; Drive 43.0 (D) goes backwards

; Speeds and accelerations
M201 X10000 Y10000 Z10000 U10000 E1000       ; Max accelerations (mm/s^2)
M203 X36000 Y36000 Z36000 E3600              ; Max speeds (mm/min)
M204 P1000 T4000                            ; Accelerations while printing and for travel moves
M566 X240 Y240 Z1200 E1200                 ; Maximum instant speed changes mm/minute

; Currents
M906 E1200 I60             ; Set motor currents (mA) and increase idle current to 60%. Note: Toolboard 1LC stepper current is 1.6A peak. Recommended to keep extruder current below 1.4A(1400mA) 

; Endstops
M574 X0 Y0 Z0                                ; set endstop configuration (no endstops)

; Thermistors and heaters
; M308 S1 P"temp0" Y"pt1000" ; Configure sensor 1 as thermistor on temp1 SIKE jan7 2023 its now pt1000 GRAY WIRE
; M308 S1 P"temp0" Y"thermistor" T100000 B3950 ; BLUE WIRE THERMOSITOR

M308 S1 P"121.temp0" Y"thermistor" T100000 B4725 C7.06e-8 ; Configure sensor 1 as thermistor on temp0 of tool board 1LC (For REVO Hotend: Should work for both 40W and 60W Heater Cores)
M950 H1 C"121.out0" T1                                    ; create nozzle heater output on out0 of toolboard 1LC and map it to sensor 1
M307 H1 B0 S1.00                                          ; disable bang-bang mode for nozzle heater and set PWM limit
;M307 H1 R1.218 K0.362:0.000 D7.95 E1.35 S1.00 B0 V21.4 ; heater tuning using M303 H1 S400 on jan 31st, 2023
M143 H1 S285                                 ; set temp limit for nozzle heater to 285C
M570 S180                                    ; Hot end may be a little slow to heat up so allow it 180 seconds

; Fans
M950 F1 C"121.out2" Q500                         ; Create Fan 1 on pin 121.out2 and set its frequency
M106 P1 S1 H1 T45                                ; set fan 1 value. Thermostatic control is turned on @45degC

; Find "121.temp0" and "121.out2" pins in the wiring diagram:
; https://docs.duet3d.com/duet_boards/duet_3_can_expansion/duet3_tb_1lc_v1.3_d1.0_wiring.png

; Bltouch
; If you have a bltouch, see
; https://duet3d.dozuki.com/Wiki/Connecting_a_Z_probe#Section_BLTouch
; for how to install it
; Some of the commands below here might be different for you
; (eg if you don't have a Duet3 board, don't use the io7 headers, or have your bltouch mounted differently than me)
M950 S0 C"io7.out"
M558 P9 C"io7.in" H5 F120 T6000
G31 X15 Y27 Z8 P25 ; Measure these values in your own setup.

; These affect how you create and your mesh/grid bed compensation heightmap.csv values
; M557 X-200.001:200 Y-277.001:277 S80 ; Define a A2 sized grid with 1 cm margin...
; M376 H20 ; Taper the mesh bed compensation over 20 mm of z-height
; G29 S1 ; Load the default heightmap.csv and enable grid compensation


; Tool definitions    -->For more info on how to define tools, please refer to https://docs.duet3d.com/en/User_manual/Reference/Gcodes and look for M563. Very Important not to get wrong. 

; For the E3D Hemera REVO filament extruder
M563 P0 S"Hemera REVO" D0 H1 F0                  ; Tool number 0, with extruder drive E0 uses heater 1 and no partcooling fan. NOTE: E0 is NOT the stepper driver name on the board but rather the order in which extruders are defined in M584 after XYZ (i.e E0, E1..etc)
G10 P0 X0 Y0 Z0                                  ; set tool 0 axis offsets
G10 P0 S0 R0                                     ; Set initial tool 0 active at standby temperature 0


; Miscellaneous
M92 E391.50                                           ; Set extruder steps per mm
M911 S10 R11 P"M913 X0 Y0 Z0 G91 M83 G1 Z3 E-5 F1000" ; set voltage thresholds and actions to run on power loss
T0                                                 ; Select tool 0
