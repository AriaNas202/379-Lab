	.data

	.global prompt
	.global mydata
	.global flag


prompt:	.string "Your prompt with instructions is place here", 0
mydata:	.byte	0x20	; This is where you can store data.
			; The .byte assembler directive stores a byte
			; (initialized to 0x20 in this case) at the label
			; mydata.  Halfwords & Words can be stored using the
			; directives .half & .word
flag: .word	0x00

	.text

	.global uart_interrupt_init
	.global gpio_interrupt_init
	.global UART0_Handler
	.global Switch_Handler
	.global Timer_Handler		; This is needed for Lab #6
	.global simple_read_character	; read_character modified for interrupts
	.global output_character	; This is from your Lab #4 Library
	.global read_string		; This is from your Lab #4 Library
	.global output_string		; This is from your Lab #4 Library
	.global uart_init		; This is from your Lab #4 Library
	.global lab5

ptr_to_prompt:		.word prompt
ptr_to_mydata:		.word mydata
ptr_to_flag: 		.word flag

lab5:				; This is your main routine which is called from
				; your C wrapper.
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS
	ldr r4, ptr_to_prompt
	ldr r5, ptr_to_mydata
	ldr r6, ptr_to_flag

 	bl uart_init
	bl uart_interrupt_init
	bl gpio_interrupt_init

	MOV r0, #0x0
	MOV r1, r6
	STR r0, [r6]

Infin:

	ADD r3,r3,#0x0
	B Infin

	; This is where you should implement a loop, waiting for the user to
	; indicate if they want to end the program.

	POP {lr}		; Restore registers to adhere to the AAPCS
	MOV pc, lr



uart_interrupt_init:

	; Your code to initialize the UART0 interrupt goes here

	;Set UART Interrupt Mask Reg
	MOV r0, #0xC000
	MOVT r0, #0x4000
	LDR r1, [r0, #0x038]

	ORR r1,r1, #0x10	;set 5th bit

	STR r1, [r0, #0x038]


	;Config Processor to Allow UART Interrupts
	MOV r0, #0xE000
	MOVT r0, #0xE000
	LDR r1, [r0, #0x100]

	ORR r1,r1,#0x20

	STR r1, [r0, #0x100]

	MOV pc, lr


gpio_interrupt_init:

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






    ;Init for GPIO Interrupt

    ;Config For Edge Level Sensitivity
    MOV r0, #0x5000
    MOVT r0, #0x4002
    LDR r1, [r0, #0x404]

    BIC r1,r1,#0x10

    STR r1, [r0, #0x404]



    ;Select Single Edge Trigger
    MOV r0, #0x5000
    MOVT r0, #0x4002
    LDR r1, [r0, #0x408]

    BIC r1,r1,#0x10

    STR r1, [r0, #0x408]

    ;Select Falling  Edge Direction
    MOV r0, #0x5000
    MOVT r0, #0x4002
    LDR r1, [r0, #0x40C]

    BIC r1,r1,#0x10

    STR r1, [r0, #0x40C]

    ;Config GPIO To allow Interrupts
    MOV r0, #0x5000
    MOVT r0, #0x4002
    LDR r1, [r0, #0x410]

    ORR r1,r1,#0x10

    STR r1, [r0, #0x410]

    ;Config Processor to Allow Interrupts from GPIO
    MOV r0, #0xE000
    MOVT r0, #0xE000
    LDR r1, [r0,#0x100]

    ORR r1,r1,#0x40000000

    STR r1, [r0,#0x100]

	MOV pc, lr


UART0_Handler:

    ; Your code for your UART handler goes here.
    ; Remember to preserver registers r4-r12 by pushing then popping
    ; them to & from the stack at the beginning & end of the handler
    PUSH{r4-r12, lr}

    ;CURRENTLY Were storing the "flag" in r0, (should we store it in memory?????)
    ;r0- flag (changed to be char for read character)
    ;r1- address to flag
    ;r4- will be flag after read char

    ;Clear the interrupt
    MOV r2, #0xC000
    MOVT r2, #0x4000
    LDR r3, [r2, #0x044]

    ORR r3, #0x10

    STR r3, [r2, #0x044]


    ;Handle Interrupt
    ldr r1, ptr_to_flag
    LDR r0, [r1]

    MOV r4, r0 ;temporarily store flag in r4
    BL simple_read_character  ;stores current char in r0

    ;r0- char
    ;r4- flag
    ;r1- address of flag

    ;What does the flag tell us to do? (ie, flag determines how we respond)
    CMP r4, #0x00
    BEQ UartFlag0   ;Flag 0
    CMP r4, #0x01
    BEQ UartFlag1   ;Flag 1
    CMP r4, #0x02
    BEQ UartFlag2   ;Flag 2
    CMP r4, #0x05
    BEQ UartFlag5   ;Flag 5
    B UartEnd       ;Else, whatever the flag is, we dont touch it



UartFlag0:
    ;flag is 0 (waiting for game start)
    ;DId user input "G"???
    CMP r0, #'G'
    BNE UartEnd     ;If user didnt input G to start, we dont do anything
    ;If we made it here, user input G, game will start
    MOV r0, #0x1    ;set flag to 1 (start game polling)
    STR r0, [r1]	;store flag in memory
    B UartEnd




UartFlag1:
    ;flag is 1 (Game Polling)
    ;DId user input " " (space)???
    CMP r0, #' '
    BNE UartEnd     ;If user didnt input a space, we dont do anything
    ;If we made it here, user input a space, pushed too early
    MOV r0, #0x3    ;set flag to 3 (uart pushed too early)
    STR r0, [r1]	;store flag in memory
    B UartEnd


UartFlag2:
    ;flag is 2 (SW1 Pushed too early, game still polling)
    ;DId user input " " (space)???
    CMP r0, #' '
    BNE UartEnd     ;If user didnt input a space, we dont do anything
    ;If we made it here, user input a space, BOTH pushed too early
    MOV r0, #0x4    ;set flag to 4 (BOTH pushed too early)
    STR r0, [r1]	;store flag in memory
    B UartEnd



UartFlag5:
    ;flag is 5 The Light is Green, No winners yet!!!!)
    ;DId user input " " (space)???
    CMP r0, #' '
    BNE UartEnd     ;If user didnt input a space, we dont do anything
    ;If we made it here, user input a space, Uart Wins!!!!!
    MOV r0, #0x7    ;set flag to 7 (UART/ Putty Wins!!!!)
    STR r0, [r1]	;store flag in memory
    B UartEnd


UartEnd:

    POP{r4-r12, lr}

    BX lr           ; Return


Switch_Handler:

    ; Your code for your UART handler goes here.
    ; Remember to preserver registers r4-r12 by pushing then popping
    ; them to & from the stack at the beginning & end of the handler
    PUSH{r4-r12, lr}

    ;CURRENTLY Were storing the "flag" in r0, (should we store it in memory?????)
    ;r0- flag (changed to be char for read character)
    ;r1- address to flag
    ;r4- will be flag after read char

    ;Clear the interrupt
    MOV r2, #0x5000
    MOVT r2, #0x4002
    LDR r3, [r2, #0x041C]

    ORR r3, #0x10

    STR r3, [r2, #0x041C]


    ;Handle Interrupt
    ldr r1, ptr_to_flag
    LDR r0, [r1]



    ;r0- flag
    ;r1- address of flag

    ;What does the flag tell us to do? (ie, flag determines how we respond)
    ;1,3,5
    CMP r0, #0x01
    BEQ SwitchFlag1   ;Flag 1
    CMP r0, #0x03
    BEQ SwitchFlag3   ;Flag 3
    CMP r0, #0x05
    BEQ SwitchFlag5   ;Flag 5
    B SwitchEnd       ;Else, whatever the flag is, we dont touch it


SwitchFlag1:
    ;flag is 1 (Game Polling)
    ;If we made it here, user input a space, pushed too early
    MOV r0, #0x2    ;set flag to 2 (switch pushed too early)
    STR r0, [r1]	;store flag in memory
    B SwitchEnd


SwitchFlag3:
    ;flag is 3 (Uart/Putty Pushed too early, game still polling)
    ;If we made it here, user input a space, BOTH pushed too early
    MOV r0, #0x4    ;set flag to 4 (BOTH pushed too early)
    STR r0, [r1]	;store flag in memory
    B SwitchEnd



SwitchFlag5:
    ;flag is 5 The Light is Green, No winners yet!!!!)
    ;If we made it here, user input a space, Uart Wins!!!!!
    MOV r0, #0x6    ;set flag to 6 (Switch Wins!!!)
    STR r0, [r1]	;store flag in memory
    B SwitchEnd


SwitchEnd:

    POP{r4-r12, lr}

    BX lr           ; Return


Timer_Handler:

	; Your code for your Timer handler goes here.  It is not needed for
	; Lab #5, but will be used in Lab #6.  It is referenced here because
	; the interrupt enabled startup code has declared Timer_Handler.
	; This will allow you to not have to redownload startup code for
	; Lab #6.  Instead, you can use the same startup code as for Lab #5.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler.

	BX lr       	; Return


simple_read_character:
	PUSH {r4-r12,lr} ; Spill registers to stack

    MOV r4, #0xC000     ;UART base address
    MOVT r4, #0x4000
    LDRB r5, [r4, #0x18] ;Load from memory
    LDRB r0, [r4]       ;Store in r0

	POP {r4-r12,lr}   ; Restore registers from stack

	MOV pc, lr	; Return







	.end



