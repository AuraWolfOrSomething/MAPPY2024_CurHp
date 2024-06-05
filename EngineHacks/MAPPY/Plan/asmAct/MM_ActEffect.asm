.thumb

.include "../PlanDefs.s"

.global MM_ActEffect
.type MM_ActEffect, %function


		MM_ActEffect:
		push	{r14}
		blh		ActResetUnitPositions, r0
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

