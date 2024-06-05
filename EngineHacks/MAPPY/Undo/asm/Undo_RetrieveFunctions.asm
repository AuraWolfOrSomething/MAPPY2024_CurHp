.thumb

.include "../UndoDefs.s"

.global Undo_RetrieveWhole
.type Undo_RetrieveWhole, %function

.global Undo_RetrieveCharClass
.type Undo_RetrieveCharClass, %function

.global Undo_RetrieveMaxHP
.type Undo_RetrieveMaxHP, %function

.global Undo_RetrievePow
.type Undo_RetrievePow, %function

.global Undo_RetrieveInjury
.type Undo_RetrieveInjury, %function

.global Undo_RetrieveSkl
.type Undo_RetrieveSkl, %function

.global Undo_RetrieveSpd
.type Undo_RetrieveSpd, %function

.global Undo_RetrieveDef
.type Undo_RetrieveDef, %function

.global Undo_RetrieveRes
.type Undo_RetrieveRes, %function

.global Undo_RetrieveLck
.type Undo_RetrieveLck, %function

.global Undo_RetrieveConBonus
.type Undo_RetrieveConBonus, %function

.global Undo_RetrieveMovBonus
.type Undo_RetrieveMovBonus, %function

.global Undo_RetrieveLvExpPos
.type Undo_RetrieveLvExpPos, %function

.global Undo_RetrieveWEXP
.type Undo_RetrieveWEXP, %function

.global Undo_RetrieveSupport
.type Undo_RetrieveSupport, %function

.global Undo_RetrieveInventory
.type Undo_RetrieveInventory, %function

.global Undo_RetrieveState
.type Undo_RetrieveState, %function

.global Undo_RetrieveCurHP
.type Undo_RetrieveCurHP, %function

.global Undo_RetrieveRescue
.type Undo_RetrieveRescue, %function

.global Undo_RetrieveBallista
.type Undo_RetrieveBallista, %function

.global Undo_RetrieveStatus
.type Undo_RetrieveStatus, %function

.global Undo_RetrieveTorchBarrier
.type Undo_RetrieveTorchBarrier, %function

.global Undo_RetrieveAI
.type Undo_RetrieveAI, %function


@-----------------------------------------
@Undo_RetrieveWhole
@-----------------------------------------


		Undo_RetrieveWhole:
		push	{r4-r7,r14}
		add		sp, #-0x08
		mov		r4, r0
		mov		r5, r1
		ldr		r6, =Undo_RetrieveFunctionWholeList
		ldrb	r0, [r4]
		str		r0, [sp]
		mov		r0, #0
		str		r0, [sp,#4]
		
		Loop_RetrieveWhole:
		ldr		r2, [r6]
		cmp		r2, #0
		beq		DetermineFaction_RetrieveWhole
		
			mov		r0, r4
			mov		r1, r5
			mov		r7, r2
			mov		lr, r2
			.short	0xF800
			
			ldr		r1, =Undo_RetrieveFunctionTable
			add		r1, #4
			
			Loop_RetrieveWhole_FindSize:
			ldr		r0, [r1]
			cmp		r0, #0
			beq		FailsafeSize
			
				cmp		r0, r7
				beq		CalculateSize
				
					add		r1, #4
					b		Loop_RetrieveWhole_FindSize
					
			FailsafeSize:
			ldr		r1, =Undo_RetrieveFunctionTable
			add		r1, #0x10
			
			CalculateSize:
			ldr		r0, =Undo_RetrieveFunctionTable
			sub		r1, r0
			lsr		r0, r1, #2
			ldr		r1, =UndoEntrySizeTable
			ldrb	r0, [r1,r0]
			sub		r0, #UndoBaseSize
			add		r4, r0
			add		r6, #4
			b		Loop_RetrieveWhole
			
		DetermineFaction_RetrieveWhole:
		ldr		r0, [sp,#4]
		cmp		r0, #0
		bgt		End_Undo_RetrieveWhole
		
			add		r0, #1
			str		r0, [sp,#4]
			ldr		r0, [sp]
			cmp		r0, #UndoID_PlayerUnit
			bne		Undo_RetrieveWholeOther
			
				ldr		r6, =Undo_RetrieveFunctionPlayerOnly
				b		Loop_RetrieveWhole
			
				Undo_RetrieveWholeOther:
				ldr		r6, =Undo_RetrieveFunctionOtherOnly
				b		Loop_RetrieveWhole
				
		End_Undo_RetrieveWhole:
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveCharClass
@-----------------------------------------


		Undo_RetrieveCharClass:
		push	{r4-r5,r14}
		mov		r4, r0
		mov		r5, r1
		
		ldrb	r0, [r4,#2]
		blh		GetCharacterData, r1
		str		r0, [r5] @Unit RAM location
		
		ldrb	r0, [r4,#3]
		blh		GetClassData, r1
		str		r0, [r5,#4] @Unit RAM location
		
		pop		{r4-r5}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveMaxHP
@-----------------------------------------


		Undo_RetrieveMaxHP:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x12] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrievePow
@-----------------------------------------


		Undo_RetrievePow:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x14] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveInjury
@-----------------------------------------


		Undo_RetrieveInjury:
		mov		r3, #0x3B @Unit RAM location
		ldrb	r2, [r0,#2]
		strb	r2, [r1,r3]
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveSkl
@-----------------------------------------


		Undo_RetrieveSkl:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x15] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveSpd
@-----------------------------------------


		Undo_RetrieveSpd:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x16] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveDef
@-----------------------------------------


		Undo_RetrieveDef:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x17] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveRes
@-----------------------------------------


		Undo_RetrieveRes:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x18] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveLck
@-----------------------------------------


		Undo_RetrieveLck:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x19] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveConBonus
@-----------------------------------------


		Undo_RetrieveConBonus:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x1A] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveMovBonus
@-----------------------------------------


		Undo_RetrieveMovBonus:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x1D] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveLvExpPos
@-----------------------------------------


		Undo_RetrieveLvExpPos:
		ldrb	r2, [r0,#2]
		ldrb	r3, [r0,#3]
		lsl		r3, #8
		orr		r2, r3
		ldrb	r3, [r0,#4]
		lsl		r3, #16
		orr		r2, r3
		
		mov		r3, #0x3F
		and		r3, r2
		cmp		r3, #0x3F
		bne		StoreXCoord
		
			mov		r3, #0xFF
			
		StoreXCoord:
		strb	r3, [r1,#0x10] @Unit RAM location
		
		lsr		r2, #6
		mov		r3, #0x3F
		and		r3, r2
		cmp		r3, #0x3F
		bne		StoreYCoord
		
			mov		r3, #0xFF
			
		StoreYCoord:
		strb	r3, [r1,#0x11] @Unit RAM location
		
		@Level
		lsr		r2, #6
		mov		r3, #0x1F
		and		r3, r2
		strb	r3, [r1,#8] @Unit RAM location
		
		lsr		r2, #5
		mov		r3, #0x7F
		and		r3, r2
		cmp		r3, #0x7F
		bne		StoreExp
		
			mov		r3, #0xFF
			
		StoreExp:
		strb	r3, [r1,#9] @Unit RAM location
		
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveWEXP
@-----------------------------------------


		Undo_RetrieveWEXP:
		add		r0, #2
		add		r1, #0x28
		mov		r3, #0
		
		Loop_Undo_RetrieveWEXP:
		ldrb	r2, [r0,r3]
		strb	r2, [r1,r3] @Unit RAM location
		add		r3, #1
		cmp		r3, #8
		blt		Loop_Undo_RetrieveWEXP
		
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveSupport
@-----------------------------------------


		Undo_RetrieveSupport:
		add		r0, #2
		add		r1, #0x32
		mov		r3, #0
		
		Loop_Undo_RetrieveSupport:
		ldrb	r2, [r0,r3]
		strb	r2, [r1,r3] @Unit RAM location
		add		r3, #1
		cmp		r3, #7
		blt		Loop_Undo_RetrieveSupport
		
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveInventory
@-----------------------------------------


		Undo_RetrieveInventory:
		add		r0, #2
		add		r1, #0x1E
		mov		r3, #0
		
		Loop_Undo_RetrieveInventory:
		ldrb	r2, [r0,r3]
		strb	r2, [r1,r3] @Unit RAM location
		add		r3, #1
		cmp		r3, #10
		blt		Loop_Undo_RetrieveInventory

		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveState
@-----------------------------------------


		Undo_RetrieveState:
		add		r0, #2
		add		r1, #0x0C
		mov		r3, #0
		
		Loop_Undo_RetrieveState:
		ldrb	r2, [r0,r3]
		strb	r2, [r1,r3] @Unit RAM location
		add		r3, #1
		cmp		r3, #4
		blt		Loop_Undo_RetrieveState
		
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveCurHP
@-----------------------------------------


		Undo_RetrieveCurHP:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x13] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveRescue
@-----------------------------------------


		Undo_RetrieveRescue:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x1B] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveBallista
@-----------------------------------------


		Undo_RetrieveBallista:
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#0x1C] @Unit RAM location
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveStatus
@-----------------------------------------


		Undo_RetrieveStatus:
		mov		r3, #0x30 @Unit RAM location
		ldrb	r2, [r0,#2]
		strb	r2, [r1,r3]
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveTorchBarrier
@-----------------------------------------


		Undo_RetrieveTorchBarrier:
		mov		r3, #0x31 @Unit RAM location
		ldrb	r2, [r0,#2]
		strb	r2, [r1,r3]
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@Undo_RetrieveAI
@-----------------------------------------


		Undo_RetrieveAI:
		ldrb	r2, [r0,#4]
		strb	r2, [r1,#0x0A]
		
		add		r0, #2
		add		r1, #0x40 @Unit RAM location
		
		@AI1
		ldrb	r2, [r0]
		strb	r2, [r1,#2]
		
		@AI2
		ldrb	r2, [r0,#1]
		strb	r2, [r1,#4]
		
		@AI1 counter
		ldrb	r2, [r0,#2]
		strb	r2, [r1,#3]
		
		@AI2 counter
		ldrb	r2, [r0,#3]
		strb	r2, [r1,#5]
		
		@AI3
		ldrb	r2, [r0,#5]
		strb	r2, [r1]
		
		@AI4
		ldrb	r2, [r0,#6]
		strb	r2, [r1,#1]
		
		bx		r14
		
		.align
		.ltorg

