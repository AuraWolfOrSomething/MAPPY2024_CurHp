@Requires new StartMenu_AndDoSomethingCommands

.thumb

.global ReuseCursorLocation
.type ReuseCursorLocation, %function


		ReuseCursorLocation:
		cmp		r0, #0
		beq		End
		
			ldr		r3, =ReusableTempRAMPointer
			ldr		r3, [r3]
			ldr		r3, [r3,#0x28]
			mov		r2, #0x61
			ldrb	r1, [r0,r2]
			strb	r1, [r3,r2]
			add		r2, #1
			strb	r1, [r3,r2]
		
		End:
		bx		r14
		
		.align
		.ltorg

