.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TargetCheckAidVsCarriedUnitCon
.type TargetCheckAidVsCarriedUnitCon, %function


		TargetCheckAidVsCarriedUnitCon:
		push	{r4,r14}
		mov		r4, r1
		ldrb	r0, [r0,#0x1B]
		blh		GetUnit, r1
		mov		r1, r0
		mov		r0, r4
		blh		CanUnitRescue
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

