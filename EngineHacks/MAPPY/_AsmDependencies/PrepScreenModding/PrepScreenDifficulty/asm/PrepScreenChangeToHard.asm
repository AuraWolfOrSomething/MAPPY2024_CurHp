.thumb

.include "../PrepScreenDifficultyDefs.s"

.global PrepScreenChangeToHard
.type PrepScreenChangeToHard, %function


		PrepScreenChangeToHard:
		push	{r4,r14}
		mov		r4, r0
		
		@If already Hard Mode, don't do anything
		ldr		r2, =gChapterData
		ldrb	r0, [r2,#0x14]
		mov		r1, #0x40
		tst		r0, r1
		bne		SameDifficulty
			
			@Set Hard Mode by setting bit
			orr		r0, r1
			strb	r0, [r2,#0x14]
			
			@Make sure Chill Mode isn't on
			mov		r3, #0x42
			ldrb	r0, [r2,r3]
			mov		r1, #0x20
			orr		r0, r1
			strb	r0, [r2,r3]
			
			ldr		r0, =gProc_DifficultySwap
			mov		r1, r4
			blh		ProcStartBlocking, r2
			pop		{r4}
			pop		{r0}
			bx		r0
			
		SameDifficulty:
		@Continue accepting button inputs
		mov		r0, r4
		mov		r1, #0x3D
		blh		ProcGoto, r2
		
		pop		{r4}
		pop		{r0}
		
		@Only play sound effect if settings has sound and/or music on
		ldr		r0, =PlayDenySoundEffect
		bx		r0
		
		.align
		.ltorg

