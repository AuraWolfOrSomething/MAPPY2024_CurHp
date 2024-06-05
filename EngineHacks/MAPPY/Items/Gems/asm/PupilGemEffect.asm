.thumb

.include "../GemDefs.s"

.global PupilGemEffect
.type PupilGemEffect, %function

@lower weapon rank requirements by number of pupil gems in unit inventory


		PupilGemEffect:
		push	{r14}
		ldr		r1, =PupilGemLink
		ldrb	r1, [r1]
		blh		CountCopiesOfItem, r2
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

