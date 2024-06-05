.thumb

.global HitFormulaParameters
.type HitFormulaParameters, %function

		
		HitFormulaParameters:
		push	{r14}
		
		ldr		r3, =HitFormula
		mov		lr, r3
	
		@Get unit's Skl
		mov		r1, #0x15
		ldsb	r1, [r0,r1]
		
		@Get unit's Lck
		mov		r2, #0x19
		ldsb	r2, [r0,r2]
		
		.short	0xF800
		
		pop		{r0}
		bx		r0

