.thumb

.include "../PlanDefs.s"

.global MM_FutureEffect
.type MM_FutureEffect, %function


		MM_FutureEffect:
		push	{r14}
		
		@Block standard gameplay from happening until this is complete
		ldr		r0, =gProc_PlayerPhase
		blh		ProcFind, r1
		mov		r1, r0
		ldr		r0, =ProcFutureCommand
		blh		ProcStartBlocking, r2
		
		mov		r0, #0x1B
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

