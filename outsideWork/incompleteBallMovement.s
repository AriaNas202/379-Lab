moveBall:
	PUSH {r4-r12,lr} ; Spill registers to stack



	;load the x coordinate (r5)
	ldr r4, ptr_to_ballflagX ;address to x coordinate (r4)
	ldr r5, [r4]

	;load the x direction (r7)
	ldr r6, ptr_to_BDFlagX ;address to x direction (r6)
	ldr r7, [r6]


    ;where is the ball located (determines which collisions we check)
	CMP r5, #80  ;check collision with right paddle
    BEQ checkRightPaddleCollision

  	CMP r5, #3 ;check collision with left paddle

    CMP r5, #81 ;score point for left player (we're in right's endzone) 

    CMP r5, #2 ;score point for right player (we're in left's endzone)
    
    B NoXEdgeCases ; no weird edge cases for x, skipp all edge cases for X



checkRightPaddleCollision:
    ;check if ball is moving right (if its not then we dont have a collision )
    CMP r7, #1
    BEQ NoXEdgeCases

    ;we are moving right, potential collision 

    ;get paddle position Right (r8)
    ldr r8, ptr_to_PaddlePosR
    ldr r8, [r8]

    ;get the y coordinate (r9)
	ldr r9, ptr_to_ballflagY 
	ldr r9, [r9]

    ;check if ball hit the middle of of paddle 
    CMP r9, r8  ;did we hit middle of paddle?
    BEQ ccRight1
    SUB r10, r8, #1 ;did we hit top of paddle
    CMP r9, r10  
    BEQ ccRight2
    ADD r10, r8, #1 ;did we hit bottom of paddle
    CMP r9, r10 
    BEQ ccRight3
    B NoXEdgeCases ;we did not hit paddle 


ccRight1:
    MOV r6, #1
    B endMoveBall
ccRight2:
    MOV r6, #1
    MOV r11, #-1
    B endMoveBall
ccRight3
    MOV r6, #1
    MOV r11, #1
    B endMoveBall



    


NoXEdgeCases:
    ;NO SPECIAL EDGE CASES, HANDLE REGULAR MOVEMENT AS NORMAL
    ADD r8, r5, r7		; Move the ball to the right
	STR r8, [r4]
	b endMoveBall




endMoveBall:

	POP {r4-r12,lr}
	MOV pc, lr




































































