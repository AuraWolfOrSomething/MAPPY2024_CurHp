.thumb

.include "../ConditionDefs.s"

.global ConditionHelpTextSpace
.type ConditionHelpTextSpace, %function


		ConditionHelpTextSpace:
		push	{r4-r6,r14}
		mov		r4, r0 @width required by text id
		mov		r5, r1 @total number of lines helptext requires multiplied by 0x10
		mov		r6, r2 @where to store the above information
		
		@See how many effects this unit has
			@If only one, then we just need one line for labels
		ldr		r0, =StatScreenStruct
		ldr		r0, [r0,#0x0C]
		blh		CountActiveEffects, r1
		add		r5, #0x10
		cmp		r0, #1
		ble		LessThanFourEffectsWidthCheck
		
			add		r5, #0x10
			cmp		r0, #3
			ble		LessThanFourEffectsWidthCheck
			
				@Confirm width is at a specific minimum
				cmp		r4, #0xBF
				bgt		End
				
					mov		r4, #0xC0
					b		End
		
		LessThanFourEffectsWidthCheck:
		
		@Confirm width is at a specific minimum
		cmp		r4, #0x9F
		bgt		End
		
			mov		r4, #0xA0
		
		End:
		add		r6, #0x44
		strh	r4, [r6]
		strh	r5, [r6,#2]
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

