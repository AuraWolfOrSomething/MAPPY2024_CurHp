.thumb

.equ gChapterData, 0x0202BCF0
.equ EnsureCameraOntoPosition, 0x08015E0C
.equ SetCursorMapPosition, 0x08015BBC

.global AsmcResetCursor
.type AsmcResetCursor, %function


		AsmcResetCursor:
		push	{r4,r14}
		ldr		r4, =gChapterData
		ldrb	r1, [r4,#0x12]
		ldrb	r2, [r4,#0x13]
		ldr		r3, =EnsureCameraOntoPosition
		mov		lr, r3
		.short	0xF800
		ldrb	r0, [r4,#0x12]
		ldrb	r1, [r4,#0x13]
		ldr		r2, =SetCursorMapPosition
		mov		lr, r2
		.short	0xF800
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

