.thumb

.include "../MultipleHelpTextPagesDefs.s"

.global DoesCharHaveMultipleEffects
.type DoesCharHaveMultipleEffects, %function


		DoesCharHaveMultipleEffects:
		push	{r14}
		ldr		r0, [r1,#0x0C]
		blh		CountActiveEffects, r1
		cmp		r0, #2
		bge		ReturnTrue
		
			mov		r0, #0
			b		End
		
		ReturnTrue:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

