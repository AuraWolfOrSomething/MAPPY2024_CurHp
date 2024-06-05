.thumb

.include "../MumcuDefs.s"

.global CannotIfNoNearbySupplySkill
.type CannotIfNoNearbySupplySkill, %function

@mostly copied from NewSupplyUsability in SkillSystem


		CannotIfNoNearbySupplySkill:
		push	{r4,r14}
		mov		r4, r0
		ldr		r1, =SupplyIDLink
		ldrb	r1, [r1]
		blh		SkillTester, r3
		cmp		r0, #0
		bne		ContinueUsabilityCheck
		
			mov		r0, r4
			bl		IsAdjacent
			cmp		r0, #0
			bne		ContinueUsabilityCheck
			
				b		End
		
		ContinueUsabilityCheck:
		mov		r0, #1
		
		End:
		pop		{r4}
		pop		{r1}
		bx		r1
		
		
		.align
		.ltorg
		
		IsAdjacent:
		push {r4-r7,r14}
		mov r7, #0x10
		ldsb r7, [r0, r7] @RAMUnit->X
		mov r6, #0x11
		ldsb r6, [r0, r6] @RAMUnit->Y
		mov r5, #0x0
		ldr r4, =AjaxFourSides

		IsAdjacent_Loop:
		mov r2, #0x0
		ldsb r2, [r4, r2]
		add r2 ,r7, r2
		mov r0, #0x1
		ldsb r0, [r4, r0]
		add r0 ,r6, r0
		ldr r1, =gMapUnit
		ldr r1, [r1, #0x0]

		lsl r0 ,r0 ,#0x2    @gMapUnit[x]
		add r0 ,r0, r1
		ldr r0, [r0, #0x0]

		add r0 ,r0, r2      @gMapUnit[x][y]
		ldrb r1, [r0, #0x0]
		mov r0, #0x80       @???
		and r0 ,r1
		cmp r0, #0x0
		bne IsAdjacent_Next
			mov r0 ,r1
			blh GetUnit   @GetUnitStruct RET=RAM Unit:@UNIT
			cmp r0, #0x0
			beq IsAdjacent_Next

			ldrb r1, [r0, #0xB]  @ RAMUnit->Unit table ID
			cmp r1,#0x80         @ Enemy supply are not available.
			bge IsAdjacent_Next
			
			ldr r1, =SupplyIDLink
			ldrb r1,[r1]
			blh SkillTester,r3
			cmp r0, #1
			beq IsAdjacent_Return_True

		IsAdjacent_Next:
		add r4, #0x2
		add r5, #0x1
		cmp r5, #0x3
		ble IsAdjacent_Loop

		mov r0, #0x0
		b IsAdjacent_Return_Exit

		IsAdjacent_Return_True:
		mov r0, #0x1

		IsAdjacent_Return_Exit:
		pop {r4-r7}
		pop {r1}
		bx r1
		
		.align
		.ltorg

