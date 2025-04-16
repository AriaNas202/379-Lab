	.data

	.global prompt
	.global mydata

prompt:	.string "Your prompt with instructions is place here", 0
count: .word 	0x30
names: .string "Jas and Arianna", 0

mydata:	.byte	0x20	; This is where you can store data.
			; The .byte assembler directive stores a byte
			; (initialized to 0x20 in this case) at the label
			; mydata.  Halfwords & Words can be stored using the
			; directives .half & .word

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
ptr_to_count:		.word count
ptr_to_names:		.word names

lab5:				; This is your main routine which is called from
				; your C wrapper.
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS
	ldr r4, ptr_to_prompt
	ldr r5, ptr_to_mydata

 	bl uart_init
	bl uart_interrupt_init
	bl gpio_interrupt_init



Infin:
	B Infin

	; This is where you should implement a loop, waiting for the user to
	; indicate if they want to end the program.

	POP {r4-r12,lr}		; Restore registers to adhere to the AAPCS
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
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS

	 ;Clear the interrupt
    MOV r2, #0xC000
    MOVT r2, #0x4000
    LDR r3, [r2, #0x044]

    ORR r3, #0x10

    STR r3, [r2, #0x044]

    ;get user inpuit
    bl simple_read_character ;input char stored in r0 now

    cmp r0, #'g'
    bne EndUartHandle

    MOV r0, #0xC				;clear the screen
    bl output_character

    ldr r0, ptr_to_names

    bl output_string

EndUartHandle:


	POP {r4-r12,lr}		; Restore registers to adhere to the AAPCS

	BX lr       	; Return


Switch_Handler:

	; Your code for your UART handler goes here.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS

	MOV r2, #0x5000				;clear the interrupt
    MOVT r2, #0x4002
    LDR r3, [r2, #0x041C]

    ORR r3, #0x10

    STR r3, [r2, #0x041C]

    ldr r4, ptr_to_count		;load the counter
    ldr r5, [r4]

    ADD r5, r5, #1				;increment the counter

    str r5, [r4]				; store the count back into address

    CMP r5, #0x37
    BGE illum

must:
    MOV r0, #0xC				;clear the screen
    bl output_character

    MOV r0, r5					;print the count
    bl output_character
    B Done

illum:
	bl illuminate_RGB_prac
	B must

Done:
	POP {r4-r12,lr}		; Restore registers to adhere to the AAPCS

	BX lr       	; Return


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

	MOV pc, lr

illuminate_RGB_prac:
	PUSH {r4-r12,lr} ; Spill registers to stack

	;r1- address bucket
    ;r2- regsiter data bucket

	;Get Register which controls the light
    MOV r1, #0x5000
    MOVT r1, #0x4002 ; base address for GPIO Port F
    LDR r2, [r1, #0x3FC]    ;Puts the data from reg into r2

    ORR r2, r2, #0x2        ;set Pin 1

    STR r2, [r1, #0x3FC]    ;Puts the data BACK with Appropriate color

	POP {r4-r12,lr}   ; Restore registers from stack

	MOV pc, lr

	.end
