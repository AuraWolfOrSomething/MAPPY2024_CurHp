.thumb

.include "../PlanDefs.s"

.global PlanSaveUnitPositions
.type PlanSaveUnitPositions, %function


		PlanSaveUnitPositions:
		push	{r14}
		
		@Give audio cue feedback
		mov		r0, #0x6A
		blh		m4aSongNumStart, r1
		
		@Save to suspend data
		@ldr		r0, =PlayerPhase_Suspend
		@mov		lr, r0
		@.short	0xF800
		
		@Set Undo state 2 (do not change Undo data, do not update Suspend1)
		ldr		r1, =UndoStatusRAMPointer
		ldr		r1, [r1]
		mov		r0, #2
		strb	r0, [r1,#1]
		
		ldr		r1, =gActionData
		mov		r0, #0
		strb	r0, [r1,#0x16]
		mov		r0, #4
		blh		SaveSuspendNoConditions, r1
		
		@Set event ID
		ldr		r0, =PlanEventIDLink
		ldrh	r0, [r0]
		blh		SetEventID, r1
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

