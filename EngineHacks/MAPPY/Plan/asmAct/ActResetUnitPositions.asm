.thumb

.include "../PlanDefs.s"

.global ActResetUnitPositions
.type ActResetUnitPositions, %function


		ActResetUnitPositions:
		push	{r14}
		
		@Give audio cue feedback
		mov		r0, #0x6B
		blh		m4aSongNumStart, r1
		
		@Reset to before planning
		mov		r0, #4
		blh		LoadSuspendedGame, r1
		
		@Update visual display
		blh		EndBMAPMAIN, r0
		ldr		r0, =gProcStatePool
		blh		GameControl_8030FE4, r1

		pop		{r0}
		bx		r0
		
		.align
		.ltorg

