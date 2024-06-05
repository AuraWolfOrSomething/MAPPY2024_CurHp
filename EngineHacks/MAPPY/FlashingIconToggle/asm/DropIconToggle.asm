.thumb

.include "../FlashingIconToggleDefs.s"

.global DropIconToggle
.type DropIconToggle, %function


		DropIconToggle:
		push	{r4,r14}
		ldr		r4, =DropIconToggleEventIDLink
		
		@If drop icon is off, turn it on
		  @Otherwise, if it's on, turn it off
		blh		DropIconStatus, r0
		cmp		r0, #1
		beq		TurnDisplayOff

			ldr		r1, =SetEventID
			b		ChangeDisplay
		
		TurnDisplayOff:
		ldr		r1, =UnsetEventID
		
		ChangeDisplay:
		ldrb	r0, [r4]
		mov		lr, r1
		.short	0xF800
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

