.thumb

.include "../DisplayAiOnMinimugBoxDefs.s"

.global AiToggleStatus
.type AiToggleStatus, %function


		AiToggleStatus:
		push	{r14}
		ldr		r0, =AiToggleEventIDLink
		ldrh	r0, [r0]
		blh		CheckEventID, r1
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

