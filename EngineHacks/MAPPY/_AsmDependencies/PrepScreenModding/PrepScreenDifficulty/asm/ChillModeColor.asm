.thumb

.include "../PrepScreenDifficultyDefs.s"

.global ChillModeColor
.type ChillModeColor, %function


		ChillModeColor:
		ldr		r0, =gChapterData
		mov		r1, #0x42
		ldrb	r0, [r0,r1]
		mov		r1, #0x20
		tst		r0, r1
		bne		OffColor
			
			mov		r0, #3 @Orange
			b		End
			
		OffColor:
		mov		r0, #1 @gray
		
		End:
		bx		r14
		
		.align
		.ltorg

