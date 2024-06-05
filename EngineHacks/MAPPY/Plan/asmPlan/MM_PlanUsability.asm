.thumb

.include "../PlanDefs.s"

.global MM_PlanUsability
.type MM_PlanUsability, %function


		MM_PlanUsability:
		push	{r14}
		ldr		r0, =PlanEventIDLink
		ldrh	r0, [r0]
		blh		CheckEventID, r1
		cmp		r0, #0
		bne		PlanUnusable
		
			@cannot use if first chapter
			ldr		r1, =gChapterData
			ldrb	r0, [r1,#0x0E]
			cmp		r0, #0
			beq		PlanUnusable
		
				mov		r0, #1
				b		End
		
		PlanUnusable:
		mov		r0, #3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

