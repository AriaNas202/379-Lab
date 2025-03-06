	.data
	.text
	.global lab_2_test

lab_2_test:
	PUSH {r4-r12,lr}  ; Store registers r4 through r12 and lr on the
		          ; stack. Do NOT modify this line of code. It
    			  ; ensures that the software convention is preserved,
			  ; and more importantly, that the return address is
			  ; preserved so that a proper return to the C wrapper
			  ; can be executed.

	; Your code to test your division and multiplication routines
	; go here.
	;
	; Use the MOV instruction to load the integers to test in
	; r0 and r1.  Then call your routines using the BL instructions
	; as shown below.
	;     BL division
	;     BL multiplication
        ;
	; To test, put values into registers BEFORE calling the
	; subroutine, not inside.  Putting the test values inside
	; the subroutine will prevent you from getting points for
	; your routines when the lab is graded.

	;HELLO IM TESTING HERE!!!!!!!!!!!!













lab_2_start:    ; USED FOR GRADING.  DO NOT MODIFY.
      	MOV r0, #30264   ; These three lines test 30264 / 97
	MOV r1, #97
	BL division      ; To test the division routine, set a breakpoint
                  	 ; at the following line and check the value in
                 	 ; r0 when the breakpoint is encountered.
	MOV r0, #251     ; These three lines test 251 * 64
	MOV r1, #64
	BL multiplication  ; To test the multiplication routine, set a
                   	   ; breakpoint at the following line and check
                   	   ; the value in r0 when the breakpoint is
                   	   ; encountered.

lab_2_end:      ; USED FOR GRADING.  DO NOT MODIFY.

	; After you’ve tested your routines, you can return to your
	; C wrapper using the POP & MOV instructions
	; shown below.

	POP {r4-r12,lr}	; Restore registers r4 through r12 and lr from
			; the stack. Do NOT modify this line of code.
    			; It ensures that the return address is preserved
 		        ; so that a proper return to the C wrapped can be
			; executed.
	MOV pc, lr

division:
	PUSH {r4-r12,lr}	; Store registers r4 through r12 and lr on the
				; stack. Do NOT modify this line of code.  It
    			      	; ensures that the return address is preserved
 		            	; so that a proper return to the C wrapped can be
			      	; executed.

	; Your code for the division routine goes here.


	;Initialization

				;Dividend r0
				;Divisor r1
	MOV r2, #15	;Counter r2 (init 15)
	MOV r3,#0	;Quotient r3 (init 0)
	MOV r4, #0	;Trash r4 (init 0)
	MOV r5, r0	;Remainder r5 (init r0, dividend)
	MOV r6, #0 ;Our "0" register, something to compare 0 to

	;SETUP (before loops)
	LSL r1, r1, #15 ; logical left shift divisor 15 places




	;Break 1 -> Major Outer Loop Start
Break1:	SUB r5, r5, r1 ; remainder = remainder - divisor

		CMP r5, r6 ; compare remainder to 0
		BLT Break2 ; Branch to B2 if r5(remainder)<0

		;No Branch to B2

		LSL r3,r3,#1 ;logical left shift quotient
		ORR r3,r3,#0x01 ;set quotient LSB to 1

	;Break 3 -> Going Back to Main Path after Fixing Remainder<0
Break3:
		LSR r1,r1,#1 ; logical right shift divisor (MSB=0)

		CMP r2,r6 ; compare counter to 0
		BGT Break4 ; branch to B4 if counter>0

		;NO BRANCH (which means we end here)
		;Break5
		B Break5

		;Break2 -> Remainder is less than 0, fix and then Branch to B3 on Main Path
Break2:
		ADD r5,r5,r1 ; remainder=remainder+divisor
		LSL r3,r3,#1 ; logical left shift quotient
		B Break3 ;After we dealt with remainder, we go back to shifting the divisor

		;Break4 -> Counter is more than 0, decrement counter and go back to start of Main Loop
Break4:
		SUB r2, r2, #1 ; decrament counter
		B Break1 ; branch to beginning of major loop


		;Break5 -> We've got the solution, save it in r0 and END
Break5:
		ADD r0,r3,#0 ; put the quotient into r0 to end


	POP {r4-r12,lr}		; Restore registers r4 through r12 and lr from
    				; the stack. Do NOT modify this line of code.
    			      	; It ensures that the return address is preserved
 		            	; so that a proper return to the C wrapped can be
			      	; executed.

	; The following line is used to return from the subroutine
	; and should be the last line in your subroutine.

	MOV pc, lr

multiplication:
	PUSH {r4-r12,lr}	; Store registers r4 through r12 and lr on the
				; stack. Do NOT modify this line of code.  It
    			     	; ensures that the return address is preserved
 		            	; so that a proper return to the C wrapped can be
			      	; executed.

	; Your code for the multiplication routine goes here.

	;Initialization!!!!!
	;r0 - factor (dont init)
	;r1 - factor (dont init)
	;r2 - counter (init 0)
	;r3 - product (init 0)
	;r4 - used as a temp trash register (init 0)

	MOV r2, #0 ;counter
	MOV r3, #0 ;product
	MOV r4, #0 ;trash

	;START WORKING!!!! MULTIPLICATION!!!!!!!

	;it doesnt work when r0 is 0 because we add r1 to product before checking add by 0, so adding another check up here
MulCheck:	CMP r2, r0 ;check to see r0==r2 (which is 0 rn)
			BEQ MulEnd ;if r0 and counter (0) are equal then it means we branch to the end (mult by 0)

MyLoop:	ADD r4, r3, r1 ; Add factor r1 to the final product, stored in trash reg
		ADD r3, r4, #0 ;Stores the new added product in product register r3

		ADD r2, r2, #1 ; increment the counter by 1

		B MulCheck ;Unconditional branch to the checker

MulEnd:	ADD r0, r3, #0 ;store product r3 in r0










	POP {r4-r12,lr}		; Restore registers r4 through r12 and lr from
    				; the stack. Do NOT modify this line of code.
    			      	; It ensures that the return address is preserved
 		            	; so that a proper return to the C wrapped can be
			      	; executed.

	; The following line is used to return from the subroutine
	; and should be the last line in your subroutine.

	MOV pc, lr
	.end
