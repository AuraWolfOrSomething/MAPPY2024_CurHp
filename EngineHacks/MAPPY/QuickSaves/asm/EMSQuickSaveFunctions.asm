.thumb

.include "../QuickSavesDefs.s"

.global SaveQuickSaveUses
.type SaveQuickSaveUses, %function

.global LoadQuickSaveUses
.type LoadQuickSaveUses, %function


@-----------------------------------------
@SaveQuickSaveUses
@-----------------------------------------

@observations from EMS unit saving
@r0 = current location in save data
@r1 = declared size of chunk
@save unit into space allocated from stack, then call WriteAndVerifySramFast

		SaveQuickSaveUses:
		push	{r4-r7,r14}
		mov		r4, r0 @current spot in save data
		sub		sp, #4

		@Transfer from RAM to IRAM
		ldr		r0, =QuickSavesRAMPointer
		ldr		r0, [r0]
		mov		r1, sp
		ldr		r2, [r0]
		str		r2, [r1]
		
		@Transfer from IRAM to Cart RAM
		mov		r0, sp
		mov		r1, r4
		mov		r2, #4
		ldr		r3, =WriteAndVerifySramFast
		mov		lr, r3
		.short	0xF800
		
		@the end :)
		add		sp, #4
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@LoadQuickSaveUses
@-----------------------------------------

		LoadQuickSaveUses:
		push	{r14}
		mov		r2, r1 @size
		
		ldr		r1, =QuickSavesRAMPointer
		ldr		r1, [r1]
		
		ldr 	r3, =ReadSramFastAddr
		ldr 	r3, [r3] @ r3 = ReadSramFast
		mov 	lr, r3
		.short 	0xF800
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

