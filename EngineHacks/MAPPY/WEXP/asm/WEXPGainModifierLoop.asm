.thumb

.include "../WEXPDefs.s"
.equ SRankWEXP, 251

.global WEXPGainModifierLoop
.type WEXPGainModifierLoop, %function


		WEXPGainModifierLoop:
		push	{r4-r7,r14}
		mov		r4, r0 @item WEXP
		mov		r5, r1 @unit
		mov		r6, r2 @unit WEXP in current item type
		ldr		r7, =WEXPGainModifierList
		
		LoopThroughModifierList:
		ldr		r2, [r7]
		cmp		r2, #0
		beq		AddToUnitWEXP
		
			mov		r0, r4
			mov		r1, r5
			mov		lr, r2
			.short	0xF800
			cmp		r0, r4
			beq		NextModifierEntry
			
				mov		r4, r0
				ldr		r1, [r7,#4]
				cmp		r1, #0
				bne		AddToUnitWEXP
				
				NextModifierEntry:
				add		r7, #8
				b		LoopThroughModifierList
		
		AddToUnitWEXP:
		add		r0, r6
		cmp		r0, #SRankWEXP
		ble		End
		
			mov		r0, #SRankWEXP
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

