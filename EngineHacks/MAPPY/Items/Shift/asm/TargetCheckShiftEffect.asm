.thumb

.include "../ShiftDefs.s"

.global TargetCheckShiftEffect
.type TargetCheckShiftEffect, %function


		TargetCheckShiftEffect:
		push	{r4,r14}
		mov		r4, #0
		
		mov		r0, r1
		blh		IsShiftEffectActive, r1
		cmp		r0, #0
		bne		End
		
			mov		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

