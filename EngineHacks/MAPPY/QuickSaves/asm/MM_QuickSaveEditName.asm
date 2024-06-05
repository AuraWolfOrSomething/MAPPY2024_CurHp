.thumb

.include "../QuickSavesDefs.s"

.global MM_QuickSaveEditName
.type MM_QuickSaveEditName, %function


		MM_QuickSaveEditName:
		push	{r4,r14}
		blh		String_GetFromIndex, r1
		mov		r4, r0
		
		blh		GetRemainingQuickSaveUses, r0
		mov		r1, #0
		mov		r2, #0 @non-zero if starting parenthese has been placed
		mov		r3, r4
		add		r3, #4 @this is where the editing will begin

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
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

