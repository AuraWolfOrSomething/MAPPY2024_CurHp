.thumb

.include "../FlashingIconToggleDefs.s"

.global DropIconStatus
.type DropIconStatus, %function


		DropIconStatus:
		push	{r14}
		ldr		r0, =DropIconToggleEventIDLink
		ldrh	r0, [r0]
		blh		CheckEventID, r1
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

