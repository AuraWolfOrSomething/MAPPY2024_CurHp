.thumb

.include "../QuickSavesDefs.s"

.global MM_QuickSaveEffect
.type MM_QuickSaveEffect, %function


		MM_QuickSaveEffect:
		push	{r14}
		ldr		r1, =gActionData
		mov		r0, #0
		strb	r0, [r1,#0x16]
		
		@Lower QuickSave uses by 1
		ldr		r1, =QuickSavesRAMPointer
		ldr		r1, [r1]
		ldrb	r0, [r1]
		sub		r0, #1
		strb	r0, [r1]
		
		@Set Undo state 1 (do not allow Undo)
		mov		r0, #1
		strb	r0, [r1,#1]
		
		@Actually go save
		mov		r0, #3
		blh		SaveSuspendNoConditions, r1
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

