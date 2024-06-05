.thumb

.include "../FlashingIconToggleDefs.s"

.global MapMenuDropIconToggle
.type MapMenuDropIconToggle, %function


		MapMenuDropIconToggle:
		push	{r4,r14}
		
		@Get cursor position
		ldr		r0, =gProc_Menu
		blh		ProcFind, r1
		mov		r4, r0
		
		@Play sound effect unless sound is off
		ldr		r0, =gChapterData
		add		r0, #0x41
		ldrb	r0, [r0]
		lsl		r0, #0x1E
		cmp		r0, #0
		blt		GoToTogglingFunction
		
			mov		r0, #0x6A
			blh		m4aSongNumStart, r1

		GoToTogglingFunction:
		blh		DropIconToggle, r0
		
		ldr		r0, =gMenu_TogglesMenu
		blh		ShowMenu, r1
		
		mov		r0, r4
		blh		ReuseCursorLocation, r1
		
		End:
		mov		r0, #0x1B
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

