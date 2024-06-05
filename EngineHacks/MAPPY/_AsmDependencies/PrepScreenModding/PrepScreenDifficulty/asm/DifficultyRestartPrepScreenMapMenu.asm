.thumb

.include "../PrepScreenDifficultyDefs.s"

.global DifficultyRestartPrepScreenMapMenu
.type DifficultyRestartPrepScreenMapMenu, %function


		DifficultyRestartPrepScreenMapMenu:
		push	{r14}
		ldr		r0, =gProc_NewPrepScreen
		blh		ProcFind, r1
		mov		r1, #0x32
		blh		ProcGoto, r2
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

