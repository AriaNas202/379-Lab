;this function assumes we're ONLY moving either LEFT OR RIGHT, NOT BOTH!!!!
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
	SUB r8, r5, #2		;increment 1 up for top of paddle
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
	SUB r8, r5, #2		;increment 1 up for top of paddle
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

