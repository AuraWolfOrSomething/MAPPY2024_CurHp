.thumb

.include "../FlashingIconToggleDefs.s"

.global BossIconStatus
.type BossIconStatus, %function


		BossIconStatus:
		push	{r14}
		ldr		r0, =BossIconToggleEventIDLink
		ldrh	r0, [r0]
		blh		CheckEventID, r1
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

