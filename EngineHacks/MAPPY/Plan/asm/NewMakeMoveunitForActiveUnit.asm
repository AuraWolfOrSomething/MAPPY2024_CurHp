.thumb

.include "../PlanDefs.s"

.global NewMakeMoveunitForActiveUnit
.type NewMakeMoveunitForActiveUnit, %function


		NewMakeMoveunitForActiveUnit:
		push	{r4-r5,r14}
		blh		MU_Exists, r0
		cmp		r0, #0
		bne		End
		
			ldr		r4, =gActiveUnit
			ldr		r5, [r4]
			ldrb	r0, [r5,#0x0B]
			mov		r1, #0xC0
			and		r0, r1
			ldr		r1, =gChapterData
			ldrb	r1, [r1,#0x0F]
			cmp		r0, r1
			beq		CheckForStatus
			
				blh		MM_ActUsability, r0
				cmp		r0, #1
				bne		End
				
					CheckForStatus:
					mov		r0, #0x30
					ldrb	r0, [r5,r0]
					mov		r1, #0x0F
					and		r0, r1
					cmp		r0, #2 @sleep
					beq		End
					
					cmp		r0, #4 @berserk
					beq		End
					
						mov		r0, r5
						blh		MU_Create
						ldr		r0, [r4]
						blh		HideUnitSMS
		
		End:
		blh		MU_SetDefaultFacing_Auto, r0
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

