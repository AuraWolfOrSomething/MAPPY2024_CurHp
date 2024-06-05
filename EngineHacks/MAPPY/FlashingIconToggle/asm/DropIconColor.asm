.thumb

.include "../FlashingIconToggleDefs.s"

.global DropIconColor
.type DropIconColor, %function


		DropIconColor:
		push	{r14}
		blh		DropIconStatus, r0
		
		cmp		r0, #0
		beq		OffColor
			
			mov		r0, #3 @Orange
			b		End
			
		OffColor:
		mov		r0, #1 @gray
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

