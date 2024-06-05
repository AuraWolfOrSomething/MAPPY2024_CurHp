.thumb

.include "../PrepScreenDifficultyDefs.s"

.global HardModeColor
.type HardModeColor, %function


		HardModeColor:
		ldr		r0, =gChapterData
		ldrb	r0, [r0,#0x14]
		mov		r1, #0x40
		tst		r0, r1
		beq		OffColor
			
			mov		r0, #3 @Orange
			b		End
			
		OffColor:
		mov		r0, #1 @gray
		
		End:
		bx		r14
		
		.align
		.ltorg

