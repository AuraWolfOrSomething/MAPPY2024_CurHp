.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gActiveUnit, 0x03004E50
.equ Suspend2UpdateException, 0x0801D231

.global SaveSuspendConditions
.type SaveSuspendConditions, %function


		SaveSuspendConditions:
		push	{r4-r7,r14}
		mov		r7, r14
		cmp		r0, #4
		beq		DoNotUpdate_End
		
			@check if map menu command "Act" is usable
			  @if so, don't update suspend data
			  @if not, continue check
			blh		MM_ActUsability, r0
			cmp		r0, #1
			beq		DoNotUpdate_End
			
		
		@blh		UndoEMS_Reset, r0
		
		ldr		r6, =UndoStatusRAMPointer
		ldr		r6, [r6]
		ldrb	r0, [r6,#1]
		cmp		r0, #2
		bge		SetUndoState0
		
			@cmp		r0, #1
			@beq		UndoState1
			
				blh		UndoEMS_Reset, r0
				
				@ldrb	r0, [r6,#1]
				@cmp		r0, #0
				@bne		SetUndoState0
				
				ldrb	r0, [r6,#1]
				cmp		r0, #1
				beq		QuickSaveCheck
				
					blh		UndoEMS_Copy, r0
				
				@SetUndoState0:
				@mov		r0, #0
				@strb	r0, [r6,#1]
				@b		QuickSaveCheck
				
		QuickSaveCheck:
		@if a quick save has been used, do not update Suspend1
		blh		GetChapterQuickSaveUses, r0
		mov		r5, r0
		blh		GetRemainingQuickSaveUses, r0
		cmp		r0, r5
		@bne		UpdateSuspend2
		bne		SetUndoState0
		@bne		UndoState2
		
			mov		r0, #3
			blh		GoToLynJump_MS_SaveSuspend
			
		SetUndoState0:
		mov		r0, #0
		strb	r0, [r6,#1]
		
		UpdateSuspend2:
		ldr		r0, =Suspend2UpdateException
		cmp		r0, r7
		beq		DoNotUpdate_End
		
			mov		r0, #4
			blh		GoToLynJump_MS_SaveSuspend
			
		DoNotUpdate_End:
		End_SaveSuspendConditions:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

		GoToLynJump_MS_SaveSuspend:

