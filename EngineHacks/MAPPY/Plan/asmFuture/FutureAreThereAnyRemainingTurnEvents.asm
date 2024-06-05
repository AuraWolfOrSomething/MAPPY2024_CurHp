.thumb

.include "../PlanDefs.s"

.global FutureAreThereAnyRemainingTurnEvents
.type FutureAreThereAnyRemainingTurnEvents, %function


		FutureAreThereAnyRemainingTurnEvents:
		push	{r4,r14}
		mov		r4, r0
		
		blh		FutureCheckForRemainingTurnEvents, r0
		cmp		r0, #0
		bne		End
		
			mov		r0, r4
			mov		r1, #2
			blh		ProcGoto, r2
		
		End:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

