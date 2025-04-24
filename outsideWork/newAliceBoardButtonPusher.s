;Updated Alice Button Function 
;used to handle setting the winning game score

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
    
    LDR r2, [r1, #0x3FC]    ;Get Register which reads the buttons

    ;mask last 4 bits
    AND r0, r2, #0xF




	POP {r4-r12,lr}   ; Restore registers from stack
	MOV pc, lr
