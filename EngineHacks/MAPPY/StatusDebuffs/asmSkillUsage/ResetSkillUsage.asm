.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global ResetSkillUsage
.type ResetSkillUsage, %function


		ResetSkillUsage:
		push	{r4,r14}
		mov		r4, r0
		blh		GetSkillUsageByte
		lsr		r2, r0, #8 @how much of the byte is for skill usage
		mov		r1, #0xFF
		and		r0, r1 @location in unit debuff entry
		eor		r2, r1 @remainder of byte for skill usage
		ldrb	r1, [r4,r0]
		and		r1, r2
		strb	r1, [r4,r0]
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

