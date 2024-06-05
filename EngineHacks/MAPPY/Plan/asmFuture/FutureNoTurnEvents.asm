.thumb

.include "../PlanDefs.s"

.global FutureNoTurnEvents
.type FutureNoTurnEvents, %function


		FutureNoTurnEvents:
		push	{r14}
		ldr		r0, =FutureNoMoreTurnEventsEvent
		mov		r1, #1
		blh		CallMapEventEngine, r2
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

