.thumb

.include "../GemDefs.s"

.global ArcherGemEffect
.type ArcherGemEffect, %function


		ArcherGemEffect:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =ArcherGemLink
		ldrb	r1, [r1]
		blh		CountCopiesOfItem, r2
		cmp		r0, #0
		beq		End
		
			ldr		r1, =ArcherGemHitLink
			ldrb	r1, [r1]
			mul		r1, r0
			mov		r2, #0x60
			ldrh	r0, [r4,r2]
			add		r0, r1
			strh	r0, [r4,r2]
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

