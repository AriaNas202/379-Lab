 .text
.global uart_init
.global gpio_btn_and_LED_init
.global output_character
.global read_character
.global read_string
.global output_string
.global read_from_push_btns
.global illuminate_LEDs
.global illuminate_RGB_LED
.global read_tiva_push_button
.global division
.global multiplication




uart_init:
PUSH {r4-r12,lr} ; Spill registers to stack


          ; Provide clock to UART0

    MOV r4, #0xE618
    MOVT r4, #0x400F
    ;LDR r0, [r4]

    MOV r1, #1

    STR r1, [r4]



    ; Enable clock to PortA
    MOV r4, #0xE608
    MOVT r4, #0x400F
    ;LDR r0, [r4]

    MOV r1, #1

    STR r1, [r4]



    ; Disable UART0 Control
    MOV r4, #0xC030
    MOVT r4, #0x4000
    ;LDR r0, [r4]

    MOV r1, #0

    STR r1, [r4]



    ; Set UART0_IBRD_R for 115,200 baud
    MOV r4, #0xC024
    MOVT r4, #0x4000
    ;LDR r0, [r4]
    MOV r1, #8
    STR r1, [r4]



    ; Set UART0_FBRD_R for 115,200 baud
    MOV r4, #0xC028
    MOVT r4, #0x4000
   ; LDR r0, [r4]

    MOV r1, #44

    STR r1, [r4]



    ; Use System Clock
    MOV r4, #0xCFC8
    MOVT r4, #0x4000
    ;LDR r0, [r4]

    MOV r1, #0

    STR r1, [r4]



    ; Use 8-bit word length, 1 stop bit, no parity
    MOV r4, #0xC02C
    MOVT r4, #0x4000
    ;LDR r0, [r4]

    MOV r1, #0x60

    STR r1, [r4]



    ; Enable UART0 Control
    MOV r4, #0xC030
    MOVT r4, #0x4000
    ;LDR r0, [r4]

    MOV r1, #0x301

    STR r1, [r4]



    ; Make PA0 and PA1 as Digital Ports
    MOV r4, #0x451C
    MOVT r4, #0x4000  ;r4 - address
    LDR r0, [r4] ;r0- address value

    ;LDR r1, [r0]

    ORR r1, r0, #0x03 ;masked value

    STR r1, [r4]



    ; Change PA0,PA1 to Use an Alternate Function
    MOV r4, #0x4420
    MOVT r4, #0x4000
    LDR r0, [r4] ;r0- address value

    ;LDR r1, [r0]

    ORR r1, r0, #0x03 ;masked value

    STR r1, [r4]



    ; Configure PA0 and PA1 for UART
    MOV r4, #0x452C
    MOVT r4, #0x4000
    LDR r0, [r4] ;r0- address value

    ;LDR r1, [r0]

    ORR r1, r0, #0x11 ;masked value

    STR r1, [r4]

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

gpio_btn_and_LED_init:
PUSH {r4-r12,lr} ; Spill registers to stack

;INIT FOR BUTTONS ALICE BOARD (Port D)

    ;SETUP Enable Clock (Port D, Pins 3-0) (Pin0==Switch5. Pin3==Switch2)
    MOV r1, #0xE608
    MOVT r1, #0x4000      ;put clock register in r1
    ADD r1, #0xF0000
    LDR r2, [r1]        ;loads current clock info into r2
    ORR r2, r2, #0x8       ;Ors the clock value with mask to set 3ed bit to 1
    STR r2, [r1]        ;store new clock with Port F enabled


    ;Port D, Pin 0,1,2,3
    ;Enable Direction for Pins (offset 0x400)
    MOV r1, #0x7000
    MOVT r1, #0x4000        ;Move base address for Port D in r1
    LDR r2, [r1, #0x400]    ;load pin direction register into r2

    BIC r2, r2, #0xF             ;sets Pin 0,1,2,3 bit to input
    STR r2, [r1, #0x400]    ;stores the masked value back in directional register


    ;Set as Digital
    LDR r2, [r1, #0x51C]    ;Loads Digital Mode Register into r2
    ORR r2, r2, #0xF            ;sets Pin 0,1,2,3 Bit with Mask to 1 (Enables Digital Mode)
    STR r2, [r1, #0x51C]    ;stores masked register back


    ;INIT for LEDs ALICE (Port B)

    ;SETUP Enable Clock (Port B, 1st bit)
    MOV r1, #0xE608
    MOVT r1, #0x4000      ;put clock register in r1
    ADD r1, #0xF0000
    LDR r2, [r1]        ;loads current clock info into r2
    ORR r2, r2, #0x02       ;!!!!!!Ors the clock value with mask to set 1st bit to 1
    STR r2, [r1]        ;store new clock with Port B enabled

    ;Port B, Pins 0,1,2,3 ;!!!!!!
    ;Enable Direction for Pins (offset 0x400)
    MOV r1, #0x5000
    MOVT r1, #0x4000    ;Move base address for Port B in r1
    LDR r2, [r1, #0x400]    ;load pin direction register into r2
    ORR r2,r2, #0xF         ;sets 0,1,2,3 to 1 (output)
    STR r2, [r1, #0x400]    ;stores the masked value back in directional register

    ;Set as Digital
    LDR r2, [r1, #0x51C]    ;Loads Digital Mode Register into r2
    ORR r2, r2, #0x0F            ;sets 1st  Bit with Mask to 1 (Enables Digital Mode)
    STR r2, [r1, #0x51C]    ;stores masked register back


;Init for Tiva Functions (Port F)

    ;SETUP Enable Clock (Port F, 5th bit)
    MOV r1, #0xE608
    MOVT r1, #0x4000      ;put clock register in r1
    ADD r1, #0xF0000
    LDR r2, [r1]        ;loads current clock info into r2
    ORR r2, r2, #0x20       ;Ors the clock value with mask to set 5th bit to 1
    STR r2, [r1]        ;store new clock with Port F enabled

    ;Port F, Pin 4 (input)
    ;Port F, Pin 1,2,3
    ;Enable Direction for Pins (offset 0x400)
    MOV r1, #0x5000
    MOVT r1, #0x4002        ;Move base address for Port F in r1
    LDR r2, [r1, #0x400]    ;load pin direction register into r2

    BIC r2, r2, #0x10             ;sets 5th bit to input (Pin 4)
    ORR r2,r2, #0xE ;sets 1,2,3 bit to 1 (output)
    STR r2, [r1, #0x400]    ;stores the masked value back in directional register

     ;Set as Digital
    LDR r2, [r1, #0x51C]    ;Loads Digital Mode Register into r2
    ORR r2, r2, #0x10            ;sets 5th Bit with Mask to 1 (Enables Digital Mode)
    ORR r2,r2, #0xE ;set 1,2,3 bit to 1
    STR r2, [r1, #0x51C]    ;stores masked register back

    ;Pull up reg
    LDR r2, [r1, #0x510]
    ORR r2, r2, #0x10             ;sets 5th bit to 1 (Pin 4)
    STR r2, [r1, #0x510]

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr


output_character:
PUSH {r4-r12,lr} ; Spill registers to stack


        MOV r1, #0xC018
        MOVT r1, #0x4000    ;load flag reg address in r1
        MOV r3, #0x20       ;load mask 5th bit in r3

Polling:
        LDRB r2, [r1]       ;load flag into r2
        AND r2,r2,r3        ;mask r2 to the 5th bit

        CMP r2, #0          ;does the mask flag == 0?
        BNE Polling         ;If r2!=0 (r2==1) then we keep polling until we get 1

        MOV r1, #0xC000
        MOVT r1, #0x4000    ;Load data address into r1

        STRB r0, [r1]       ;store argument in r0 into data register at r1

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

read_character:
PUSH {r4-r12,lr} ; Spill registers to stack

LOOP:
    MOV r4, #0xC000     ;UART base address
    MOVT r4, #0x4000
    LDRB r5, [r4, #0x18] ;Load from memory
    AND r5, r5, #0x10   ;Mask
    CMP r5, #0x10
    BEQ LOOP            ;If equal keep looping
    LDRB r0, [r4]       ;Store in r0

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

read_string:
PUSH {r4-r12,lr} ; Spill registers to stack

;ARGUMENTS
    ;r0- base address of stirng

    MOV r4,r0           ;move the base address into r4

LOOP1:
    BL read_character   ;Call read_character (current char in r0)
    BL output_character ;Call output_character

    CMP r0, #0xD        ;Is r0 = Enter?
    BEQ DONE            ;If yes, go to DONE

    STRB r0, [r4]       ;If no, store r0 in memory
    ADD r4, r4, #1      ;Increment r4 to the next memory address
    B LOOP1             ;Loop and repeat until r0 = Enter

DONE:
    MOV r0, #0x0         ;store NULL in r0
    STRB r0, [r4]       ;store NULL in memory

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

output_string:
PUSH {r4-r12,lr} ; Spill registers to stack

;ARGUMENTS
    ;r0    - Original Base of string address
    ;      - Will turn into "current char" argument
    ;r4    - New base of String Address

    MOV r4, r0              ;copy base address into r4

GetChar:
    LDRB r0, [r4]           ;load current char into r0

    CMP r0, #0              ;compare current char to NULL (Is this the End of the String?)
    BEQ EndOutputString     ;If current char is NULL, were done printing the string, branch to end

    BL output_character     ;call function to print char in r0 as argument

    ADD r4,r4,#1            ;incrament base address to the next char

    B GetChar               ;Branch to handle the next char


EndOutputString:

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

read_from_push_btns:
PUSH {r4-r12,lr} ; Spill registers to stack

          ;r0- return value
          ;r1- base address (port D)
          ;r2- data register
          ;r3 - masked data

          MOV r0, #0 ;init return value to 0

          MOV r1, #0x7000
     MOVT r1, #0x4000        ;Move base address for Port D in r1
      ;Get Register which reads the buttons
     LDR r2, [r1, #0x3FC]    ;Puts the data from reg into r2

     ;read button 2 (pin 3, 4th bit) (MSB)
     AND r3, r2, #0x08 ;mask 4th bit to read button 2

     CMP r3, #0x0 ;compare button push to 0
     BEQ Button5 ;if button is  0, then its NOT pushed, skip adding 1 (button is not pushed)

     ;store 1 in MSB
     ADD r0, r0, #0x80000000 ;button 2 is pushed, store MSB



Button5:

;read button 5 (pin 0, 1st bit) (LSB)
     AND r3, r2, #0x01 ;mask 1st bit to read button 5

     CMP r3, #0x0 ;compare button push to 0
     BEQ DoneButtons ;if button is  0, then its NOT pushed, skip adding 1 (button is not pushed)

     ADD r0,r0,#0x1 ;button 5 is pushed, store LSB

DoneButtons:



POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

illuminate_LEDs:


    PUSH {r4-r12,lr} ; Spill registers to stack


    ;r0 bit pattern

    ;r1 - address of port B
    ;r2- data reg



    MOV r1, #0x5000
    MOVT r1, #0x4000    ;Move base address for Port B in r1

    ;Get Register which controls the light
    LDRb r2, [r1, #0x3FC]    ;Puts the data from reg into r2



MOV r7, #0xF
BIC r2, r2, r7

    ORR r2,r2,r0    ;store bits into data reg

    ;store the updated data reg BACK
    STRb r2, [r1, #0x3FC]    ;Puts the data BACK with Appropriate Lights



    POP {r4-r12,lr}   ; Restore registers from stack
    MOV pc, lr



illuminate_RGB_LED:
PUSH {r4-r12,lr} ; Spill registers to stack


    ;ro- Color to be displayed

    ;r1- address bucket
    ;r2- regsiter data bucket
    ;r3 - trash

    ;Red    1    (pin 1)
    ;Blue   2    (pin 2)
    ;Green  3    (pin 3)
    ;Purple 4    (pin 1 and 2) (Red and Blue)
    ;Yellow 5    (Pin 1 and 3) (Green and Red)
    ;White  6    (All Pins) (Red, Blue, Green)



    ;Get Register which controls the light
    MOV r1, #0x5000
    MOVT r1, #0x4002 ; base address for GPIO Port F
    LDR r2, [r1, #0x3FC]    ;Puts the data from reg into r2

    ;Figure out what color the light is supposed to be
    CMP r0, #1
    BEQ Red     ;If red branch to red
    CMP r0, #2
    BEQ Blue    ;If blue branch to blue
    CMP r0, #3
    BEQ Green   ;If hreen branch to green
    CMP r0, #4
    BEQ Purple  ;If purple branch to purple
    CMP r0, #5
    BEQ Yellow  ;If yellow branch to yellow

    B White     ;None of the other colors were right, so it must be white




    ;Set r2 to appropriate value for color
Red:
    ORR r2, r2, #0x2        ;set Pin 1
    BIC r2, r2, #0xC     ;clears Pin 2 and 3
    B IllDone

Blue:
    ORR r2, r2, #0x4        ;set Pin 2
    BIC r2, r2, #0xA     ;clears Pin 1 and 3
    B IllDone

Green:
    ORR r2, r2, #0x8    ;set Pin 3
    BIC r2, r2, #0x6     ;clears Pin 1 and 2
    B IllDone

Purple:
    ORR r2, r2, #0x6       ;set Pin 1 and 3
    BIC r2, r2, #0x8     ;clears Pin 2
    B IllDone

Yellow:
    ORR r2, r2, #0xA       ;set Pin 1 and 2
    BIC r2, r2, #0x4     ;clears Pin 3
    B IllDone

White:
    ORR r2, r2, #0xE        ;set Pin 1 and 2 and 3
    B IllDone


IllDone:

    STR r2, [r1, #0x3FC]    ;Puts the data BACK with Appropriate color


POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

read_tiva_push_button:
PUSH {r4-r12,lr} ; Spill registers to stack



MOV r2, #0x5000
    MOVT r2, #0x4002 ; base address for GPIO Port F
    LDRB r3, [r2, #0x3FC] ; load byte into r3 with offset

    AND r3, r3, #0x10 ; check if the bit is 1
    CMP r3, #0x10 ; is button pressed ?
    BEQ NOTPRESSED          ; No
    MOV r0, #1 ; Yes
    B DONEEE

NOTPRESSED:
MOV r0, #0

DONEEE:

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr









;remember to add these plzzzz
division:
PUSH {r4-r12,lr} ; Spill registers to stack

          ; Your code is placed here

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr

multiplication:
PUSH {r4-r12,lr} ; Spill registers to stack

          ; Your code is placed here

POP {r4-r12,lr}   ; Restore registers from stack
MOV pc, lr



.end
