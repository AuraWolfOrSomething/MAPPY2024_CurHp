.thumb

.include "../PrepScreenDifficultyDefs.s"

.global LoadNewDifficultyUnits
.type LoadNewDifficultyUnits, %function


		LoadNewDifficultyUnits:
		push	{r14}
		ldr		r0, =gChapterData
		ldrb	r0, [r0,#0x0E]
		ldr		r1, =ReloadingChapterUnitsTable
		lsl		r0, #2
		ldr		r0, [r1,r0]
		cmp		r0, #0
		beq		End
		
			mov		r1, #1
			blh		StartMapEventEngine, r2
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

