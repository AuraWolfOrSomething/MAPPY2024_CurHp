.thumb

.include "../QuickSavesDefs.s"

.global GetRemainingQuickSaveUses
.type GetRemainingQuickSaveUses, %function


		GetRemainingQuickSaveUses:
		ldr		r0, =QuickSavesRAMPointer
		ldr		r0, [r0]
		ldrb	r0, [r0]
		bx		r14
		
		.align
		.ltorg

