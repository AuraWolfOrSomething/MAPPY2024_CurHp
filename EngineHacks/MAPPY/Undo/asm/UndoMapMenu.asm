.thumb

.include "../UndoDefs.s"

.global GetRemainingUndoUses
.type GetRemainingUndoUses, %function

.global MM_UndoUsability
.type MM_UndoUsability, %function

.global MM_UndoUsability2
.type MM_UndoUsability2, %function

.global MM_UndoColorUsability
.type MM_UndoColorUsability, %function

.global MM_UndoEffect
.type MM_UndoEffect, %function


@-----------------------------------------
@GetRemainingUndoUses
@-----------------------------------------


		GetRemainingUndoUses:
		ldr		r0, =UndoStatusRAMPointer
		ldr		r0, [r0]
		ldrb	r0, [r0]
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@MM_UndoUsability
@-----------------------------------------


		MM_UndoUsability:
		push	{r14}
		
		@if no Undos remaining, not usable
		blh		GetRemainingUndoUses, r0
		cmp		r0, #0
		beq		NotUsable
		
			@check if map menu command "Act" is usable
				@if so, don't allow this
			blh		MM_ActUsability, r0
			cmp		r0, #1
			beq		NotUsable
		
				mov		r0, #1
				b		End_MM_UndoUsability
			
		NotUsable:
		mov		r0, #3
		
		End_MM_UndoUsability:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@MM_UndoUsability2
@-----------------------------------------


		MM_UndoUsability2:
		ldr		r0, =UndoStatusRAMPointer
		ldr		r0, [r0]
		ldrb	r0, [r0,#1]
		cmp		r0, #0
		bne		NotUsable2
		
			ldr		r0, =UndoDataRAMPointer
			ldr		r0, [r0]
			ldr		r1, =UndoCopyListNonUnitSizePointer
			ldrh	r1, [r1]
			ldr		r0, [r0,r1]
			cmp		r0, #0
			beq		NotUsable2
			
				mov		r0, #1
				b		End_MM_UndoUsability2
				
		NotUsable2:
		mov		r0, #3
		
		End_MM_UndoUsability2:
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@MM_UndoColorUsability
@-----------------------------------------


		MM_UndoColorUsability:
		push	{r4-r7,r14}
		mov		r6, r0
		mov		r4, r1
		mov		r5, r4
		add		r5, #0x34
		
		blh		MM_UndoUsability2, r0
		mov		r1, #0 @text color (white)
		cmp		r0, #1
		beq		ChangeTextColor

			mov		r1, #1 @gray
			
		ChangeTextColor:
		mov		r0, r5
		blh		Text_SetColorId, r2

		@copying what the Guide does
		ldr		r0, [r4,#0x30]
		ldrh	r0, [r0,#4]
		blh		String_GetFromIndex, r1
		mov		r7, r0
		
		blh		GetRemainingUndoUses, r0
		mov		r1, #0
		mov		r2, #0 @non-zero if starting parenthese has been placed
		mov		r3, r7
		@add		r3, #6 @this is where the editing will begin
		add		r3, #5 @this is where the editing will begin

		HundredsDigitLoop:
		cmp		r0, #100
		blt		CheckHundredsDigit
		
			sub		r0, #100
			add		r1, #1
			b		HundredsDigitLoop
			
		CheckHundredsDigit:
		cmp		r1, #0
		ble		ExtraSpace1
		
			mov		r2, #0x28
			strb	r2, [r3]
			add		r3, #1
			add		r1, #0x30
			b		StoreHundredsDigit
			
			ExtraSpace1:
			mov		r1, #0x20
			
			StoreHundredsDigit:
			strb	r1, [r3]
			add		r3, #1
		
		mov		r1, #0
		
		TensDigitLoop:
		cmp		r0, #10
		blt		CheckTensDigit
		
			sub		r0, #10
			add		r1, #1
			b		TensDigitLoop
			
		CheckTensDigit:
		cmp		r1, #0
		bgt		CheckIfTensIsHighestDigit
		
			cmp		r2, #0
			beq		ExtraSpace2
		
				CheckIfTensIsHighestDigit:
				cmp		r2, #0
				bne		GetTensDigitTextCodeId
				
					mov		r2, #0x28
					strb	r2, [r3]
					add		r3, #1
				
					GetTensDigitTextCodeId:
					add		r1, #0x30
					b		StoreTensDigit
				
					ExtraSpace2:
					mov		r1, #0x20
					
					StoreTensDigit:
					strb	r1, [r3]
					add		r3, #1
			
		StoreOnesDigit:
		cmp		r2, #0
		bne		StoreOnesDigit_Cont
		
			mov		r2, #0x28
			strb	r2, [r3]
			add		r3, #1
		
		StoreOnesDigit_Cont:
		add		r0, #0x30
		strb	r0, [r3]
		
		mov		r0, #0x29 @ending parenthese
		strb	r0, [r3,#1]
		mov		r0, #0 @textcode [X]
		strb	r0, [r3,#2]

		@mov		r1, r0
		mov		r1, r7
		
		mov		r0, r5
		blh		Text_DrawString, r2
		mov		r0, r6
		add		r0, #0x64
		ldrb	r0, [r0]
		lsl		r0, #0x1C
		lsr		r0, #0x1E
		blh		GetBgMapBuffer, r1
		mov		r1, r0
		mov		r2, #0x2C
		ldsh	r0, [r4,r2]
		lsl		r0, #5
		mov		r3, #0x2A
		ldsh	r2, [r4,r3]
		add		r0, r2
		lsl		r0, #1
		add		r1, r0
		mov		r0, r5
		blh		Text_Display, r3

		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@MM_UndoEffect
@-----------------------------------------


		MM_UndoEffect:
		push	{r4,r14}
		mov		r4, r0
		blh		MM_UndoUsability2, r0
		cmp		r0, #1
		beq		UndoRetrieveEffect
			
			NothingEffect:
			mov		r0, r4
			ldr		r1, =UndoDenyEffectTextLink
			ldrh	r1, [r1]
			blh		MenuCallHelpBox, r2
			
			mov		r0, #8
			b		End_MM_UndoEffect
			
			UndoRetrieveEffect:
			ldr		r1, =UndoStatusRAMPointer
			ldr		r1, [r1]
			
			@Lower Undo uses by 1
			ldrb	r0, [r1]
			sub		r0, #1
			strb	r0, [r1]
			
			@Set Undo state 1 (do not allow Undo)
			@mov		r0, #1
			@strb	r0, [r1,#1]
			
			@Set Undo state 3 (do not allow Undo, do not update Suspend1)
			mov		r0, #3
			strb	r0, [r1,#1]
			
			@Give audio cue feedback
			mov		r0, #0x6B
			blh		m4aSongNumStart, r1
			
			blh		Undo_Retrieve, r0
			blh		UndoEMS_Reset, r0
			blh		EndBMAPMAIN, r0
			ldr		r0, =gProcStatePool
			blh		GameControl_8030FE4, r1
			
			mov		r0, #0x1B
		
		End_MM_UndoEffect:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

