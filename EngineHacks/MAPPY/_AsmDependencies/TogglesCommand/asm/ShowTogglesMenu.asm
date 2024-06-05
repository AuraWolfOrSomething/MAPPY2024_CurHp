.thumb

.include "../TogglesCommandDefs.s"

.global ShowTogglesMenu
.type ShowTogglesMenu, %function


		ShowTogglesMenu:
		push	{r14}
		ldr		r0, =gMenu_TogglesMenu
		blh		ShowMenu, r1
		mov		r0, #0x94
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

