.thumb

.include "../MumcuDefs.s"

.global CannotIfNoNearbySupplyLord
.type CannotIfNoNearbySupplyLord, %function


		CannotIfNoNearbySupplyLord:
		push	{r14}
		
		@get mode
		ldr		r1, =gChapterData
		ldrb	r1, [r1,#0x1B]
		cmp		r1, #3
		beq		CheckForEphraim
		
			mov		r2, #0x01 @Eirika
			b		CheckIfActiveUnitIsLord
		
			CheckForEphraim:
			mov		r2, #0x0F
			
			CheckIfActiveUnitIsLord:
			ldr		r1, [r0]
			ldrb	r1, [r1,#4]
			cmp		r1, r2
			beq		ContinueUsabilityCheck
			
				mov		r0, r2
				blh		IsSupplyLordAdjacent, r1
				cmp		r0, #0
				bne		ContinueUsabilityCheck
				
					b		End
		
		ContinueUsabilityCheck:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

