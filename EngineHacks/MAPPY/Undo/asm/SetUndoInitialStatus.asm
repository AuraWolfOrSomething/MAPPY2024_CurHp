.thumb

.include "../UndoDefs.s"

.global SetUndoInitialStatus
.type SetUndoInitialStatus, %function


		SetUndoInitialStatus:
		
		@Get initial amount of uses
		ldr		r0, =ChapterUndoTable
		ldr		r1, =gChapterData
		ldrb	r1, [r1,#0x0E]
		ldrb	r0, [r0,r1]
		
		@Store uses
		ldr		r1, =UndoStatusRAMPointer
		ldr		r1, [r1]
		strb	r0, [r1]
		
		@Set Undo state 1 (do not allow Undo)
		mov		r0, #1
		strb	r0, [r1,#1]
		
		bx		r14
		
		.align
		.ltorg

