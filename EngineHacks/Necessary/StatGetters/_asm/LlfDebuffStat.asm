.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.global LlfDebuffDef
.type LlfDebuffDef, %function

.global LlfDebuffLck
.type LlfDebuffLck, %function

.global LlfDebuffMag
.type LlfDebuffMag, %function

.global LlfDebuffPow
.type LlfDebuffPow, %function

.global LlfDebuffRes
.type LlfDebuffRes, %function

.global LlfDebuffSkl
.type LlfDebuffSkl, %function

.global LlfDebuffSpd
.type LlfDebuffSpd, %function


@----------------------------------------------
@LlfDebuffDef
@----------------------------------------------

		LlfDebuffDef:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective, r1
		cmp		r0, #0
		beq		End_Def
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		CheckLull_Def
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
			
			CheckLull_Def:
			mov		r0, r4
			blh		IsLullDebuffActive, r1
			cmp		r0, #0
			beq		End_Def
			
				@Lull: -5 to stat
				mov		r0, #4
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Def:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align


@----------------------------------------------
@LlfDebuffLck
@----------------------------------------------

		LlfDebuffLck:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective, r1
		cmp		r0, #0
		beq		End_Lck
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		End_Lck
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Lck:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align


@----------------------------------------------
@LlfDebuffMag
@----------------------------------------------

		LlfDebuffMag:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective
		cmp		r0, #0
		beq		End_Mag
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		End_Mag
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Mag:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align


@----------------------------------------------
@LlfDebuffPow
@----------------------------------------------

		LlfDebuffPow:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective, r1
		cmp		r0, #0
		beq		End_Pow
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		End_Pow
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Pow:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align


@----------------------------------------------
@LlfDebuffRes
@----------------------------------------------

		LlfDebuffRes:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective, r1
		cmp		r0, #0
		beq		End_Res
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		CheckLull_Res
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
			
			CheckLull_Res:
			mov		r0, r4
			blh		IsLullDebuffActive, r1
			cmp		r0, #0
			beq		End_Res
			
				@Lull: -5 to stat
				mov		r0, #4
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Res:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align


@----------------------------------------------
@LlfDebuffSkl
@----------------------------------------------

		LlfDebuffSkl:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective, r1
		cmp		r0, #0
		beq		End_Skl
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		End_Skl
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Skl:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align


@----------------------------------------------
@LlfDebuffSpd
@----------------------------------------------

		LlfDebuffSpd:
		push 	{r4-r6, lr}
		mov 	r5, r0 @stat
		mov 	r4, r1 @unit

		@If something that prevents debuffs is active, skip
		mov		r0, r4
		blh		AreDebuffsEffective, r1
		cmp		r0, #0
		beq		End_Spd
			
			@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
			mov		r0, r4
			blh		AreDebuffsHalved, r1
			mov		r6, r0
			
			mov		r0, r4
			blh		IsRustbowDebuffActive, r1
			cmp		r0, #0
			beq		End_Spd
			
				@Rustbow: Debuff equal to duration
				sub		r0, #1
				lsr		r0, r6
				add		r0, #1
				sub 	r5, r0
				
		End_Spd:
		mov 	r0, r5
		pop 	{r4-r6}
		pop		{r1}
		bx		r1
		
		.ltorg
		.align

