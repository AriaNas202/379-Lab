
	.data
	.global board
	.global trash
	.global pause
	.global winningScore
	.global GameState
	.global ball
	.global paddleLeft
	.global paddleRight
	.global PDFlagR





board:
        .string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
        .string "/????????0????????????????????Time:??0?????????????????????????????????0?????????/", 0xA, 0xD


		.string "/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/$??????????????????????????????????????????????????????????????????????????????#/", 0xA, 0xD
		.string "/$???????????????????????????????????????*??????????????????????????????????????#/", 0xA, 0xD
		.string "/$??????????????????????????????????????????????????????????????????????????????#/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
		.string "/????????????????????????????????????????????????????????????????????????????????/", 0xA, 0xD
        .string "/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/", 0xA, 0xD, 0x0



ball:	.string 27, "[41m ", 0x0
paddleLeft:	.string 27, "[47m ", 0x0
paddleRight:	.string 27, "[46m ", 0x0


blue:	.string 27, "[44m ", 0x0
cyan: .string 27, "[46m ", 0x0
white: .string 27, "[47m ", 0x0
black: .string 27, "[40m ", 0x0
yellow: .string 27, "[43m ", 0x0


trash:
	.string "Trash goes here!", 0x0

ballflagX: .word	0x2A
ballflagY: .word	0xF
BDFlagX:		.word 0x1
BDFlagY:		.word 0x0
PaddlePosL:	.word 0xF
PaddlePosR:	.word 0xF
PDFlagL:		.word 0x0
PDFlagR:	.word 0x0
PLscore:	.word 0x0
PRscore:	.word 0x0
GameState:	.word 0x0
PaddleHitCount: .word 0x0
pause:		.word 0x0
winningScore:	.word 0x0
rightWinMessage: 	.string 27, "[40mGame Over! Right Player Won!", 0xA, 0xD
					.string "Hit 'Y' to Play Again!", 0xA, 0xD
					.string "Hit any other button to quit!",0x0
leftWinMessage: 	.string 27, "[40mGame Over! Left Player Won!", 0xA, 0xD
					.string "Hit 'Y' to Play Again!", 0xA, 0xD
					.string "Hit any other button to quit!",0x0
getScoreMessage: 	.string 27, "[40mWhat is Winning Score for Game?", 0xA, 0xD
				 	.string "sw5 == 7", 0xA, 0xD
				 	.string "sw4 == 9", 0xA, 0xD
				 	.string "sw3 == 11", 0xA, 0xD
				 	.string "sw2 == infinite freeplay", 0xA, 0xD, 0x0
pauseScreenMessage:	.string  27, "[40mGame Paused! Hit sw1 Again to unpause! Hit 'r' to restart the game!",0x0
clearMessage: 		.string 27, "[40m                                                                                   ",0x0
gameTimer: 			.word 0x0
timerDividend:		.word 0x23


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
	.global int2string
	.global lab7
	.global simplified_read_push_btns
	.global read_from_push_btns
	.global illuminate_LEDs
	.global gpio_btn_and_LED_init
	.global illuminate_RGB_LED

ptr_to_ball:			.word ball
ptr_to_board:			.word board
ptr_to_blue:			.word blue
ptr_to_cyan:			.word cyan
ptr_to_white:			.word white
ptr_to_black:			.word black
ptr_to_yellow:			.word yellow
ptr_to_ballflagX:		.word ballflagX
ptr_to_ballflagY:		.word ballflagY
ptr_to_BDFlagX:			.word BDFlagX
ptr_to_BDFlagY:			.word BDFlagY
ptr_to_paddleLeft:		.word paddleLeft
ptr_to_paddleRight:		.word paddleRight
ptr_to_trash:			.word trash
ptr_to_PaddlePosL:		.word PaddlePosL
ptr_to_PaddlePosR:		.word PaddlePosR
ptr_to_PDFlagL:			.word PDFlagL
ptr_to_PDFlagR:			.word PDFlagR
ptr_to_PLscore:			.word PLscore
ptr_to_PRscore:			.word PRscore
ptr_to_GameState:		.word GameState
ptr_to_PaddleHitCount:	.word PaddleHitCount
ptr_to_pause:			.word pause
ptr_to_winningScore:	.word winningScore
ptr_to_rightWinMessage:	.word rightWinMessage
ptr_to_leftWinMessage:	.word leftWinMessage
ptr_to_getScoreMessage:	.word getScoreMessage
ptr_to_pauseScreenMessage: .word pauseScreenMessage
ptr_to_clearMessage: 		.word clearMessage
ptr_to_gameTimer:  			.word gameTimer
ptr_to_timerDividend:		.word timerDividend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lab7:

	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS
	;init everything
 	bl uart_init
	bl uart_interrupt_init
	bl gpio_btn_and_LED_init



StartGameMain:
	;reset everything to be able to play again
	;ball x coordinate
	ldr r0, ptr_to_ballflagX
	MOV r1, #0x2A
	str r1, [r0]
	;ball y coordinate
	ldr r0, ptr_to_ballflagY
	MOV r1, #0xF
	str r1, [r0]
	;set ball x direction
	ldr r0, ptr_to_BDFlagX
	MOV r1, #1				;right
	str r1, [r0]
	;set ball y direction
	ldr r0, ptr_to_BDFlagY
	MOV r1, #0				;no y movement
	str r1, [r0]
	;set paddle position left
	ldr r0, ptr_to_PaddlePosL
	MOV r1, #0xF
	str r1, [r0]
	; set paddle position right
	ldr r0, ptr_to_PaddlePosR
	MOV r1, #0xF
	str r1, [r0]
	;left player score PLscore
	ldr r0, ptr_to_PLscore
	MOV r1, #0x0
	str r1, [r0]
	;right player score PLscore
	ldr r0, ptr_to_PRscore
	MOV r1, #0x0
	str r1, [r0]
	;paddle hit count (for fps)
	ldr r0, ptr_to_PaddleHitCount
	MOV r1, #0x0
	str r1, [r0]
	;pause
	ldr r0, ptr_to_pause
	MOV r1, #0x0
	str r1, [r0]
	;game time
	ldr r0, ptr_to_gameTimer
	MOV r1, #0x0
	str r1, [r0]
	;rbg light
	MOV r0, #8
	bl illuminate_RGB_LED    ;light up light


	;reset gpio timer
	MOV r0, #0x2355
	MOVT r0, #0x0008
	bl gpio_interrupt_init


	;get winning score
	Mov r0, #0xC
	bl output_character 	;clear screen
	ldr r0, ptr_to_getScoreMessage
	bl output_string	;prompt for score
	bl WinningScore		;get score

	;randomize colors
	bl biggerRandomColor

	;print whole board to start
	MOV r0, #0xC
	bl output_character
	bl print_board

	;start game officially
	ldr r0, ptr_to_GameState
	MOV r1, #1							;Change the game state flag to 1 (Game is running)
	str r1, [r0]

	;wait for winner
Infin:
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #2
	BEQ RightWonGame
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #3
	BEQ LeftWonGame
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #5
	BEQ RightScoreRound
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #6
	BEQ LeftScoreRound
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #0
	BEQ StartGameMain
	B Infin
RightScoreRound:
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #1
	BEQ Infin
	B RightScoreRound

LeftScoreRound:
	ldr r4, ptr_to_GameState		;game state address (r4)
	ldr r5, [r4]					;actual game state (r5)
	CMP r5, #1
	BEQ Infin
	B RightScoreRound


RightWonGame:
	MOV r0, #0xC
	bl output_character
	ldr r0, ptr_to_rightWinMessage
	bl output_string
	;make led dance
	bl LEDdance
	;set ball x direction (should already be set)
	;ldr r0, ptr_to_BDFlagX
	;MOV r1, #-1				;set ball to go left
	;str r1, [r0]
	B PlayAgain

LeftWonGame:
	MOV r0, #0xC
	bl output_character
	ldr r0, ptr_to_leftWinMessage
	bl output_string
	;make led dance
	bl LEDdance
	;set ball x direction (should already be set)
	;ldr r0, ptr_to_BDFlagX
	;MOV r1, #1				;set ball to go right
	;str r1, [r0]
	B PlayAgain

PlayAgain:
	;check for play again (0) or quit (4)
	ldr r0, ptr_to_GameState
	ldr r0, [r0]
	CMP r0, #0
	BEQ StartGameMain
	CMP r0, #4
	BEQ endOfMain
	B PlayAgain

endOfMain:

	POP {r4-r12,lr}		; Restore registers to adhere to the AAPCS
	MOV pc, lr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
uart_interrupt_init:

	; Your code to initialize the UART0 interrupt goes here

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gpio_interrupt_init:
	PUSH {r4-r12,lr}
	MOV r4, r0

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


    ;Connect Clock to timer
    MOV r0, #0xE000
    MOVT r0, #0x400F
    LDR r1, [r0, #0x604]

    ORR r1, r1, #0x1

    STR r1, [r0, #0x604]

    ;Disable timer
    MOV r0, #0x0000
    MOVT r0, #0x4003

    LDR r1, [r0, #0xC]
    BIC r1, r1, #0x1

    STR r1, [r0, #0xC]

    ;Put timer in 32 bit mode
    MOV r0, #0x0000
    MOVT r0, #0x4003

    LDR r1, [r0]

    BIC r1, r1, #0x7

    STR r1, [r0]

    ;Put timer in periodic mode
    MOV r0, #0x0000
    MOVT r0, #0x4003

    LDR r1, [r0, #0x4]
    BIC r1, r1, #0x1
    ORR r1, r1, #0x2

    STR r1, [r0, #0x4]

    ;Set up interval period
    MOV r0, #0x0000
    MOVT r0, #0x4003

    LDR r1, [r0, #0x028]

   ; MOV r1, #0x2355
    ;MOVT r1, #0x0008    ;MAKE THIS DYNAMIC

	STR r4, [r0, #0x028]  ;make this dynamic

    ;Enable timer to interrupt processor
	MOV r0, #0x0000
    MOVT r0, #0x4003

    LDR r1, [r0, #0x018]

    ORR r1, r1, #0x01

    STR r1, [r0, #0x018]

    ;Configure processer to allow interrupts
    MOV r0, #0xE000
    MOVT r0, #0xE000

    LDR r1, [r0, #0x100]

    ORR r1, r1, #0x80000

    STR r1, [r0, #0x100]

	;Enable timer
	MOV r0, #0x0000
    MOVT r0, #0x4003

    LDR r1, [r0, #0xC]

    ORR r1, r1, #0x1

    STR r1, [r0, #0xC]




    POP  {r4-r12,lr}

	MOV pc, lr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UART0_Handler:
	PUSH {r4-r12,lr} ; Spill registers to stack

	;Clear the interrupt
    MOV r2, #0xC000
    MOVT r2, #0x4000
    LDR r3, [r2, #0x044]
    ORR r3, #0x10
    STR r3, [r2, #0x044]

	;read the character
    bl simple_read_character ;character returned in r0

	;if game paused, restart
    ldr r6, ptr_to_pause		; check for pause, still in works
    ldr r7, [r6]
    CMP r7, #1
    BEQ uartPauseHandling

    ;check game state
	ldr r6, ptr_to_GameState
	ldr r7, [r6]
	CMP r7, #1			;if game is running then change paddle direction
	BEQ uartHandlerGameRunning
	CMP r7, #2			;if either right/left player won then set game state to continue/quit the game
	BEQ uartHandlerPlayAgain
	CMP r7, #3
	BEQ uartHandlerPlayAgain
	CMP r7, #5
	BEQ uartStartOfRound
	CMP r7, #6
	BEQ uartStartOfRound
	B endUART

uartPauseHandling:
	ldr r6, ptr_to_GameState
	ldr r7, [r6]
	CMP r0, #'r'
	BNE endUART
	MOV r7, #0
	str r7, [r6]
	B endUART


uartStartOfRound:
	MOV r7, #1
	str r7, [r6]
	B endUART

uartHandlerPlayAgain:
	CMP r0, #'Y'
	BEQ  uartContinueGame	;if user hit Y then continue game
	;else user did not hit Y and we quit the game (move 4 into GameState)
	MOV r7, #4
	str r7, [r6]
	B endUART

uartContinueGame:	;move 0 into GameState
	MOV r7, #0
	str r7, [r6]
	B endUART

uartHandlerGameRunning:
	;game is started, change the paddle directions
    CMP r0, #'q'
    BEQ LeftUp
    CMP r0, #'a'
    BEQ LeftDown
    CMP r0, #'o'
    BEQ RightUp
    CMP r0, #'l'
    BEQ RightDown
    B endUART

LeftUp:
	ldr r4, ptr_to_PDFlagL
	MOV r5, #-1
	str r5, [r4]
	B endUART
LeftDown:
	ldr r4, ptr_to_PDFlagL
	MOV r5, #1
	str r5, [r4]
	B endUART
RightUp:
	ldr r4, ptr_to_PDFlagR
	MOV r5, #-1
	str r5, [r4]
	B endUART
RightDown:
	ldr r4, ptr_to_PDFlagR
	MOV r5, #1
	str r5, [r4]
	B endUART
endUART:
	POP {r4-r12,lr} ; Spill registers to stack
	BX lr       	; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Switch_Handler:

	; Your code for your UART handler goes here.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler
	PUSH {r4-r12,lr} ; Spill registers to stack

	; Your code for your UART handler goes here.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler

	;Clear the interrupt
	MOV r2, #0x5000
    MOVT r2, #0x4002
    LDR r3, [r2, #0x041C]
    ORR r3, #0x10
    STR r3, [r2, #0x041C]

    ;only pause game if GameState 1
    ldr r0, ptr_to_GameState
	ldr r0, [r0]
	CMP r0, #1
	BNE endSwitchHandler


	;flips the pause flag
    ldr r4, ptr_to_pause	;load the flag
    ldr r5, [r4]				; loads content into r0
    EOR r5, r5, #0x1
    STR r5, [r4]

    ;print appropriate message
    MOV r0, #2
    MOV r1, #29
    bl moveCursor

    ;get address into r0 (of message)
    CMP r5, #0 ;game not paused
    ITE EQ
    ldrEQ r0, ptr_to_clearMessage
    ldrNE r0, ptr_to_pauseScreenMessage

    bl output_string




endSwitchHandler:

	POP {r4-r12,lr}   ; Restore registers from stack
	BX lr       	; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Timer_Handler:

	; Your code for your Timer handler goes here.  It is not needed for
	; Lab #5, but will be used in Lab #6.  It is referenced here because
	; the interrupt enabled startup code has declared Timer_Handler.
	; This will allow you to not have to redownload startup code for
	; Lab #6.  Instead, you can use the same startup code as for Lab #5.
	; Remember to preserver registers r4-r12 by pushing then popping
	; them to & from the stack at the beginning & end of the handler.
	PUSH {r4-r12,lr} ; Spill registers to stack

	;Clear interrupt
	MOV r0, #0x0000
	MOVT r0, #0x4003
	LDRB r1, [r0, #0x24]
	ORR r1, r1, #0x1
	STRB r1, [r0, #0x24]

	;check if game started,if not started then do nothing
	ldr r0, ptr_to_GameState
	ldr r1, [r0]
	CMP r1, #1
	BNE EndTimer

	;check if game paused, if it is then do nothing
	ldr r0, ptr_to_pause
	ldr r1, [r0]
	CMP r1, #1
	BEQ EndTimer

	;check for penalties
	bl checkPenalty
	ldr r0, ptr_to_GameState	;if there was a penalty then GameState shouldnt be 1 anymore (so skip the rest)
	ldr r1, [r0]
	CMP r1, #1
	BNE EndTimer


	;handle game time (on top of the screen)
	MOV r0, #37
	MOV r1, #2
	bl moveCursor		;move cursor to game timer

	ldr r0, ptr_to_black ;print background black
	bl output_string

	ldr r2, ptr_to_gameTimer
	ldr r1, [r2]
	add r1,r1,#1
	str r1, [r2]			;increment timer


	ldr r4, ptr_to_timerDividend
	ldr r5, [r4]

	ldr r0, ptr_to_trash
	mov r2, r5    ;;make this dynamic
	UDIV r1, r1, r2

	bl int2string			;turn int into string for timer

	ldr r0, ptr_to_trash
	bl output_string			;print timer





	;move paddle
	bl movePaddle

	;print new ball location (ie just move the ball)
	ldr r0, ptr_to_ballflagX
	ldr r0, [r0]
	ldr r1, ptr_to_ballflagY
	ldr r1, [r1]
	bl moveCursor						;move the cursor to ball location
	ldr r0, ptr_to_black
	bl output_string					;print black to current ball location

	bl moveBall							;find new ball location

	ldr r0, ptr_to_ballflagX
	ldr r0, [r0]
	ldr r1, ptr_to_ballflagY
	ldr r1, [r1]
	bl moveCursor						;move cursor to new ball location
	ldr r0, ptr_to_ball
	bl output_string					;print the color of the ball to new ball location


EndTimer:

	POP {r4-r12,lr}
	BX lr       	; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
simple_read_character:
	PUSH {r4-r12,lr} ; Spill registers to stack

    MOV r4, #0xC000     ;UART base address
    MOVT r4, #0x4000
    LDRB r5, [r4, #0x18] ;Load from memory
    LDRB r0, [r4]       ;Store in r0

	POP {r4-r12,lr}   ; Restore registers from stack

	MOV pc, lr	; Return




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_board:
	PUSH {r4-r12,lr}   	; Preserve registers to adhere to the AAPCS

	ldr r4, ptr_to_board
GetBoardChar:
	LDRB r0, [r4]           ;load current char into r0

	CMP r0, #'*'
	BEQ PrintRed
	CMP r0, #'?'
	BEQ PrintBlack
	CMP r0, #'$'
	BEQ PrintWhite
	CMP r0, #'#'
	BEQ PrintCyan
	CMP r0, #'X'
	BEQ PrintBlue
	CMP r0, #'/'
	BEQ PrintYellow
	CMP r0, #0              ;compare current char to NULL (Is this the End of the String?)
    BEQ EndPrintBoard

    ;print Char (normal case)
    BL output_character
   	ADD r4,r4,#1
   	B GetBoardChar

PrintRed:
	ldr r0, ptr_to_ball
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar

PrintBlack:
	ldr r0, ptr_to_black
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar

PrintWhite:
	ldr r0, ptr_to_paddleLeft
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar

PrintCyan:
	ldr r0, ptr_to_paddleRight
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar

PrintBlue:
	ldr r0, ptr_to_blue
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar

PrintYellow:
	ldr r0, ptr_to_yellow
	bl output_string
	ADD r4,r4,#1
	B GetBoardChar


EndPrintBoard:

	POP {r4-r12,lr}		; Restore registers to adhere to the AAPCS
	MOV pc, lr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveBall:
	PUSH {r4-r12,lr} ; Spill registers to stack



	;load the x coordinate (r5)
	ldr r4, ptr_to_ballflagX ;address to x coordinate (r4)
	ldr r5, [r4]

	;load the x direction (r7)
	ldr r6, ptr_to_BDFlagX ;address to x direction (r6)
	ldr r7, [r6]

	;load the y direction (r12)
	ldr r11, ptr_to_BDFlagY
	ldr r12, [r11]

	;get the y coordinate (r9)
	ldr r10, ptr_to_ballflagY
	ldr r9, [r10]



    ;where is the ball located (determines which collisions we check)
	CMP r5, #80  ;check collision with right paddle
    BEQ checkRightPaddleCollision

  	CMP r5, #3 ;check collision with left paddle
  	BEQ checkLeftPaddleCollision


  	CMP r5, #2       ;score point for right player (we're in left's endzone)
  	BEQ RightPoint


    CMP r5, #81 ;score point for left player (we're in right's endzone)
    BEQ LeftPoint

	CMP r9, #4			;check collision with top wall
	BEQ checkTopWallCollision

	CMP r9, #27			;check collision with bottom wall
	BEQ checkBottomWallCollision

    B NoXEdgeCases

RightPoint:
	MOV r0, #2
	bl scoring

	;set ball back to default position
	ldr r0, ptr_to_ballflagX
	MOV r1, #0x2A
	str r1, [r0]
	ldr r0, ptr_to_ballflagY
	MOV r1, #0xF
	str r1, [r0]

	;set default ball direction (left, no vertical motion )
	MOV r7, #-1													;CHANGED TO SET X TO GO LEFT (ball is supposed to go oposite direction from winning point player)
	str r7, [r6]	;set x -1 (left)
	MOV r12, #0
	str r12, [r11]	;set y 0 (none)


    B endMoveBall ; no weird edge cases for x, skipp all edge cases for X

LeftPoint:
	MOV r0, #81
	bl scoring

	;set ball back to default position
	ldr r0, ptr_to_ballflagX
	MOV r1, #0x2A
	str r1, [r0]
	ldr r0, ptr_to_ballflagY
	MOV r1, #0xF
	str r1, [r0]

	;set default ball direction (right, no vertical motion )
	MOV r7, #1
	str r7, [r6]	;set x 1 (right)
	MOV r12, #0
	str r12, [r11]	;set y 0 (none)

    B endMoveBall ; no weird edge cases for x, skipp all edge cases for X



checkRightPaddleCollision:
    ;check if ball is moving right (if its not then we dont have a collision )
    CMP r7, #1
    BNE NoXEdgeCases

    ;we are moving right, potential collision

    ;get paddle position Right (r8)
    ldr r8, ptr_to_PaddlePosR
    ldr r8, [r8]


    ;check if ball hit the middle of of paddle
    CMP r9, r8  ;did we hit middle of paddle?
    BEQ ccRight1
    SUB r8, r8, #1 ;did we hit top of paddle
    CMP r9, r8
    BEQ ccRight2
    ADD r8, r8, #2 ;did we hit bottom of paddle
    CMP r9, r8
    BEQ ccRight3
    B NoXEdgeCases ;we did not hit paddle

;hit center of right paddle
ccRight1:
    MOV r7, #-1
    str r7, [r6]	;set x to left
    MOV r12, #0
    str r12, [r11]	;set y to 0
    bl dynamic_Timer
    B endMoveBall
;hit top of right paddle
ccRight2:
    MOV r7, #-1
    str r7, [r6]	;set x to left

    MOV r12, #-1
    str r12, [r11]	;set y to up
    bl dynamic_Timer
    B endMoveBall
;hit bottom of right paddle
ccRight3:
    MOV r7, #-1
    str r7, [r6]	;set x to left

    MOV r12, #1
    str r12, [r11]	;set y to down
    bl dynamic_Timer
    B endMoveBall

checkLeftPaddleCollision:
    ;check if ball is moving left (if its not then we dont have a collision )
    CMP r7, #-1
    BNE NoXEdgeCases

    ;we are moving left, potential collision

    ;get paddle position Left (r8)
    ldr r8, ptr_to_PaddlePosL
    ldr r8, [r8]


    ;check if ball hit the middle of of paddle
    CMP r9, r8  ;did we hit middle of paddle?
    BEQ ccLeft1
    SUB r8, r8, #1 ;did we hit top of paddle
    CMP r9, r8
    BEQ ccLeft2
    ADD r8, r8, #2 ;did we hit bottom of paddle
    CMP r9, r8
    BEQ ccLeft3
    B NoXEdgeCases ;we did not hit paddle

;hit center of left paddle
ccLeft1:
    MOV r7, #1
    str r7, [r6] ;set x to right
    MOV r12, #0
    str r12, [r11] ;set y to 0
    bl dynamic_Timer
    B endMoveBall
;hit top of left paddle
ccLeft2:
    MOV r7, #1
    str r7, [r6] ;set x to right

    MOV r12, #-1
    str r12, [r11] ; set y to up
    bl dynamic_Timer
    B endMoveBall
;hit bottom of left paddle
ccLeft3:
    MOV r7, #1
    str r7, [r6]	;set x to right

    MOV r12, #1
    str r12, [r11]	;set y to down
    bl dynamic_Timer
    B endMoveBall



checkTopWallCollision:
	CMP r12, #1
	BEQ NoXEdgeCases


	MOV r12, #1
	str r12, [r11]
	B endMoveBall

checkBottomWallCollision:
	CMP r12, #-1
	BEQ NoXEdgeCases


	MOV r12, #-1
	str r12, [r11]
	B endMoveBall


NoXEdgeCases:
    ;NO SPECIAL EDGE CASES, HANDLE REGULAR MOVEMENT AS NORMAL
    ADD r8, r5, r7		; Move the ball x direction
	STR r8, [r4]

	ADD r8, r9, r12		; Move the ball y direction
	str r8, [r10]
	b endMoveBall



endMoveBall:

	POP {r4-r12,lr}
	MOV pc, lr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scoring:
	PUSH {r4-r12,lr} ; Spill registers to stack

	; r0 - Position of the ball, either 2 or 81
	CMP r0, #2
	BEQ scoreRight

	CMP r0, #81
	BEQ scoreLeft
	B end

scoreRight:
	ldr r4, ptr_to_PRscore			; load right player score
	ldr r5, [r4]

	ADD r5, r5, #1					; increment right player score

	str r5, [r4]

	;move cursor to score position
	MOV r0, #72
	MOV r1, #2
	bl moveCursor

	ldr r0, ptr_to_trash
	MOV r1, r5
	bl int2string					; convert score to string and move cursor



	ldr r0, ptr_to_trash
	bl output_string				; print score


	;change game state flag to 6 (end of round, right scored)
	ldr r0, ptr_to_GameState
	MOV r1, #6
	str r1, [r0]

	;change LED to winner
	ldr r0, ptr_to_paddleRight;get led code
	add r0,r0, #3
	ldrb r0,[r0]
	sub r0,r0,#0x30
	bl illuminate_RGB_LED    ;light up light


	B end

scoreLeft:
	ldr r4, ptr_to_PLscore
	ldr r5, [r4]

	ADD r5, r5, #1

	str r5, [r4]

	;move cursor to score position
	MOV r0, #10
	MOV r1, #2
	bl moveCursor

	ldr r0, ptr_to_trash
	MOV r1, r5
	bl int2string					; convert score to string and move cursor

	ldr r0, ptr_to_trash
	bl output_string				; print score

	;change game state flag to 5 (end of round, left  scored)
	ldr r0, ptr_to_GameState
	MOV r1, #5
	str r1, [r0]

	;change LED to winner
	ldr r0, ptr_to_paddleLeft ;get led code
	add r0,r0, #3
	ldrb r0,[r0]
	sub r0,r0,#0x30
	bl illuminate_RGB_LED    ;light up light

	B end





end:
	;see if anyone won?

	ldr r0, ptr_to_winningScore		;get winning score (r0)
	ldr r0, [r0]

	ldr r1, ptr_to_PRscore			; load right player score (r1)
	ldr r1, [r1]

	ldr r2, ptr_to_GameState ;get game state flag  (r2)

	;check right won?
	CMP r0, r1
	ITT EQ ;;;right player won
	MOVEQ r4, #2		;game state flag is 2, right won!
	strEQ r4, [r2]

	;check left won?
	ldr r1, ptr_to_PLscore			; load left player score (r1)
	ldr r1, [r1]
	CMP r0, r1
	ITT EQ ;;;left player won
	MOVEQ r4, #3		;game state flag is 3, right won!
	strEQ r4, [r2]


	POP {r4-r12,lr}
	MOV pc, lr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveCursor:
	PUSH {r4-r12,lr} ; Spill registers to stack

	;FOR NOW
	;r0-> x (column) (r4)
	;r1 -> y (row)  (r5)
	MOV r4, r0
	MOV r5, r1


	;print ESC
	MOV r0, #0x1B
	bl output_character

	;print [
	MOV r0, #0x5B
	bl output_character


	;print y (in r5)
	ldr r0, ptr_to_trash
	MOV r1, r5

	bl int2string

	ldr r0, ptr_to_trash
	bl output_string

	;print ;
	MOV r0, #0x3B
	bl output_character

	;print x (in r4)
	ldr r0, ptr_to_trash
	MOV r1, r4

	bl int2string

	ldr r0, ptr_to_trash
	bl output_string

	;print H
	MOV r0, #0x48
	bl output_character


	POP {r4-r12,lr}
	MOV pc, lr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this function will move both left and right paddle at the same time (does NOT account for penalties)
movePaddle:
	PUSH {r4-r12,lr} ; Spill registers to stack

;MOVE LEFT PADDLE
	ldr r4, ptr_to_PaddlePosL		;Load left paddle's position (r5)
	ldr r5, [r4]

	ldr r6, ptr_to_PDFlagL			;Load direction for left paddle (r7)
	ldr r7, [r6]

	CMP r7, #-1						; check if paddle is going up
	BEQ leftPaddleUp
    CMP r7, #1                      ;check if paddle is going down
    BEQ leftPaddleDown
    B rightPaddleMoving             ;left paddle not moving, go to right paddle movement


;MOVE UP LEFT
leftPaddleUp:
    ; Check if paddle is at the top (if it is then skip moving it)
	CMP r5, #5
	BEQ rightPaddleMoving ;right paddle shouldn't be moving if left is moving, but putting this here to test it better

	;print lower paddle color black
	MOV r0, #2			;x coordinate static
	ADD r8, r5, #1		;increment 1 down for black (empty space)
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_black
	bl output_string

    ;print upper part color of paddle
	MOV r0, #2			;x coordinate static
	SUB r8, r5, #2		;increment 2 up  for cyan  (empty space)
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_paddleLeft
	bl output_string

	;INCRMENET FLAG LEFT PADDLE UP
	ADD r5, r5, #-1
	STR r5, [r4]

    ;put direction of paddle back to 0
    mov r7, #0
    str r7, [r6]

    B rightPaddleMoving







;MOVE DOWN LEFT
leftPaddleDown:
    ; Check if paddle is at the bottm (if it is then skip moving it)
	CMP r5, #26
	BEQ rightPaddleMoving

	;print lower under paddle the color of the paddle
	MOV r0, #2			;x coordinate static
	ADD r8, r5, #2		;increment 2 down (the space under the paddle )
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_paddleLeft
	bl output_string

    ;print upper part color of paddle
	MOV r0, #2			;x coordinate static
	SUB r8, r5, #1		;increment 1 up for top of paddle
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_black
	bl output_string

	;INCRMENET FLAG LEFT PADDLE DOWN
	ADD r5, r5, #1
	STR r5, [r4]

    ;put direction of paddle back to 0
    mov r7, #0
    str r7, [r6]

    B rightPaddleMoving




;Move Right Paddle
rightPaddleMoving:

	ldr r4, ptr_to_PaddlePosR		;Load right paddle's position (r5)
	ldr r5, [r4]

	ldr r6, ptr_to_PDFlagR			;Load direction for right paddle (r7)
	ldr r7, [r6]

	CMP r7, #-1						; check if paddle is going up
	BEQ rightPaddleUp
    CMP r7, #1                      ;check if paddle is going down
    BEQ rightPaddleDown
    B endmovePaddle             ;left paddle not moving, go to right paddle movement


;MOVE UP RIGHT
rightPaddleUp:
    ; Check if paddle is at the top (if it is then skip moving it)
	CMP r5, #5
	BEQ endmovePaddle ;right paddle shouldn't be moving if left is moving, but putting this here to test it better

	;print lower paddle color black
	MOV r0, #81			;x coordinate static
	ADD r8, r5, #1		;increment 1 down for black (empty space)
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_black
	bl output_string

    ;print upper part color of paddle
	MOV r0, #81			;x coordinate static
	SUB r8, r5, #2		;increment 2 up  for cyan  (empty space)
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_paddleRight
	bl output_string

	;INCRMENET FLAG RIGHT PADDLE UP
	ADD r5, r5, #-1
	STR r5, [r4]

    ;put direction of paddle back to 0
    mov r7, #0
    str r7, [r6]

    B endmovePaddle

;MOVE DOWN RIGHT
rightPaddleDown:
    ; Check if paddle is at the bottm (if it is then skip moving it)
	CMP r5, #26
	BEQ endmovePaddle

	;print lower under paddle the color of the paddle
	MOV r0, #81			;x coordinate static
	ADD r8, r5, #2		;increment 2 down (the space under the paddle )
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_paddleRight
	bl output_string

    ;print upper part color of paddle
	MOV r0, #81			;x coordinate static
	SUB r8, r5, #1		;increment 1 up for top of paddle
	MOV r1, r8			;y coordinate dynamic
	bl moveCursor

	ldr r0, ptr_to_black
	bl output_string

	;INCRMENET FLAG RIGHT PADDLE DOWN
	ADD r5, r5, #1
	STR r5, [r4]

    ;put direction of paddle back to 0
    mov r7, #0
    str r7, [r6]

    B endmovePaddle


;end of the function, we're done moving paddles
endmovePaddle:
	POP {r4-r12,lr}
	MOV pc, lr




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dynamic_Timer:
	PUSH {r4-r12,lr}
	;get paddle hits
	ldr r2, ptr_to_PaddleHitCount	;address in r2
	ldr r3, [r2]					;count in r3
	ldr r4, ptr_to_timerDividend
	ldr r11, ptr_to_gameTimer	;game timer address (r11)
	ldr r12, [r11]				;game timer (r12)

	ADD r3,r3,#1			;add count by 1 (function is called once per ball hit)

	str r3, [r2]



	cmp r3, #1
	BEQ dt1
	cmp r3, #2
	BEQ dt2
	cmp r3, #3
	BEQ dt3
	cmp r3, #4
	BEQ dt4
	cmp r3, #5
	BEQ dt5
	cmp r3, #6
	BEQ dt6
	B end_Dynamic_Timer
	;B end_Dynamic_Timer


;35 FPS
dt1:
	MOV r0, #0xF9B6
    MOVT r0, #0x0006
    bl gpio_interrupt_init

    MOV r5, #40			;40
    STR r5, [r4]
    ;set the quotient (prevents weird blips in time)
    mov r7, #23
    udiv r6, r12, r7
    mov r7, #40
    mul r6, r6, r7
    str r6, [r11]

    B end_Dynamic_Timer

;40 fps
dt2:
	MOV r0, #0x1A80
    MOVT r0, #0x0006
    bl gpio_interrupt_init ;set interrupt to happen faster

    MOV r5, #46			;46
    STR r5, [r4]		;set the dividend dynamically

    ;set the quotient (prevents weird blips in time)
    mov r7, #40
    udiv r6, r12, r7
    mov r7, #46
    mul r6, r6, r7
    str r6, [r11]


    B end_Dynamic_Timer

;45 fps
dt3:
	MOV r0, #0x6CE3
    MOVT r0, #0x0005
    bl gpio_interrupt_init

    MOV r5, #51			;51
    STR r5, [r4]
    ;set the quotient (prevents weird blips in time)
    mov r7, #46
    udiv r6, r12, r7
    mov r7, #51
    mul r6, r6, r7
    str r6, [r11]


    B end_Dynamic_Timer

;50 fps
dt4:
	MOV r0, #0xE200
    MOVT r0, #0x0004
    bl gpio_interrupt_init

    MOV r5, #57				;57
    STR r5, [r4]
    ;set the quotient (prevents weird blips in time)
    mov r7, #51
    udiv r6, r12, r7
    mov r7, #57
    mul r6, r6, r7
    str r6, [r11]

    B end_Dynamic_Timer
;55fps
dt5:
	MOV r0, #0x705D
    MOVT r0, #0x0004
    bl gpio_interrupt_init

    MOV r5, #63					;63
    STR r5, [r4]
    ;set the quotient (prevents weird blips in time)
    mov r7, #57
    udiv r6, r12, r7
    mov r7, #63
    mul r6, r6, r7
    str r6, [r11]


    B end_Dynamic_Timer
;60fps
dt6:
	MOV r0, #0x11AA
    MOVT r0, #0x0004
    bl gpio_interrupt_init

    MOV r5, #70						;70
    STR r5, [r4]
    ;set the quotient (prevents weird blips in time)
    mov r7, #63
    udiv r6, r12, r7
    mov r7, #70
    mul r6, r6, r7
    str r6, [r11]



    B end_Dynamic_Timer



end_Dynamic_Timer:


	POP {r4-r12,lr}
	MOV pc, lr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
simplified_read_push_btns:
    PUSH {r4-r12,lr} ; Spill registers to stack

        ;r0- return value
        ;r1- base address (port D)
        ;r2- data register
        ;r3 - masked data

        ;bit 0 - s5             (r0 is 0x1)
        ;bit 1 - s4             (r0 is 0x2)
        ;bit 2 - s3             (r0 is 0x4)
        ;bit 3 - s2             (r0 is 0x8)


 		MOV r0, #0 ;init return value to 0

        MOV r1, #0x7000
     	MOVT r1, #0x4000        ;Move base address for Port D in r1
    	;Get Register which reads the buttons
     	LDR r2, [r1, #0x3FC]    ;Puts the data from reg into r2

    ;mask last 4 bits
    AND r0, r2, #0xF




	POP {r4-r12,lr}   ; Restore registers from stack
	MOV pc, lr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WinningScore:
	PUSH {r4-r12,lr} ; Spill registers to stack

	ldr r4, ptr_to_winningScore


Poll:
	bl simplified_read_push_btns

	CMP r0, #1     ; Compare r0 to the given score
	BEQ Score7

	CMP r0, #2
	BEQ Score9

	CMP r0, #4
	BEQ Score11

	CMP r0, #8
	BEQ unlimited

	B Poll

Score7:
	MOV r5, #7
	str r5, [r4]
	B endWinningScore

Score9:
	MOV r5, #9
	str r5, [r4]
	B endWinningScore

Score11:
	MOV r5, #11
	str r5, [r4]
	B endWinningScore

unlimited:
	MOV r5, #-1
	str r5, [r4]



endWinningScore:

	POP {r4-r12,lr}   ; Restore registers from stack
	MOV pc, lr

randomColor:
	PUSH {r4-r12,lr}

	;get timer value
	MOV r0, #0
	MOVT r0, #0x4003
	ldr r1, [r0,#0x50]


	;Modulo by 6
	MOV r6, #6
    UDIV r2,r1, r6          ;r2=r1/6
    MUL r2, r2, r6         ; r2=r2*6
    SUB r0, r1, r2          ; r2=r1-r2 (stored in r0 )



	POP {r4-r12,lr}
	MOV pc, lr



biggerRandomColor:
	PUSH {r4-r12,lr}

	;get color 1 (r10)
	bl randomColor
	MOV r10, r0

	;get color 2
getColor2:
	bl randomColor
	MOV r11, r0

	CMP r11, r10
	BEQ getColor2	;color 2 not same as color 1

	;get color 3
getColor3:
	bl randomColor
	MOV r12, r0

	CMP r12, r10
	BEQ getColor3 ;color 3 not same as color 1
	CMP r12, r11
	BEQ getColor3 ;color 3 not same as color 2



	;change color of ball/paddle based on colors

	;ball as color 1 (r10)
	ldr r0, ptr_to_ball	;get ball pointer (r0)
	Add r0,r0, #3 ;increment ball ptr to right address

	;set ansi escape sequence (r1)
	cmp r10, #0
	IT EQ
	movEQ r1, #'1'
	cmp r10, #1
	IT EQ
	movEQ r1, #'4'
	cmp r10, #2
	IT EQ
	movEQ r1, #'2'
	cmp r10, #3
	IT EQ
	movEQ r1, #'5'
	cmp r10, #4
	IT EQ
	movEQ r1, #'3'
	cmp r10, #5
	IT EQ
	movEQ r1, #'7'

	strb r1, [r0]


	;left Paddle as color 2 (r11)
	ldr r0, ptr_to_paddleLeft	;get ball pointer (r0)
	Add r0,r0, #3 ;increment ball ptr to right address

	;set ansi escape sequence (r1)
	cmp r11, #0
	IT EQ
	movEQ r1, #'1'
	cmp r11, #1
	IT EQ
	movEQ r1, #'4'
	cmp r11, #2
	IT EQ
	movEQ r1, #'2'
	cmp r11, #3
	IT EQ
	movEQ r1, #'5'
	cmp r11, #4
	IT EQ
	movEQ r1, #'3'
	cmp r11, #5
	IT EQ
	movEQ r1, #'7'

	strb r1, [r0]

	;right Paddle as color 3 (r12)
	ldr r0, ptr_to_paddleRight	;get ball pointer (r0)
	Add r0,r0, #3 ;increment ball ptr to right address

	;set ansi escape sequence (r1)
	cmp r12, #0
	IT EQ
	movEQ r1, #'1'
	cmp r12, #1
	IT EQ
	movEQ r1, #'4'
	cmp r12, #2
	IT EQ
	movEQ r1, #'2'
	cmp r12, #3
	IT EQ
	movEQ r1, #'5'
	cmp r12, #4
	IT EQ
	movEQ r1, #'3'
	cmp r12, #5
	IT EQ
	movEQ r1, #'7'

	strb r1, [r0]




	POP {r4-r12,lr}
	MOV pc, lr

LEDdance:
	PUSH {r4-r12,lr}

	; r0 - bit pattern of the lights
	mov r12, #0
	mov r9, #0x1111
	movt r9, #0x0001

danceStart:
	mov r4, #0
	mov r5, #0
	mov r6, #0
	mov r7, #0


dance1:
	MOV r0, #8
	bl illuminate_LEDs
	add r4, r4, #1
	cmp r4, r9
	bne dance1
dance2:
	MOV r0, #4
	bl illuminate_LEDs
	add r5, r5, #1
	cmp r5, r9
	bne dance2
dance3:
	MOV r0, #2
	bl illuminate_LEDs
	add r6, r6, #1
	cmp r6, r9
	bne dance3
dance4:
	MOV r0, #1
	bl illuminate_LEDs
	add r7, r7, #1
	cmp r7, r9
	bne dance4

	;do dance again
	add r12, r12, #1
	cmp r12, #6
	bne danceStart

	mov r0, #0
	bl illuminate_LEDs

	POP {r4-r12,lr}
	MOV pc, lr


checkPenalty:
	PUSH {r4-r12,lr}

	; load X ball direction and both paddle directions
	ldr r4, ptr_to_BDFlagX		;address of ball direction (r4)
	ldr r5, [r4]				;ball direction (r5)

	ldr r6, ptr_to_PDFlagL		;address to left paddle (r6)
	ldr r7, [r6]				;left paddle (r7)

	ldr r8, ptr_to_PDFlagR		;address to right paddle (r8)
	ldr r9, [r8]				;right paddle (r9)

	;check ball direction
	CMP r5, #-1
	BEQ checkRpenalty
	CMP r5, #1
	BEQ checkLpenalty
	B endCheckPenalty

checkRpenalty:
	CMP r9, #0
	BEQ endCheckPenalty ;check for penalty (paddle movement)
	;there is a penalty!!!!
	;give left player point
	mov r0, #27
	bl output_character
	mov r0, #'['
	bl output_character
	mov r0, #'4'
	bl output_character
	mov r0, #'0'
	bl output_character
	mov r0, #'m'
	bl output_character
	MOV r0, #81
	bl scoring

	;deduct right player's point (and print) (skipped if at 0)
	ldr r10, ptr_to_PRscore			; load right player score (address r10, score r11)
	ldr r11, [r10]
	cmp r11, #0   					;set min score limit to 0
	BEQ penaltyResetBoard
	SUB r11, r11, #1					; sub right player score
	str r11, [r10]						;store score back
	;move cursor to score position
	MOV r0, #72
	MOV r1, #2
	bl moveCursor
	; convert score to string and print
	ldr r0, ptr_to_trash
	MOV r1, r11
	bl int2string
	ldr r0, ptr_to_trash
	bl output_string

	;print black space (in case of stray number)
	ldr r0, ptr_to_black
	bl output_string


	B penaltyResetBoard



checkLpenalty:
	CMP r7, #0
	BEQ endCheckPenalty ;check for penalty (paddle movement)
	;there is a penalty!!!!
	;give left player point
	mov r0, #27
	bl output_character
	mov r0, #'['
	bl output_character
	mov r0, #'4'
	bl output_character
	mov r0, #'0'
	bl output_character
	mov r0, #'m'
	bl output_character
	MOV r0, #2
	bl scoring

	;deduct left player's point (and print) (skipped if at 0)
	ldr r10, ptr_to_PLscore			; load left player score (address r10, score r11)
	ldr r11, [r10]
	cmp r11, #0   					;set min score limit to 0
	BEQ penaltyResetBoard
	SUB r11, r11, #1					; sub right player score
	str r11, [r10]						;store score back
	;move cursor to score position
	MOV r0, #10
	MOV r1, #2
	bl moveCursor
	; convert score to string and print
	ldr r0, ptr_to_trash
	MOV r1, r11
	bl int2string
	ldr r0, ptr_to_trash
	bl output_string
	;print black space (in case of stray number)
	ldr r0, ptr_to_black
	bl output_string



penaltyResetBoard:
	;RESET BOARD!!!!!!!!!
	;black out old ball location
	ldr r0, ptr_to_ballflagX
	ldr r0, [r0]
	ldr r1, ptr_to_ballflagY
	ldr r1, [r1]
	bl moveCursor						;move the cursor to ball location
	ldr r0, ptr_to_black
	bl output_string					;print black to current ball location

	;set ball back to default position
	ldr r0, ptr_to_ballflagX
	MOV r1, #0x2A
	str r1, [r0]
	ldr r0, ptr_to_ballflagY
	MOV r1, #0xF
	str r1, [r0]

	;set default ball direction (right, no vertical motion )
	ldr r0, ptr_to_BDFlagX
	MOV r1, #1
	str r1, [r0]	;set x 1 (right)
	ldr r0, ptr_to_BDFlagY
	MOV r1, #0
	str r1, [r0]	;set y 0 (none)

	;print new ball location
	ldr r0, ptr_to_ballflagX
	ldr r0, [r0]
	ldr r1, ptr_to_ballflagY
	ldr r1, [r1]
	bl moveCursor						;move cursor to new ball location
	ldr r0, ptr_to_ball
	bl output_string					;print the color of the ball to new ball location

	;set default paddle direction
	ldr r0, ptr_to_PDFlagL
	MOV r1, #0
	str r1, [r0]	;set left paddle no movement
	ldr r0, ptr_to_PDFlagR
	MOV r1, #0
	str r1, [r0]	;set left paddle no movement
endCheckPenalty:

	POP {r4-r12,lr}
	MOV pc, lr

	.end
