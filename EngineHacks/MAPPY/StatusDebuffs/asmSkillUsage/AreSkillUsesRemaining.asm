.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global AreSkillUsesRemaining
.type AreSkillUsesRemaining, %function

@r0 = unit
@r1 = max uses

		AreSkillUsesRemaining:
		push	{r4,r14}
		mov		r4, r1
		blh		GetDebuffs, r1
		blh		GetSkillUsageValue, r1
		cmp		r0, r4
		bge		AtZero
		
			mov		r0, #1
			b		End
			
		AtZero:
		mov		r0, #0
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

