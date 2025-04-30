

gameTimer:
    PUSH {r4-r12,lr}

    ;move cursor to print game time 
    MOV r0, #37
	MOV r1, #2
	bl moveCursor	

    ldr r2, ptr_to_gameTimer
	ldr r1, [r2]
	add r1,r1,#1
	str r1, [r2]			;increment timer
	
    ldr r0, ptr_to_trash
    ldr r3, prt_to_timeTracker
    ldr r3,[r3]
	mov r2,#35;;;;;;;;;;;;;;;;;;;;;;;THIS NEEDS TO BE DYNAMIC 
	UDIV r1, r1, r2

	bl int2string			;turn int into string for timer

	ldr r0, ptr_to_trash
	bl output_string			;print timer




    POP {r4-r12,lr}
    MOV pc, lr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;time tracker, init to #30
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;in dynamic time function 
    ;35 FPS
dt1:
    ;reset timer handler to interrupt more 
	MOV r0, #0xF9B6
    MOVT r0, #0x0006
    bl gpio_interrupt_init
    ;change time tracker (for game time)
    ldr r0, ptr_to_timeTracker
    MOV r1, #35
    str r1, [r0]
    ;end
    B end_Dynamic_Timer

;40 fps
dt2:
	MOV r0, #0x1A80
    MOVT r0, #0x0006
    bl gpio_interrupt_init
    ;change time tracker (for game time)
    ldr r0, ptr_to_timeTracker
    MOV r1, #40
    str r1, [r0]
    B end_Dynamic_Timer

;45 fps
dt3:
	MOV r0, #0x6CE3
    MOVT r0, #0x0005
    bl gpio_interrupt_init
    ;change time tracker (for game time)
    ldr r0, ptr_to_timeTracker
    MOV r1, #45
    str r1, [r0]
    B end_Dynamic_Timer

;50 fps
dt4:
	MOV r0, #0xE200
    MOVT r0, #0x0004
    bl gpio_interrupt_init
    ;change time tracker (for game time)
    ldr r0, ptr_to_timeTracker
    MOV r1, #50
    str r1, [r0]
    B end_Dynamic_Timer
;55fps
dt5:
	MOV r0, #0x705D
    MOVT r0, #0x0004
    bl gpio_interrupt_init
    ;change time tracker (for game time)
    ldr r0, ptr_to_timeTracker
    MOV r1, #55
    str r1, [r0]
    B end_Dynamic_Timer
;60fps
dt6:
	MOV r0, #0x11AA
    MOVT r0, #0x0004
    bl gpio_interrupt_init
    ;change time tracker (for game time)
    ldr r0, ptr_to_timeTracker
    MOV r1, #60
    str r1, [r0]
    B end_Dynamic_Timer
