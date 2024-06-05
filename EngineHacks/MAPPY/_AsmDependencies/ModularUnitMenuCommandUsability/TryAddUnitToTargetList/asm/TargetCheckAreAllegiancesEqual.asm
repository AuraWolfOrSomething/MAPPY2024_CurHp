.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TargetCheckAreAllegiancesEqual
.type TargetCheckAreAllegiancesEqual, %function


		TargetCheckAreAllegiancesEqual:
		push	{r14}
		ldrb	r0, [r0,#0x0B]
		ldrb	r1, [r1,#0x0B]
		ldr		r2, =AreAllegiancesEqual
		mov		lr, r2
		.short	0xF800
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

