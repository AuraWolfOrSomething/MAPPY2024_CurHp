.thumb

.include "../DisplayAiOnMinimugBoxDefs.s"

.global ToggleAiDisplay
.type ToggleAiDisplay, %function


		ToggleAiDisplay:
		push	{r4,r14}
		ldr		r4, =AiToggleEventIDLink
		
		@If AI display is off, turn it on
		  @Otherwise, if AI display is on, turn if off
		blh		AiToggleStatus, r0
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

