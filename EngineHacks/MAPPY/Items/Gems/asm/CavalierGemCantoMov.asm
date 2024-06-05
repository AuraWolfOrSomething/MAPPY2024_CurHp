.thumb

.include "../GemDefs.s"

.global CavalierGemCantoMov
.type CavalierGemCantoMov, %function


		CavalierGemCantoMov:
		push	{r4,r14}
		mov		r4, r0 @stat
		
		@Skip if not cantoing
		ldr		r2, [r1,#0x0C] @unit state
		mov		r3, #0x40
		tst		r2, r3
		beq		End
		
			@Succeed if selected & grayed out (0x1 + 0x2), but not if only grayed out (0x2)
			mov		r3, #2
			tst		r2, r3
			beq		CountCavalierGems
			
				mov		r3, #3
				and		r2, r3
				cmp		r2, #3
				bne		End
		
					CountCavalierGems:
					mov		r0, r1
					ldr		r1, =CavalierGemLink
					ldrb	r1, [r1]
					blh		CountCopiesOfItem, r2
					cmp		r0, #0
					beq		End
					
						ldr		r1, =CavalierGemMovLink
						ldrb	r1, [r1]
						mul		r0, r1
						add		r4, r0
		
		End:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

