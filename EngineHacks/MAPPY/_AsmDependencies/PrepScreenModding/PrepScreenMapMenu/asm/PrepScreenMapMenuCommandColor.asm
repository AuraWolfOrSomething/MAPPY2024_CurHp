.thumb

.global PrepScreenMapMenuCommandColor
.type PrepScreenMapMenuCommandColor, %function


		PrepScreenMapMenuCommandColor:
		push	{r14}
		mov		r3, #0 @default color (white)
		ldr		r0, [r0,#0x34] @text ID
		ldr		r2, =PrepScreenMapMenuColorConditionalList
		
		LoopThroughList:
		@if not found (end of the list), return r5
		ldr		r1, [r2]
		cmp		r1, #0
		beq		ReturnR3
		
			cmp		r0, r1
			beq		GoToContionalRoutine
			
				add		r2, #8
				b		LoopThroughList
				
		GoToContionalRoutine:
		ldr		r0, [r2,#4]
		mov		lr, r0
		.short	0xF800
		b		End
		
		ReturnR3:
		mov		r0, r3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

