.data

    .global prompt

prompt1:        .string "Choose Your Test and Hit Enter:", 0xA, 0xD, 0
prompt2:        .string "Test Tiva Press Buttons (Press 1)", 0xA, 0xD, 0
prompt3:        .string "Test Tiva LED Color Lights (Press 2)", 0xA, 0xD, 0
prompt4:        .string "Test Alice Board Press Buttons (Press 3)", 0xA, 0xD, 0
prompt5:        .string "Test Alice LED Light Patterns (Press 4)",0xA, 0xD, 0
prompt6:        .string "Quit (Press 5)",0xA, 0xD, 0
test1_pushed: .string "The Tiva Button was Pushed!", 0xA,0xD, 0
test1_not_pushed: .string "The Tiva Button was NOT Pushed!", 0xA,0xD, 0
test2_lights:          .string "Red (Press 1), Blue (Press 2), Green (Press 3), Purple (Press 4), Yellow (Press 5), White (Press 6)", 0xA,0xD, 0
test3_both: .string "Both Alice Buttons were Pushed!", 0xA,0xD, 0
test3_5: .string "Button 5 Was Pushed!", 0xA,0xD, 0
test3_2: .string "Button 2 Was Pushed!", 0xA,0xD, 0
test3_none: .string "Neither Was Pushed!", 0xA,0xD, 0
test4_L0: .string "Do you Want Light 0 On? (1=yes, 0=no):", 0xA,0xD, 0
test4_L1: .string "Do you Want Light 1 On? (1=yes, 0=no):", 0xA,0xD, 0
test4_L2: .string "Do you Want Light 2 On? (1=yes, 0=no):", 0xA,0xD, 0
test4_L3: .string "Do you Want Light 3 On? (1=yes, 0=no):", 0xA,0xD, 0






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
.global lab4


ptr_to_prompt1:     .word prompt1
ptr_to_prompt2:     .word prompt2
ptr_to_prompt3:     .word prompt3
ptr_to_prompt4:     .word prompt4
ptr_to_prompt5:     .word prompt5
ptr_to_prompt6:     .word prompt6
ptr_to_test2_lights:         .word test2_lights
ptr_to_test1_pushed:        .word test1_pushed
ptr_to_test1_not_pushed:    .word test1_not_pushed
ptr_to_test3_both: .word test3_both
ptr_to_test3_5: .word test3_5
ptr_to_test3_2: .word test3_2
ptr_to_test3_none: .word test3_none
ptr_to_test4_L0: .word test4_L0
ptr_to_test4_L1: .word test4_L1
ptr_to_test4_L2: .word test4_L2
ptr_to_test4_L3: .word test4_L3


lab4:
    PUSH {r4-r12,lr}    ; Spill registers to stack

    ;Init the uart & gpio
    BL uart_init
    BL gpio_btn_and_LED_init


Menu:
MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;Go to newline for testing for readability

    ;Print the Menu Screen
    ldr r0, ptr_to_prompt1
    BL output_string
    ldr r0, ptr_to_prompt2
    BL output_string
    ldr r0, ptr_to_prompt3
    BL output_string
    ldr r0, ptr_to_prompt4
    BL output_string
    ldr r0, ptr_to_prompt5
    BL output_string
    ldr r0, ptr_to_prompt6
    BL output_string


    ;Get User Input
    BL read_character   ;now r0 should have user input in it
    MOV r4, r0          ;move user input into r4 for save keeping
    BL output_character ;prints the user input for user experience
    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;prints newline and carrage return for user experience

    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;Go to newline for testing for readability


    ;Which Test are we Running (Analyze Input)
    CMP r4, #0x31       ;Is input == 1 (run test 1)
    BEQ Test1
    CMP r4, #0x32       ;Is input ==2 (run test 2)
    BEQ Test2
    CMP r4, #0x33       ;Is input == 3 (run test 3)
    BEQ Test3
    CMP r4, #0x34       ;Is input == 4 (run test 4)
    BEQ Test4
    B Quit             ;Otherwise quit



;Test the Tiva Button
Test1:

    ;print prompt for test1
    ;ldr r0, ptr_to_test1
    BL read_tiva_push_button ;r0 1 if pushed

    CMP r0, #0x1
    BNE NotPushedTiva ;handle if not pushed

    ldr r0, ptr_to_test1_pushed;if we made it here it was pushed
    BL output_string
    B Menu

NotPushedTiva:
ldr r0, ptr_to_test1_not_pushed;if we made it here it was pushed
    BL output_string
    B Menu





;Test Tiva Color Lights
Test2:
;print prompt test 2 tiva lights
ldr r0, ptr_to_test2_lights
BL output_string

;Get User Input
    BL read_character   ;now r0 should have user input in it
    MOV r4, r0          ;move user input into r4 for save keeping
    BL output_character ;prints the user input for user experience
    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;prints newline and carrage return for user experience

    ;Analyze input in r4
    SUB r4, r4, #0x30 ;turn number from ascii into int
    MOV r0, r4 ;move argument into r0
    BL illuminate_RGB_LED

    B Menu



;Alice Board Buttons
Test3:


    BL read_from_push_btns ;r0 (2 MSB, 5LSB) if pushed

MOV r2, #0x0001
MOVT r2, #0x8000
    CMP r0, r2 ;both pushed
    BEQ AliceBothPushed


    CMP r0, #0x1 ;only button 5
    BEQ Alice5Pushed

    CMP r0, #0x0
    BEQ AliceNoPush

    ;If we made it here, Only Button 2 pushed
    ldr r0, ptr_to_test3_2
    BL output_string
    B Menu

AliceBothPushed:
ldr r0, ptr_to_test3_both
BL output_string
B Menu

Alice5Pushed:
ldr r0, ptr_to_test3_5
BL output_string
B Menu

AliceNoPush:
ldr r0, ptr_to_test3_none
BL output_string
B Menu




;Alice Board Light Pattern
Test4:

;Print Promt 1
ldr r0, ptr_to_test4_L0
BL output_string

;Get User Input (Light 0 in r4)
    BL read_character   ;now r0 should have user input in it
    MOV r4, r0          ;move user input into r4 for save keeping
    BL output_character ;prints the user input for user experience
    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;prints newline and carrage return for user experience

    ;Print Promt 2
ldr r0, ptr_to_test4_L1
BL output_string

;Get User Input (Light 1 in r5)
    BL read_character   ;now r0 should have user input in it
    MOV r5, r0          ;move user input into r5 for save keeping
    BL output_character ;prints the user input for user experience
    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;prints newline and carrage return for user experience


    ;Print Promt 3
ldr r0, ptr_to_test4_L2
BL output_string

;Get User Input (Light 2 in r6)
    BL read_character   ;now r0 should have user input in it
    MOV r6, r0          ;move user input into r6 for save keeping
    BL output_character ;prints the user input for user experience
    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;prints newline and carrage return for user experience

       ;Print Promt 4
ldr r0, ptr_to_test4_L3
BL output_string

;Get User Input (Light 3 in r7)
    BL read_character   ;now r0 should have user input in it
    MOV r7, r0          ;move user input into r7 for save keeping
    BL output_character ;prints the user input for user experience
    MOV r0, #0xA
    BL output_character
    MOV r0, #0xD
    BL output_character ;prints newline and carrage return for user experience

    ;Turn prompt into ints from ascii
    SUB r4, r4, #0x30
    SUB r5, r5, #0x30
    SUB r6, r6, #0x30
    SUB r7, r7, #0x30

    ;Shift Promts to be at proper bits
    LSL r5, r5, #1
    LSL r6,r6, #2
    LSL r7,r7,#3

    ;Combine Promts into argument
    ORR r0, r4,r5
    ORR r0, r0, r6
    ORR r0, r0, r7

    ;Call Fucntion and Print
    BL illuminate_LEDs

    B Menu





Quit:




    POP {r4-r12,lr}     ; Restore registers from stack
    MOV pc, lr


.end
