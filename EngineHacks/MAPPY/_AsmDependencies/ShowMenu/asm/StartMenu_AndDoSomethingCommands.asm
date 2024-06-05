.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ origin, 0x0804F64C
.equ bl_StartMenuAdjusted, . + 0x0804EB98 - origin


.global StartMenu_AndDoSomethingCommands
.type StartMenu_AndDoSomethingCommands, %function


		StartMenu_AndDoSomethingCommands:
		push	{r4,r14}
		bl		bl_StartMenuAdjusted
		
		@For storing cursor location in certain menu
		ldr		r1, =ReusableTempRAMPointer
		ldr		r1, [r1]
		str		r0, [r1,#0x28]
		
		mov		r4, r0
		mov		r2, #0x60
		ldrb	r1, [r4,r2]
		cmp		r1, #6
		bls		End
		
			blh		StartMenu_AndDoSomethingCommandsCont, r1
			mov		r0, r4
				
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

