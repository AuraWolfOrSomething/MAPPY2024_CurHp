.thumb

.include "../TogglesCommandDefs.s"

.global TogglesMenuReturnToMapMenu
.type TogglesMenuReturnToMapMenu, %function


		TogglesMenuReturnToMapMenu:
		push	{r14}
		ldr		r0, =gMenu_MapMenu
		blh		ShowMenu, r1
		mov		r0, #0x94
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

