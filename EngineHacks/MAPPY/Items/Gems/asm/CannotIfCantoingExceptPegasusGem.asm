.thumb

.include "../GemDefs.s"

.global CannotIfCantoingExceptPegasusGem
.type CannotIfCantoingExceptPegasusGem, %function


		CannotIfCantoingExceptPegasusGem:
		push	{r14}
		ldr		r1, [r0,#0x0C]
		mov		r2, #0x40
		tst		r1, r2
		beq		CanUse
		
			ldr		r1, =PegasusGemLink
			ldrb	r1, [r1]
			blh		CountCopiesOfItem, r2
			cmp		r0, #0
			beq		End
		
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

