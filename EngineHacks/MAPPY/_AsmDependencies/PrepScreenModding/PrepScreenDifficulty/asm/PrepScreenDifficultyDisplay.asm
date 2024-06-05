.thumb

.include "../PrepScreenDifficultyDefs.s"

.global PrepScreenDifficultyDisplay
.type PrepScreenDifficultyDisplay, %function


		PrepScreenDifficultyDisplay:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =PrepScreenDifficultyDisplayIDLink
		ldrb	r1, [r1]
		str		r1, [r0,#0x58]
		
		@Draw new menu
		mov		r0, r4
		blh		SetUpPrepScreenDifficultyMenu, r1
		mov		r0, r4
		mov		r1, #0x3D
		blh		ProcGoto, r2
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

