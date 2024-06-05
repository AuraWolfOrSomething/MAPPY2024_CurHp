.thumb

.include "../PrepScreenDifficultyDefs.s"

.global PrepScreenChangeToNormal
.type PrepScreenChangeToNormal, %function


		PrepScreenChangeToNormal:
		push	{r4,r14}
		mov		r4, r0
		
		@If Chill Mode, set to Normal
		ldr		r2, =gChapterData
		mov		r3, #0x42
		ldrb	r0, [r2,r3]
		mov		r1, #0x20
		tst		r0, r1
		beq		SetNonChillMode
		
			@If Normal Mode, skip to the end
			ldrb	r0, [r2,#0x14]
			mov		r1, #0x40
			tst		r0, r1
			beq		SameDifficulty
			
				@Unset Hard Mode
				mvn		r1, r1
				and		r0, r1
				strb	r0, [r2,#0x14]
				b		StartDifficultyProc
				
				SetNonChillMode:
				orr		r0, r1
				strb	r0, [r2,r3]
				
				StartDifficultyProc:
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

