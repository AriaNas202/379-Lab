moveBall:
	PUSH {r4-r12,lr} ; Spill registers to stack



	;load the x coordinate
	ldr r4, ptr_to_ballflagX
	ldr r5, [r4]

	;load the x direction
	ldr r6, ptr_to_BDFlagX
	ldr r7, [r6]

	CMP r5, #80
	BEQ changeXtoLeft

  	CMP r5, #3
	BEQ changeXtoRight

	ADD r8, r5, r7		; Move the ball to the right

	STR r8, [r4]

	b endMoveBall

changeXtoLeft:

	MOV r7, #-1
	ADD r8, r5, r7		; Move the ball to the left

	STR r8, [r4]
	STR r7, [r6]

  b endMoveBall

changeXtoRight:

  MOV r7, #1
  ADD r8, r5, r7

  STR r8, [r4]
  STR r7, [r6]

  b endMoveBall

endMoveBall:

	POP {r4-r12,lr}
	MOV pc, lr
