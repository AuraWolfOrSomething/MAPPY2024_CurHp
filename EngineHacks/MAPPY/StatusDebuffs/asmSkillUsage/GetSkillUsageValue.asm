.thumb

.global GetSkillUsageValue
.type GetSkillUsageValue, %function

@r0 = Unit's debuff entry


		GetSkillUsageValue:
		push	{r4,r14}
		mov		r4, r0
		ldr		r0, =GetSkillUsageByte
		mov		lr, r0
		.short	0xF800
		lsr		r2, r0, #8 @how much of the byte is for skill usage
		mov		r1, #0xFF
		and		r0, r1 @location in unit debuff entry
		add		r0, r4
		ldrb	r0, [r0]
		and		r0, r2
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

