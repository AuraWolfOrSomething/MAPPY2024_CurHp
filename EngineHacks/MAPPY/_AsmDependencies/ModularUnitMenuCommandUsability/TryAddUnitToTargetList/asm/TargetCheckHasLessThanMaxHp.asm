.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TargetCheckHasLessThanMaxHp
.type TargetCheckHasLessThanMaxHp, %function


		TargetCheckHasLessThanMaxHp:
		push	{r4-r6,r14}
		mov		r4, #0
		mov		r5, r1
		
		mov		r0, r5
		blh		prGotoCurHPGetter, r1
		mov		r6, r0
		mov		r0, r5
		blh		prGotoMaxHPGetter, r1
		cmp		r0, r6
		beq		End
		
			mov		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

