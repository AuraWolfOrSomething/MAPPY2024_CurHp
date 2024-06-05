.thumb

.include "../PlanDefs.s"

.global MM_FutureUsability
.type MM_FutureUsability, %function


		MM_FutureUsability:
		push	{r4-r6,r14}
		mov		r6, r0
		mov		r4, r1
		mov		r5, r4
		add		r5, #0x34
		
		blh		FutureCheckForRemainingTurnEvents, r0
		mov		r1, #4 @text color (green)
		cmp		r0, #0
		bne		ChangeTextColor
		
			mov		r1, #1 @gray
			
		ChangeTextColor:
		mov		r0, r5
		blh		Text_SetColorId, r2
		
		DrawFutureText:
		@copying what the Guide does
		ldr		r0, [r4,#0x30]
		ldrh	r0, [r0,#4]
		blh		String_GetFromIndex, r1
		mov		r1, r0
		mov		r0, r5
		blh		Text_DrawString, r2
		mov		r0, r6
		add		r0, #0x64
		ldrb	r0, [r0]
		lsl		r0, #0x1C
		lsr		r0, #0x1E
		blh		GetBgMapBuffer, r1
		mov		r1, r0
		mov		r2, #0x2C
		ldsh	r0, [r4,r2]
		lsl		r0, #5
		mov		r3, #0x2A
		ldsh	r2, [r4,r3]
		add		r0, r2
		lsl		r0, #1
		add		r1, r0
		mov		r0, r5
		blh		Text_Display, r3
		
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

