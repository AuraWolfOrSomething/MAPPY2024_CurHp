.thumb

.equ gMenuYCoordRepositioning, 0x085B6550

.global StartMenu_AndDoSomethingCommandsCont
.type StartMenu_AndDoSomethingCommandsCont, %function


		StartMenu_AndDoSomethingCommandsCont:
		push	{r4-r7,r14}
		mov		r5, r0
		mov		r0, #0
		mov		r12, r0
		mov		r2, #0x60
		mov		r3, #0x2D
		
		ldrb	r0, [r5,r2]
		ldr		r6, =gMenuYCoordRepositioning
		ldrb	r6, [r6,r0]

		ldrb	r1, [r5,r3]
		sub		r1, r6
		cmp		r1, #0
		bge		StoreNewYCoord
			
			neg		r0, r1
			mov		r12, r0
			mov		r1, #0
		
			StoreNewYCoord:
			strb	r1, [r5,r3]
			mov		r4, #0
			
			@I don't think this check is actually needed
			@ldrb	r0, [r5,r2]
			@cmp		r4, r0
			@bge		End
			
			mov		r7, r5
			add		r7, #0x34
			
			AdjustMenuCommandTextLoop:
			ldmia	r7, {r3}
			ldrb	r0, [r5,r2]
			ldrh	r0, [r3,#0x2C]
			sub		r0, r6
			mov		r1, r12
			add		r0, r1
			strh	r0, [r3,#0x2C]
			add		r4, #1
			ldrb	r0, [r5,r2]
			cmp		r4, r0
			blt		AdjustMenuCommandTextLoop
			
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

