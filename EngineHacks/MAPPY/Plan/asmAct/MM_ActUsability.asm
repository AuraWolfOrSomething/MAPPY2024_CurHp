.thumb

.include "../PlanDefs.s"

.global MM_ActUsability
.type MM_ActUsability, %function


		MM_ActUsability:
		push	{r14}
		ldr		r0, =PlanEventIDLink
		ldrh	r0, [r0]
		blh		CheckEventID, r1
		cmp		r0, #0
		beq		ActUnusable
		
			mov		r0, #1
			b		End
		
		ActUnusable:
		mov		r0, #3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

