.thumb

.include "../DisplayAiOnMinimugBoxDefs.s"

.global AiToggleColor
.type AiToggleColor, %function


		AiToggleColor:
		push	{r14}
		blh		AiToggleStatus, r0
		
		cmp		r0, #0
		beq		OffColor
			
			mov		r0, #3 @Orange
			b		End
			
		OffColor:
		mov		r0, #1 @gray
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

