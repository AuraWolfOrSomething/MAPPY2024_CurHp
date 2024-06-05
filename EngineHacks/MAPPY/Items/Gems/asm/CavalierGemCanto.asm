.thumb

.include "../GemDefs.s"

.global CavalierGemCanto
.type CavalierGemCanto, %function

@copied from canto/cantoplus

		CavalierGemCanto:
		push	{r7,lr}
		
		@check if dead
		ldrb	r0, [r4,#0x13]
		cmp		r0, #0x00
		beq		End
		
		@check if already cantoing, and is not in a ballista
		ldr		r0, [r4,#0x0C] @status bitfield
		mov		r1, #0x21
		lsl		r1, #0x06 @has moved already and is in a ballista
		tst		r0, r1
		bne		End
		
		@check if waited
		ldrb	r0, [r6,#0x11]
		cmp		r0, #1
		beq		End
		
		@check if enemy/npc
		ldrb	r0, [r4,#0x0B]
		lsr		r0, #6
		cmp		r0, #0
		bne		End

		@check for item
		mov		r0, r4
		ldr		r1, =CavalierGemLink
		ldrb	r1, [r1]
		blh		CountCopiesOfItem, r2
		cmp		r0, #0
		beq		End
		
		@check if flag 0x3 set; if so, cannot canto
		mov		r0, #3
		blh		CheckEventId, r1
		cmp 	r0, #1
		beq 	End
		
		blh 	RefreshEntityMaps, r0
		
		@Cavalier Gem increases the movement unit does while Cantoing, but one of the conditions for CanActiveUnitMove is having at least 1 unused mov; increase unit Mov for this check by setting Canto state early (the Cavalier Gem mov bonus will apply)
		ldr		r7, [r4,#0x0C]
		mov		r0, #0x40
		orr		r7, r0
		str		r7, [r4,#0x0C]
		blh		CanActiveUnitMove, r0
		lsl		r0, #0x18
		cmp		r0, #0x00
		beq		UnsetCantoBit
		
			@Unset 0x2 (0x40 for Cantoing already set)
			mov		r0, #0x02
			mvn		r0, r0
			and		r7, r0
			str		r7, [r4,#0x0C]
			b		End
			
			UnsetCantoBit:
			mov		r0, #0x40
			mvn		r0, r0
			and		r7, r0
			str		r7, [r4,#0x0C]
		
		End:
		pop		{r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

