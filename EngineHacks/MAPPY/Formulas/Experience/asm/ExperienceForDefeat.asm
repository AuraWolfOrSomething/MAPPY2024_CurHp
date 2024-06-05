.thumb

.equ origin, 0x2C450
.include "../ExperienceDefs.s"

.global ExperienceForDefeat
.type ExperienceForDefeat, %function


		ExperienceForDefeat:
		push	{r4-r6,r14}
		mov		r4, r0 @player unit
		mov		r5, r1 @enemy unit
		mov		r6, #0 @exp gain
		ldrb	r2, [r5,#0x13]
		cmp		r2, #0x00
		bne		End

			@defeat exp = damage exp * 2.5 (damage exp is added to this after the function, so we need 1.5 of it)
			blh		ExperienceForDamage
			lsr		r1, r0, #1
			add		r6, r0, r1
		
			@if enemy was a boss, +50 exp
			ldr		r0, [r5]
			ldr		r0, [r0,#0x28]
			mov		r1, #0x80
			lsl		r1, #8
			tst		r0, r1
			beq		End
			
				add		r6, #50
		
		End:
		mov		r0, r6
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

