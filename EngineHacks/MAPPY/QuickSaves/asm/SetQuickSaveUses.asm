.thumb

.include "../QuickSavesDefs.s"

.global SetQuickSaveUses
.type SetQuickSaveUses, %function


		SetQuickSaveUses:
		push	{r14}
		blh		GetChapterQuickSaveUses, r0
		ldr		r1, =QuickSavesRAMPointer
		ldr		r1, [r1]
		strb	r0, [r1]
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

