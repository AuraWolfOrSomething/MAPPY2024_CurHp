.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xf800
.endm

.equ gActiveBattleUnit, 0x0203A4EC

.global VigorEdgeRegainAction
.type VigorEdgeRegainAction, %function


		VigorEdgeRegainAction:
		push	{r14}
		
		@skip if dead
		ldrb	r0, [r4,#0x13]
		cmp		r0, #0
		beq		End
		
			@skip if didn't attack
			ldrb	r0, [r6,#0x11]
			cmp		r0, #2
			bne		End
			
			ldrb	r0, [r6,#0x0C]
			ldrb	r1, [r4,#0x0B]
			cmp		r0, r1
			bne		End
			
				@check for VigorEdge
				mov		r0, #0x4A
				ldr		r1, =gActiveBattleUnit
				ldrb	r0, [r1,r0]
				ldr		r1, =VigorEdgeIDLink
				ldrb	r1, [r1]
				cmp		r0, r1
				bne		End
				
					@unset grayed status
					ldr		r0, [r4,#0x0C]
					mov		r1, #0x42
					mvn		r1, r1
					and		r0, r1
					str		r0, [r4,#0x0C]
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

