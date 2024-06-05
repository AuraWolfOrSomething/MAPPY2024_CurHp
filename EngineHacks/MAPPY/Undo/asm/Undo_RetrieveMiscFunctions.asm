.thumb

.include "../UndoDefs.s"

.global Undo_RetrieveDebuffs
.type Undo_RetrieveDebuffs, %function


@-----------------------------------------
@Undo_RetrieveDebuffs
@-----------------------------------------


		Undo_RetrieveDebuffs:
		push	{r4,r14}
		mov		r4, r0
		
		mov		r0, r1
		blh		GetDebuffs, r1
		ldr		r2, =UndoEntrySizeTable
		ldrb	r3, [r4]
		ldrb	r3, [r2,r3]
		sub		r3, #2
		mov		r2, #0
		add		r4, #2
		
		Loop_Undo_RetrieveDebuffs:
		ldrb	r1, [r4,r2]
		strb	r1, [r0,r2]
		add		r2, #1
		cmp		r2, r3
		blt		Loop_Undo_RetrieveDebuffs
		
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

