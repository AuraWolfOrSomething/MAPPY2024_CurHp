.thumb

.include "../PrepScreenDifficultyDefs.s"

.global SetUpPrepScreenDifficultyMenu
.type SetUpPrepScreenDifficultyMenu, %function


		SetUpPrepScreenDifficultyMenu:
		push	{r4-r5,r14}
		add		sp, #-0x04
		mov		r4, r0
		mov		r1, #1
		neg		r1, r1
		mov		r0, #0
		blh		LoadDialogueBoxGfx, r2
		blh		Text_InitFont, r0
		blh		EndPlayerPhaseSideWindows, r0
		blh		HideMoveRangeGraphics, r0
		mov		r0, r4
		blh		StartPrepScreenMenu, r1
		ldr		r5, =PrepScreenDifficultyMapMenuList
		
		LoopThroughList:
		ldr		r0, [r5]
		cmp		r0, #0
		beq		ContinueLoop_AlwaysUsable
		
		mov		lr, r0
		.short	0xF800
		cmp		r0, #0
		beq		NextCommand
		
		ContinueLoop_AlwaysUsable:
		mov		r2, #0
		
		CheckIfEndReached:
		ldr		r1, [r5,#4]
		cmp		r1, #0
		beq		EndOfLoop
		
		ldrh	r3, [r5,#8]
		ldrh	r0, [r5,#0xA]
		str		r0, [sp]
		ldr		r0, =SetPrepScreenMenuItem
		mov		lr, r0
		ldrb	r0, [r5,#0x0C]
		.short	0xF800
		
		NextCommand:
		add		r5, #0x10
		b		LoopThroughList
		
		EndOfLoop:
		mov		r0, r4
		blh		Routine_08033620, r1
		
		ldr		r0, =TransitionFromDifficultyMenuToPrepScreenMenu
		blh		SetPrepScreenMenuOnBPress, r1
		
		mov		r0, #0
		blh		SetPrepScreenMenuOnStartPress, r1
		
		mov		r0, #0
		blh		SetPrepScreenMenuOnEnd, r1
		
		mov		r0, #0x0A @x-coord
		mov		r1, #0 @y-coord
		blh		DrawPrepScreenMenuFrameAt, r2
		ldr		r0, [r4,#0x58]
		blh		SetPrepScreenMenuSelectedItem, r1
		mov		r0, #3
		blh		EnableBgSyncByMask, r1
		add		sp, #4
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

