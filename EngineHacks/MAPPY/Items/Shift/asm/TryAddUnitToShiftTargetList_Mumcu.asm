.thumb

.include "../ShiftDefs.s"

.global TryAddUnitToShiftTargetList
.type TryAddUnitToShiftTargetList, %function


		TryAddUnitToShiftTargetList:
		push	{r14}
		ldr		r1, =ShiftStaffTargetConditionsList
		blh		TryAddUnitToTargetList, r2
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

