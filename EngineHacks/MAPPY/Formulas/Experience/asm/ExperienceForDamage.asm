.thumb

.equ origin, 0
.include "../ExperienceDefs.s"

.global ExperienceForDamage
.type ExperienceForDamage, %function


		ExperienceForDamage:
		push	{r4-r6,r14}
		mov		r4, r0 @player unit
		mov		r5, r1 @enemy unit
		
		@Get player unit's lv
		blh		GetUnitEffectiveLevel, r1
		mov		r6, r0
		
		@Get enemy unit's lv
		mov		r0, r5
		blh		GetUnitEffectiveLevel, r1
		
		sub		r6, r0, r6
		add		r6, #10
		
		@exp minimum
		cmp		r6, #5
		bge		MaxExpCheck
		
			mov		r6, #5
			b		ReturnDamageExp
		
			MaxExpCheck:
			cmp		r6, #20
			ble		ReturnDamageExp
			
				mov		r6, #20
		
		@check if novice weapon; if so, add 10 exp
		@mov		r0, r4
		@add		r0, #0x4A
		@ldrh	r0, [r0]
		@blh		GetItemWeaponEffect, r1
		@cmp		r0, #0x0F
		@bne		ReturnDamageExp
		
			@add		r6, #10
		
		ReturnDamageExp:
		mov		r0, r6
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

