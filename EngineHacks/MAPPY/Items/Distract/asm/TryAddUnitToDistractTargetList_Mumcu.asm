.thumb

.include "../DistractDefs.s"

.global TryAddUnitToDistractTargetList
.type TryAddUnitToDistractTargetList, %function


		TryAddUnitToDistractTargetList:
		push	{r14}
		ldr		r1, =DistractStaffTargetConditionsList
		blh		TryAddUnitToTargetList, r2
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

