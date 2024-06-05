.thumb

.include "../GemDefs.s"

.global CountRookieGems
.type CountRookieGems, %function


		CountRookieGems:
		push	{r14}
		ldr		r1, =RookieGemLink
		ldrb	r1, [r1]
		blh		CountCopiesOfItem, r2
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

