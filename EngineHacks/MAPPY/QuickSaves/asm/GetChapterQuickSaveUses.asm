.thumb

.include "../QuickSavesDefs.s"

.global GetChapterQuickSaveUses
.type GetChapterQuickSaveUses, %function


		GetChapterQuickSaveUses:
		ldr		r0, =ChapterQuickSaveTable
		ldr		r1, =gChapterData
		ldrb	r1, [r1,#0x0E]
		ldrb	r0, [r0,r1]
		bx		r14
		
		.align
		.ltorg

