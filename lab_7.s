	.data


test: .string "!                  ", 0x0

red:	.string 27, "[41m", 0x0

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
	.global lab7

ptr_to_red:			.word red
ptr_to_test:		.word test

lab7:				; This is your main routine which is called from
				; your C wrapper.
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS

 	bl uart_init
	;bl uart_interrupt_init
	;bl gpio_interrupt_init

	;ldr r0, ptr_to_test
	;bl output_string
	bl print_board

	; This is where you should implement a loop, waiting for the user to
	; indicate if they want to end the program.

	POP {r4-r12,lr}		; Restore registers to adhere to the AAPCS
	MOV pc, lr



uart_interrupt_init:

	; Your code to initialize the UART0 interrupt goes here

	MOV pc, lr


gpio_interrupt_init:

	; Your code to initialize the SW1 interrupt goes here
	; Don't forget to follow the procedure you followed in Lab #4
	; to initialize SW1.

	MOV pc, lr


UART0_Handler:

	; Your code for your UART handler goes here.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler

	BX lr       	; Return


Switch_Handler:

	; Your code for your UART handler goes here.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler

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

	MOV pc, lr	; Return





print_board:
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS

	ldr r4, ptr_to_test
GetBoardChar:
	LDRB r0, [r4]           ;load current char into r0

	CMP r0, #'!'
	BEQ PrintRed
	CMP r0, #0              ;compare current char to NULL (Is this the End of the String?)
    BEQ EndPrintBoard

    ;print Char (normal case)
    BL output_character
   	ADD r4,r4,#1
   	B GetBoardChar

PrintRed:
	ldr r0, ptr_to_red
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar



EndPrintBoard:

	PUSH {r4-r12,lr}		; Restore registers to adhere to the AAPCS
	MOV pc, lr



	.end
