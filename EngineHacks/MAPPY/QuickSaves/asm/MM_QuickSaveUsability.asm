.thumb

.include "../QuickSavesDefs.s"

.global MM_QuickSaveUsability
.type MM_QuickSaveUsability, %function


		MM_QuickSaveUsability:
		push	{r14}
		
		@if no QuickSaves remaining, not usable
		blh		GetRemainingQuickSaveUses, r0
		cmp		r0, #0
		beq		NotUsable
		
			@check if map menu command "Act" is usable
				@if so, don't allow this
			blh		MM_ActUsability, r0
			cmp		r0, #1
			beq		NotUsable
			
				mov		r0, #1
				b		End
		
		NotUsable:
		mov		r0, #3
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

