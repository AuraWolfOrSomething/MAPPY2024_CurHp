.thumb

.include "../PlanDefs.s"

.global MM_PlanEffect
.type MM_PlanEffect, %function


		MM_PlanEffect:
		push	{r14}
		blh		PlanSaveUnitPositions, r0
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

