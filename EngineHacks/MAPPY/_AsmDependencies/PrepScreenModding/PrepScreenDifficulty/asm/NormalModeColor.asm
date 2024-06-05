.thumb

.include "../PrepScreenDifficultyDefs.s"

.global NormalModeColor
.type NormalModeColor, %function


		NormalModeColor:
		
		@Check for Hard Mode
		ldr		r2, =gChapterData
		ldrb	r0, [r2,#0x14]
		mov		r1, #0x40
		tst		r0, r1
		bne		OffColor
			
			@Check for Chill Mode
			mov		r0, #0x42
			ldrb	r0, [r2,r0]
			mov		r1, #0x20
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

