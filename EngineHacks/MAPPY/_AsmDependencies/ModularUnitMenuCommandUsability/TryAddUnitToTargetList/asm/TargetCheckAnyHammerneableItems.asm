.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TargetCheckAnyHammerneableItems
.type TargetCheckAnyHammerneableItems, %function


		TargetCheckAnyHammerneableItems:
		push	{r4-r6,r14}
		mov		r4, #0
		mov		r5, r1
		mov		r6, #0
		
		LoopThroughInventory:
		lsl		r1, r6, #1
		add		r1, #0x1E
		mov		r0, r5
		ldrh	r0, [r0,r1]
		blh		IsItemHammernable, r1
		cmp		r0, #0
		bne		HammernableItemFound

			add		r6, #1
			cmp		r6, #4
			ble		LoopThroughInventory
			
				b	End
		
		HammernableItemFound:
		mov		r4, #1
		
		End:
		mov		r0, r4
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

