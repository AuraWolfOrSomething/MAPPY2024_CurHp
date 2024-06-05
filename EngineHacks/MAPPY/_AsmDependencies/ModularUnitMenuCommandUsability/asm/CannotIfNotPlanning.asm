.thumb

.include "../MumcuDefs.s"

.global CannotIfNotPlanning
.type CannotIfNotPlanning, %function


		CannotIfNotPlanning:
		push	{r14}
		ldr		r0, =PlanEventIDLink
		ldrh	r0, [r0]
		blh		CheckEventID, r1
		cmp		r0, #0
		beq		CannotUse
		
			mov		r0, #1
			b		End
		
		CannotUse:
		mov		r0, #0
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

