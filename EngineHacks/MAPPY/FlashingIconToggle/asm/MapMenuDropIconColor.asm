.thumb

.include "../FlashingIconToggleDefs.s"

.global MapMenuDropIconColor
.type MapMenuDropIconColor, %function


		MapMenuDropIconColor:
		push	{r4-r5,r14}
		mov		r5, r0
		mov		r4, r1
		blh		DropIconColor, r0
		
		mov		r1, r0
		mov		r0, r4
		add		r0, #0x34
		mov		r2, r4
		mov		r3, r5
		blh		ChangeMapMenuCommandColor, r5
		
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

