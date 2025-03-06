.data

    .global prompt
    .global dividend
    .global divisor
    .global remainder

prompt1: .string "Enter Dividend:", 0
prompt2: .string "Enter Divisor:", 0
prompt3: .string "Your Remainder is:", 0
prompt4: .string "Continue? (y/n)", 0
dividend: .string "Place holder string for your dividend", 0
divisor: .string "Place holder string for your divisor", 0
remainder: .string "Your remainder is stored here", 0



    .text

    .global lab3
U0FR:   .equ 0x18   ; UART0 Flag Register

ptr_to_prompt1:         .word prompt1
ptr_to_prompt2:         .word prompt2
ptr_to_prompt3:         .word prompt3
ptr_to_prompt4:         .word prompt4
ptr_to_dividend:        .word dividend
ptr_to_divisor:         .word divisor
ptr_to_remainder:       .word remainder

lab3:
    PUSH {r4-r12,lr}                ; Store any registers in the range of r4 through r12
                                    ; that are used in your routine.  Include lr if this
                                    ; routine calls another routine.


    ldr r4, ptr_to_prompt1
    ldr r5, ptr_to_dividend
    ldr r6, ptr_to_divisor
    ldr r7, ptr_to_remainder
    ldr r8, ptr_to_prompt2
    ldr r9, ptr_to_prompt3
    ldr r12, ptr_to_prompt4

                                    ; Your code is placed here.  This is your main routine for
                                    ; Lab #3.  This should call your other routines such as
                                    ; uart_init, read_string, output_string, int2string, & string2int


    BL uart_init                    ;Initialize Configs (commented out for now)



lab3Loop:



    ;Prompt Dividend
    MOV r0, r4                      ;Put dividend prompt in r0 argument reg
    BL output_string                ;Print the prompt to screen



    ;Store Dividend
    MOV r0, r5                      ;Put Dividend Storage address in r0 argument reg
    BL read_string                  ;Read prompt, stored in memory
    MOV r0, #0xA
    BL output_character             ;prints newline after displaying Divisor Typed value


    ;Promt Divisor
    MOV r0, r8                      ;Put divisor prompt in r0 as argument
    BL output_string                ;Print the prompt to screen


    ;Store Divisor
    MOV r0, r6                      ;Put divisor stroage address in r0 argument reg
    BL read_string                  ;Read prompt, stored in memory
    MOV r0, #0xA
    BL output_character             ;prints newline after displaying Divisor Typed value


    ;Convert Dividend String to Int
    MOV r0, r5                      ;Put Dividend Storage address in r0 argument reg
    BL string2int                   ;Gets Dividend, Returns in r0
    MOV r10, r0                     ;Puts Dividend in r10 (for storage)

    ;Convert Divisor String to Int
    MOV r0, r6                      ;Put divisor stroage address in r0 argument reg
    BL string2int                   ;Get Divisor, Returns in r0
    MOV r11, r0                     ;Puts Divisor in r11 (for storage)


    ;Calculate Remainder (r10 % r11)
    UDIV r0, r10, r11               ;r0 = r10/r11 (gets quotient and stores in r0)
    MUL r0, r0, r11                 ; r0 = r0*r11 (gets dividend number without remainder)
    SUB r0, r10, r0                 ; r0= r10-r0 (sub dividend by dividend without remainder to get remainder) (remainder stored in r0)

    ;Convert Remainder to String
    MOV r1, r0                      ;stores int (remainder) to be converted in argument reg r1
    MOV r0, r7                      ;stores remainder address in argument reg r0
    BL int2string                   ;converts remainder to string, stored in memory

    ;Display Result Message
    MOV r0, r9                      ;Put Remainder Result prompt in argument reg r0
    BL output_string                ;Prints Remainder message to screen


    ;Display Remainder
    MOV r0, r7                      ;Put remainder number in argument reg r0
    BL output_string                ;prints remainder number to screen
    MOV r0, #0xA
    BL output_character             ;prints newline after displaying Divisor Typed value
     MOV r0, #0xD
    BL output_character             ;prints newline after displaying Divisor Typed value



    ;Continue?
    MOV r0, r12                     ;puts continue promt to screen
    BL output_string                ;prints continue prompt to screen


    ;read response
    BL read_character               ;reads N or Y
    MOV r10, r0                     ;put response in r10 for storage until print is over
    BL output_character             ;prints N or Y for feedback of response
    MOV r0, #0xA
    BL output_character             ;prints newline after displaying Divisor Typed value
     MOV r0, #0xD
    BL output_character             ;prints newline after displaying Divisor Typed value

    CMP r10, #'n'                   ;Did the user input n?
    BNE  lab3Loop                   ;if user didnt input 'n' it means we wanna continue to loop



lab3_end:

    POP {r4-r12,lr}                 ; Restore registers all registers preserved in the
                ; PUSH at the top of this routine from the stack.
    mov pc, lr




uart_init:
    PUSH {r4-r12,lr}    ; Store any registers in the range of r4 through r12
                ; that are used in your routine.  Include lr if this
                ; routine calls another routine.

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

    POP {r4-r12,lr}     ; Restore registers all registers preserved in the
                ; PUSH at the top of this routine from the stack.
    mov pc, lr


read_character:
    PUSH {r4-r12,lr}    ; Store any registers in the range of r4 through r12
                ; that are used in your routine.  Include lr if this
                ; routine calls another routine.

        ; Your code for your read_character routine is placed here
LOOP:
    MOV r4, #0xC000     ;UART base address
    MOVT r4, #0x4000
    LDRB r5, [r4, #0x18] ;Load from memory
    AND r5, r5, #0x10   ;Mask
    CMP r5, #0x10
    BEQ LOOP            ;If equal keep looping
    LDRB r0, [r4]       ;Store in r0

    POP {r4-r12,lr}     ; Restore registers all registers preserved in the
                ; PUSH at the top of this routine from the stack.
    mov pc, lr


read_string:
    PUSH {r4-r12,lr}    ; Store any registers in the range of r4 through r12
                        ; that are used in your routine.  Include lr if this
                        ; routine calls another routine.

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
    POP {r4-r12,lr}     ; Restore registers all registers preserved in the
                        ; PUSH at the top of this routine from the stack.
    mov pc, lr


output_character:
    PUSH {r4-r12,lr}    ; Store any registers in the range of r4 through r12
                ; that are used in your routine.  Include lr if this
                ; routine calls another routine.

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

    POP {r4-r12,lr}     ; Restore registers all registers preserved in the
                ; PUSH at the top of this routine from the stack.
    mov pc, lr


output_string:
    PUSH {r4-r12,lr}        ; Store any registers in the range of r4 through r12
                            ; that are used in your routine.  Include lr if this
                            ; routine calls another routine.

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

    POP {r4-r12,lr}         ; Restore registers all registers preserved in the
                            ; PUSH at the top of this routine from the stack.
    mov pc, lr


int2string:
    PUSH {r4-r12,lr}        ; Store any registers in the range of r4 through r12
                            ; that are used in your routine. Include lr if this
                            ; routine calls another routine.



    ;Arguments
    ;r0- base address to store string
    ;r1- int to convert
    ;r2- will become current digit argument
    ;r3- comma counter (init to 0)
    ;r4- comma address (has comma hex value stored in it)
    ;r5- has 10 stored for mod operations
    ;r6- trash
    ;;;;;;;Converts all Digits (as ints) in stack to a string
    MOV r3, #0       ;init comma counter to 0
    MOV r4, #','     ;init comma register to ','
    MOV r5, #10  ;stores 10





    ;;;;;;;;Push a terminator so stack knows when to stop
    MOV r2, #0xFF   ;using 0xFF as stack terminator
    PUSH {r2}       ;push terminator to stack



    ;;;;;;;;Handle Base Case 0 (if number were converting is 0 originally)
    CMP r1, #0              ;Is originally in == 0?
    BNE ConvertToDigits     ;If out int isnt originally 0 we need to convert it to digits, so branch

    MOV r2, r1              ;Moves r1 (0 int) into r2 so CovertToString works
    PUSH {r2}               ;Pushes r2 (0 int) to stack
    B ConvertToString       ;Branches to covert 0 into a string



    ;;;;;;;;Converts all digits to stack until r1 (original int) is 0
ConvertToDigits:

    ;Check if r1 is 0 yet
    CMP r1, #0              ;Is r1 0 yet?
    BEQ ConvertToString     ;If r1 is 0 then its time to convert into a string

    ;Modulo by 10 (To get rightmost digit)
    UDIV r2,r1, r5          ;r2=r1/10
    MUL r2, r2, r5         ; r2=r2*10
    SUB r2, r1, r2          ; r2=r1-r2 (this should store rightmost digit in r2)

    CMP r3, #3 ;compare comma counter to 3
    BNE NoComma1            ;compare comma counter to 3
    MOV r6, r2              ;if comma counter isnt 3, we can skip adding a comma
    MOV r2, r4              ;temporarily store digit in r2 into r6
    PUSH {r2}               ;store ',' in r2
    MOV r2, r6              ;restore digit in r2


NoComma1:
    PUSH {r2}               ;push current digit (as an int) to stack
    ADD r3,r3,#1 ;increment comma counter
    UDIV r1, r1, r5        ;move the whole int right by 1 digit (ex. 123 -> 12)
    B ConvertToDigits       ;branch back to loop to continure to convert r1 until its 0




;;;;;
ConvertToString:

    POP {r2}                ;get digit to convert into string


    CMP r2, #0xFF           ;Did we reach the stack terminator yet?
    BEQ EndInt2Str          ;If weve hit the stack terminator, were at the EndInt2Str

    CMP r2, r4
    BNE NoComma2

    STRB r4, [r0]            ;add a comma (which is in r4) at memory address in r0


    ADD r0, r0, #1           ;increment address for next char
    POP {r2}


NoComma2:
    ADD r2,r2,#0x30         ;Turn r2 int into ascii
    STRB r2, [r0]           ;Stores current char (r2) into r0 address
    ADD r0,r0,#1            ;Increment address for next char
    ADD r3, r3, #1          ;Increment comma counter by 1
    B ConvertToString


    ;;;;;;;
EndInt2Str:

    MOV r2,#0               ;Stores null terminator in r2
    STRB r2, [r0]           ;Stores null terminator in memory



    POP {r4-r12,lr}         ; Restore registers all registers preserved in the
                            ; PUSH at the top of this routine from the stack.
    mov pc, lr





string2int:
    PUSH {r4-r12,lr}        ;Store any registers in range of r4 to r12
                            ; that are used in your routine. Include li if this
                            ;routine calls another routine.
    ;ARGUMENTS
    ;ro - base address of string
    ;r4 - inputted character
    ;r5 - negative flag
    ;r6 - decimal place
    ;r7- store 10 in

    MOV r4, #0          ;Init imputted char to 0
    MOV r6, #0          ;Init Decimal Place to 0

LOOP2:


    LDRB r4, [r0]       ;load current char into r4

    CMP r4, #0x0        ;Compare char to NULL (are we at end of string?)
    BEQ LOAD            ;If we are at end, go to Load the string

    CMP r4, #0x2C       ;compare char to ',' (Is this a comma?)
    BEQ Comma           ;branch to "Comma" label which increments mem address and gets next char


                ;deleted negative number stuff

    SUB r4, r4, #0x30   ;convert ascii into int (by subbing 0x30)
    MOV r7, #10
    MUL r6, r6, r7     ;multiply accumulated number by 10
    ADD r6, r6, r4      ;Accumalates number
Comma:
    ADD r0, r0, #1      ;increment r0 to the next memory address
    B LOOP2             ;loop and repeat until character = NULL


LOAD:
    MOV r0, r6          ;stores final number into r0



    POP {r4-r12,lr}     ; Restore registers all registers preserved in the
                        ; PUSH at the top of this routine from the stack


; Additional subroutines may be included here


    .end
