.thumb

.global GetSkillUsageOffsetForUnit
.type GetSkillUsageOffsetForUnit, %function

@r0 = Unit's debuff entry


		GetSkillUsageOffsetForUnit:
		push	{r4,r14}
		mov		r4, r0
		ldr		r0, =GetSkillUsageByte
		mov		lr, r0
		.short	0xF800
		mov		r1, #0xFF
		and		r0, r1 @location in unit debuff entry
		add		r0, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

