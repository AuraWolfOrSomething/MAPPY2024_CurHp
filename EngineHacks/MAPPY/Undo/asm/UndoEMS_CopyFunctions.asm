.thumb

.include "../UndoDefs.s"

.global UndoEMS_CopyUnit
.type UndoEMS_CopyUnit, %function

.global PrepareCreateUndoEntry
.type PrepareCreateUndoEntry, %function

@.global PrepareCreateUndoEntry_Misc
@.type PrepareCreateUndoEntry_Misc, %function

.global CreateUndoEntry
.type CreateUndoEntry, %function

.global UndoEMS_Whole
.type UndoEMS_Whole, %function

.global UndoEMS_CopyCharClass
.type UndoEMS_CopyCharClass, %function

.global UndoEMS_CopyMaxHP
.type UndoEMS_CopyMaxHP, %function

.global UndoEMS_CopyPow
.type UndoEMS_CopyPow, %function

.global UndoEMS_CopyInjury
.type UndoEMS_CopyInjury, %function

.global UndoEMS_CopySkl
.type UndoEMS_CopySkl, %function

.global UndoEMS_CopySpd
.type UndoEMS_CopySpd, %function

.global UndoEMS_CopyDef
.type UndoEMS_CopyDef, %function

.global UndoEMS_CopyRes
.type UndoEMS_CopyRes, %function

.global UndoEMS_CopyLck
.type UndoEMS_CopyLck, %function

.global UndoEMS_CopyConBonus
.type UndoEMS_CopyConBonus, %function

.global UndoEMS_CopyMovBonus
.type UndoEMS_CopyMovBonus, %function

.global UndoEMS_CopyLvExpPos
.type UndoEMS_CopyLvExpPos, %function

.global UndoEMS_CopyWEXP
.type UndoEMS_CopyWEXP, %function

.global UndoEMS_CopySupport
.type UndoEMS_CopySupport, %function

.global UndoEMS_CopyInventory
.type UndoEMS_CopyInventory, %function

.global UndoEMS_CopyState
.type UndoEMS_CopyState, %function

.global UndoEMS_CopyCurHP
.type UndoEMS_CopyCurHP, %function

.global UndoEMS_CopyRescue
.type UndoEMS_CopyRescue, %function

.global UndoEMS_CopyBallista
.type UndoEMS_CopyBallista, %function

.global UndoEMS_CopyStatus
.type UndoEMS_CopyStatus, %function

.global UndoEMS_CopyTorchBarrier
.type UndoEMS_CopyTorchBarrier, %function

.global UndoEMS_CopyAI
.type UndoEMS_CopyAI, %function


@-----------------------------------------
@UndoEMS_CopyUnit
@-----------------------------------------


		UndoEMS_CopyUnit:
		push	{r4-r7,r14}
		add		sp, #-0x1C
		mov		r6, r0
		mov		r5, r1
		str		r2, [sp,#0x08]
		str		r3, [sp,#0x0C]
		@r4 is already set to what we want
		
		mov		r0, #0
		str		r0, [sp,#0x04]
		
		str		r5, [sp,#0x10]
		ldr		r7, =UndoEMS_CopyFunctionList
			
		Loop_CopyFunctionList:
		ldr		r0, [r7]
		cmp		r0, #0
		beq		End_UndoEMS_CopyUnit
		
			mov		lr, r0
			.short	0xF800
			
			@Return of 0 = Done; no need to do anything else
			@Return of 1 = CopyUnit_Whole is required
			cmp		r0, #0
			bne		CopyUnit_Whole
			
				add		r7, #4
				b		Loop_CopyFunctionList
	
			CopyUnit_Whole:
			blh		UndoEMS_Whole, r0
			
		End_UndoEMS_CopyUnit:
		mov		r0, r5
		add		sp, #0x1C
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@PrepareCreateUndoEntry
@-----------------------------------------


		PrepareCreateUndoEntry:
		ldr		r1, =UndoEntrySizeTable
		ldrb	r1, [r1,r0]
		
		@ldr		r0, [sp,#0x04]
		@add		r0, r1
		@ldr		r1, [sp,#0x08]
		
		@account for push {r14}
		ldr		r0, [sp,#0x08]
		add		r0, r1
		ldr		r1, [sp,#0x0C]
		
		cmp		r0, r1
		blt		End_PrepareCreateUndoEntry
		
			mov		r0, #0
			
		End_PrepareCreateUndoEntry:
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@PrepareCreateUndoEntry_Misc
@-----------------------------------------


		@PrepareCreateUndoEntry_Misc:
		@ldr		r1, =UndoEntrySizeTable
		@ldrb	r1, [r1,r0]
		
		@ldr		r0, [sp,#0x04]
		@add		r0, r1
		@ldr		r1, [sp,#0x08]
		
		@account for push {r14}
		@ldr		r0, [sp,#0x08]
		@add		r0, r1
		@bx		r14
		
		@.align
		@.ltorg


@-----------------------------------------
@CreateUndoEntry
@-----------------------------------------


		CreateUndoEntry:
		@str		r0, [sp,#0x04]
		@strb	r1, [r5]
		
		@account for push {r14}
		str		r0, [sp,#0x08]
		strb	r1, [r5]
		
		ldrb	r0, [r6,#0x0B]
		
		strb	r0, [r5,#1]
		add		r5, #UndoBaseSize
		ldr		r3, =UndoEntrySizeTable
		ldrb	r3, [r3,r1]
		sub		r3, #UndoBaseSize
		
		Loop_CreateUndoEntry:
		cmp		r3, #0
		ble		End_CreateUndoEntry
		
			ldrb	r0, [r4,r2]
			strb	r0, [r5]
			add		r2, #1
			add		r5, #1
			sub		r3, #1
			b		Loop_CreateUndoEntry
		
		End_CreateUndoEntry:
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_Whole
@-----------------------------------------


		UndoEMS_Whole:
		push	{r14}
		
		@ldr		r0, [sp,#0x08]
		@add		r0, #UndoBaseSize
		@ldr		r1, [sp,#0x0C]
		@mov		r2, #0
		@ldr		r5, [sp,#0x10]
		
		@account for push {r14}
		ldr		r0, [sp,#0x0C]
		add		r0, #UndoBaseSize
		ldr		r1, [sp,#0x10]
		mov		r2, #0
		ldr		r5, [sp,#0x14]
		
		blh		CreateUndoEntry, r3
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyCharClass
@-----------------------------------------


		UndoEMS_CopyCharClass:
		ldrb	r0, [r4]
		ldr		r1, [r6]
		cmp		r1, #0
		beq		CompareCharIDs
		
			ldrb	r1, [r1,#4]
			
			CompareCharIDs:
			cmp		r0, r1
			bne		True_UndoEMS_CopyCharClass
			
			ldrb	r0, [r4,#1]
			ldr		r1, [r6,#4]
			cmp		r1, #0
			beq		CompareClassIDs
			
				ldrb	r1, [r1,#4]
				
				CompareClassIDs:
				cmp		r0, r1
				bne		True_UndoEMS_CopyCharClass
				
					mov		r0, #0
					b		End_UndoEMS_CopyCharClass
				
					True_UndoEMS_CopyCharClass:
					mov		r0, #1
			
		End_UndoEMS_CopyCharClass:
		bx		r14
		

@-----------------------------------------
@UndoEMS_CopyMaxHP
@-----------------------------------------


		UndoEMS_CopyMaxHP:
		push	{r14}
		ldrb	r0, [r4,#0x02] @Save data location
		ldrb	r1, [r6,#0x12] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyMaxHP
		
			mov		r0, #0x02 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyMaxHP
			
				mov		r1, #0x02 @UndoID
				mov		r2, #0x02 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyMaxHP:
				mov		r0, #0
				b		End_UndoEMS_CopyMaxHP
				
				True_UndoEMS_CopyMaxHP:
				mov		r0, #1
		
		End_UndoEMS_CopyMaxHP:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyPow
@-----------------------------------------


		UndoEMS_CopyPow:
		push	{r14}
		ldrb	r0, [r4,#0x03] @Save data location
		ldrb	r1, [r6,#0x14] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyPow
		
			mov		r0, #0x03 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyPow
			
				mov		r1, #0x03 @UndoID
				mov		r2, #0x03 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyPow:
				mov		r0, #0
				b		End_UndoEMS_CopyPow
				
				True_UndoEMS_CopyPow:
				mov		r0, #1
		
		End_UndoEMS_CopyPow:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyInjury
@-----------------------------------------


		UndoEMS_CopyInjury:
		push	{r14}
		ldrb	r0, [r4,#0x04] @Save data location
		mov		r1, #0x3B @Unit RAM location
		ldrb	r1, [r6,r1]
		cmp		r0, r1
		beq		False_UndoEMS_CopyInjury
		
			mov		r0, #0x04 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyInjury
			
				mov		r1, #0x04 @UndoID
				mov		r2, #0x04 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyInjury:
				mov		r0, #0
				b		End_UndoEMS_CopyInjury
				
				True_UndoEMS_CopyInjury:
				mov		r0, #1
		
		End_UndoEMS_CopyInjury:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopySkl
@-----------------------------------------


		UndoEMS_CopySkl:
		push	{r14}
		ldrb	r0, [r4,#0x05] @Save data location
		ldrb	r1, [r6,#0x15] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopySkl
		
			mov		r0, #0x05 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopySkl
			
				mov		r1, #0x05 @UndoID
				mov		r2, #0x05 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopySkl:
				mov		r0, #0
				b		End_UndoEMS_CopySkl
				
				True_UndoEMS_CopySkl:
				mov		r0, #1
		
		End_UndoEMS_CopySkl:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopySpd
@-----------------------------------------


		UndoEMS_CopySpd:
		push	{r14}
		ldrb	r0, [r4,#0x06] @Save data location
		ldrb	r1, [r6,#0x16] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopySpd
		
			mov		r0, #0x06 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopySpd
			
				mov		r1, #0x06 @UndoID
				mov		r2, #0x06 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopySpd:
				mov		r0, #0
				b		End_UndoEMS_CopySpd
				
				True_UndoEMS_CopySpd:
				mov		r0, #1
		
		End_UndoEMS_CopySpd:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyDef
@-----------------------------------------


		UndoEMS_CopyDef:
		push	{r14}
		ldrb	r0, [r4,#0x07] @Save data location
		ldrb	r1, [r6,#0x17] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyDef
		
			mov		r0, #0x07 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyDef
			
				mov		r1, #0x07 @UndoID
				mov		r2, #0x07 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyDef:
				mov		r0, #0
				b		End_UndoEMS_CopyDef
				
				True_UndoEMS_CopyDef:
				mov		r0, #1
		
		End_UndoEMS_CopyDef:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyRes
@-----------------------------------------


		UndoEMS_CopyRes:
		push	{r14}
		ldrb	r0, [r4,#0x08] @Save data location
		ldrb	r1, [r6,#0x18] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyRes
		
			mov		r0, #0x08 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyRes
			
				mov		r1, #0x08 @UndoID
				mov		r2, #0x08 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyRes:
				mov		r0, #0
				b		End_UndoEMS_CopyRes
				
				True_UndoEMS_CopyRes:
				mov		r0, #1
		
		End_UndoEMS_CopyRes:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyLck
@-----------------------------------------


		UndoEMS_CopyLck:
		push	{r14}
		ldrb	r0, [r4,#0x09] @Save data location
		ldrb	r1, [r6,#0x19] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyLck
		
			mov		r0, #0x09 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyLck
			
				mov		r1, #0x09 @UndoID
				mov		r2, #0x09 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyLck:
				mov		r0, #0
				b		End_UndoEMS_CopyLck
				
				True_UndoEMS_CopyLck:
				mov		r0, #1
		
		End_UndoEMS_CopyLck:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyConBonus
@-----------------------------------------


		UndoEMS_CopyConBonus:
		push	{r14}
		ldrb	r0, [r4,#0x0A] @Save data location
		ldrb	r1, [r6,#0x1A] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyConBonus
		
			mov		r0, #0x0A @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyConBonus
			
				mov		r1, #0x0A @UndoID
				mov		r2, #0x0A @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyConBonus:
				mov		r0, #0
				b		End_UndoEMS_CopyConBonus
				
				True_UndoEMS_CopyConBonus:
				mov		r0, #1
		
		End_UndoEMS_CopyConBonus:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyMovBonus
@-----------------------------------------


		UndoEMS_CopyMovBonus:
		push	{r14}
		ldrb	r0, [r4,#0x0B] @Save data location
		ldrb	r1, [r6,#0x1D] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyMovBonus
		
			mov		r0, #0x0B @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyMovBonus
			
				mov		r1, #0x0B @UndoID
				mov		r2, #0x0B @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyMovBonus:
				mov		r0, #0
				b		End_UndoEMS_CopyMovBonus
				
				True_UndoEMS_CopyMovBonus:
				mov		r0, #1
		
		End_UndoEMS_CopyMovBonus:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyLvExpPos
@-----------------------------------------


		UndoEMS_CopyLvExpPos:
		push	{r14}
		
		@Coords
		mov		r0, #0x3F
		ldrb	r1, [r6,#0x10]
		and		r1, r0
		ldrb	r2, [r6,#0x11]
		and		r2, r0
		lsl		r2, #6
		orr		r1, r2
		
		@Lv
		mov		r0, #0x1F
		ldrb	r2, [r6,#0x08]
		and		r2, r0
		lsl		r2, #12
		orr		r1, r2
		
		@Exp
		ldrb	r2, [r6,#0x09]
		lsl		r2, #17
		orr		r1, r2
		
		@Anything above 0xFFFFFF isn't remembered, so for comparing to what is actually loaded, limit this value to that
		lsl		r1, #8
		lsr		r1, #8
		
		ldrh	r0, [r4,#0x0C] @Save data location
		ldrb	r2, [r4,#0x0E]
		lsl		r2, #16
		orr		r0, r2
		
		cmp		r0, r1
		beq		False_UndoEMS_CopyLvExpPos
		
			mov		r0, #0x0C @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyLvExpPos
			
				mov		r1, #0x0C @UndoID
				mov		r2, #0x0C @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyLvExpPos:
				mov		r0, #0
				b		End_UndoEMS_CopyLvExpPos
				
				True_UndoEMS_CopyLvExpPos:
				mov		r0, #1
		
		End_UndoEMS_CopyLvExpPos:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyWEXP
@-----------------------------------------


		UndoEMS_CopyWEXP:
		push	{r4,r6,r14}
		add		r4, #0x0F @Save data location
		add		r6, #0x28 @Unit RAM location
		mov		r2, #0
		
		Loop_CompareWEXP:
		ldrb	r0, [r4,r2]
		ldrb	r1, [r6,r2]
		cmp		r0, r1
		bne		CopyWEXP_PrepareCreateUndoEntry
		
			add		r2, #1
			cmp		r2, #8
			blt		Loop_CompareWEXP
			
				pop		{r4,r6}
				b		False_UndoEMS_CopyWEXP
			
		CopyWEXP_PrepareCreateUndoEntry:
		pop		{r4,r6}
		mov		r0, #0x0D @UndoID
		blh		PrepareCreateUndoEntry, r1
		cmp		r0, #0
		beq		True_UndoEMS_CopyWEXP
		
			mov		r1, #0x0D @UndoID
			mov		r2, #0x0F @Save data location
			blh		CreateUndoEntry, r3
			
			False_UndoEMS_CopyWEXP:
			mov		r0, #0
			b		End_UndoEMS_CopyWEXP
			
			True_UndoEMS_CopyWEXP:
			mov		r0, #1
		
		End_UndoEMS_CopyWEXP:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopySupport
@-----------------------------------------


		UndoEMS_CopySupport:
		push	{r4,r6,r14}
		add		r4, #0x17 @Save data location
		add		r6, #0x32 @Unit RAM location
		mov		r2, #0
		
		Loop_CompareSupport:
		ldrb	r0, [r4,r2]
		ldrb	r1, [r6,r2]
		cmp		r0, r1
		bne		CopySupport_PrepareCreateUndoEntry
		
			add		r2, #1
			cmp		r2, #7
			blt		Loop_CompareSupport
			
				pop		{r4,r6}
				b		False_UndoEMS_CopySupport
			
		CopySupport_PrepareCreateUndoEntry:
		pop		{r4,r6}
		mov		r0, #0x0E @UndoID
		blh		PrepareCreateUndoEntry, r1
		cmp		r0, #0
		beq		True_UndoEMS_CopySupport
		
			mov		r1, #0x0E @UndoID
			mov		r2, #0x17 @Save data location
			blh		CreateUndoEntry, r3
			
			False_UndoEMS_CopySupport:
			mov		r0, #0
			b		End_UndoEMS_CopySupport
			
			True_UndoEMS_CopySupport:
			mov		r0, #1
		
		End_UndoEMS_CopySupport:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyInventory
@-----------------------------------------


		UndoEMS_CopyInventory:
		push	{r14}
		mov		r2, #0x1E @Save data location & Unit RAM location
		mov		r3, #0
		
		Loop_CompareInventory:
		ldrh	r0, [r4,r2]
		ldrh	r1, [r6,r2]
		cmp		r0, r1
		bne		CopyInventory_PrepareCreateUndoEntry
		
			add		r2, #2
			add		r3, #1
			cmp		r3, #5
			blt		Loop_CompareInventory
			
				b		False_UndoEMS_CopyInventory
		
		CopyInventory_PrepareCreateUndoEntry:
		mov		r0, #0x0F @UndoID
		blh		PrepareCreateUndoEntry, r1
		cmp		r0, #0
		beq		True_UndoEMS_CopyInventory
		
			mov		r1, #0x0F @UndoID
			mov		r2, #0x1E @Save data location
			blh		CreateUndoEntry, r3
			
			False_UndoEMS_CopyInventory:
			mov		r0, #0
			b		End_UndoEMS_CopyInventory
			
			True_UndoEMS_CopyInventory:
			mov		r0, #1
		
		End_UndoEMS_CopyInventory:
		pop		{r1}
		bx		r1
		
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyState
@-----------------------------------------


		UndoEMS_CopyState:
		push	{r14}
		ldr		r0, [r4,#0x28] @Save data location
		ldr		r1, [r6,#0x0C] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyState
			
			mov		r0, #0x10 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyState
			
				mov		r1, #0x10 @UndoID
				mov		r2, #0x28 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyState:
				mov		r0, #0
				b		End_UndoEMS_CopyState
				
				True_UndoEMS_CopyState:
				mov		r0, #1
		
		End_UndoEMS_CopyState:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyCurHP
@-----------------------------------------


		UndoEMS_CopyCurHP:
		push	{r14}
		mov		r0, #0x2C @Save data location
		ldrb	r0, [r4,r0]
		ldrb	r1, [r6,#0x13] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyCurHP
		
			mov		r0, #0x11 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyCurHP
			
				mov		r1, #0x11 @UndoID
				mov		r2, #0x2C @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyCurHP:
				mov		r0, #0
				b		End_UndoEMS_CopyCurHP
				
				True_UndoEMS_CopyCurHP:
				mov		r0, #1
		
		End_UndoEMS_CopyCurHP:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyRescue
@-----------------------------------------


		UndoEMS_CopyRescue:
		push	{r14}
		mov		r0, #0x2D @Save data location
		ldrb	r0, [r4,r0]
		ldrb	r1, [r6,#0x1B] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyRescue
		
			mov		r0, #0x12 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyRescue
			
				mov		r1, #0x12 @UndoID
				mov		r2, #0x2D @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyRescue:
				mov		r0, #0
				b		End_UndoEMS_CopyRescue
				
				True_UndoEMS_CopyRescue:
				mov		r0, #1
		
		End_UndoEMS_CopyRescue:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyBallista
@-----------------------------------------


		UndoEMS_CopyBallista:
		push	{r14}
		mov		r0, #0x2E @Save data location
		ldrb	r0, [r4,r0]
		ldrb	r1, [r6,#0x1C] @Unit RAM location
		cmp		r0, r1
		beq		False_UndoEMS_CopyBallista
		
			mov		r0, #0x13 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyBallista
			
				mov		r1, #0x13 @UndoID
				mov		r2, #0x2E @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyBallista:
				mov		r0, #0
				b		End_UndoEMS_CopyBallista
				
				True_UndoEMS_CopyBallista:
				mov		r0, #1
		
		End_UndoEMS_CopyBallista:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyStatus
@-----------------------------------------


		UndoEMS_CopyStatus:
		push	{r14}
		mov		r0, #0x2F @Save data location
		ldrb	r0, [r4,r0]
		mov		r1, #0x30 @Unit RAM location
		ldrb	r1, [r6,r1]
		cmp		r0, r1
		beq		False_UndoEMS_CopyStatus
		
			mov		r0, #0x14 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyStatus
			
				mov		r1, #0x14 @UndoID
				mov		r2, #0x2F @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyStatus:
				mov		r0, #0
				b		End_UndoEMS_CopyStatus
				
				True_UndoEMS_CopyStatus:
				mov		r0, #1
		
		End_UndoEMS_CopyStatus:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyTorchBarrier
@-----------------------------------------


		UndoEMS_CopyTorchBarrier:
		push	{r14}
		mov		r0, #0x30 @Save data location
		ldrb	r0, [r4,r0]
		mov		r1, #0x31 @Unit RAM location
		ldrb	r1, [r6,r1]
		cmp		r0, r1
		beq		False_UndoEMS_CopyTorchBarrier
		
			mov		r0, #0x15 @UndoID
			blh		PrepareCreateUndoEntry, r1
			cmp		r0, #0
			beq		True_UndoEMS_CopyTorchBarrier
			
				mov		r1, #0x15 @UndoID
				mov		r2, #0x30 @Save data location
				blh		CreateUndoEntry, r3
				
				False_UndoEMS_CopyTorchBarrier:
				mov		r0, #0
				b		End_UndoEMS_CopyTorchBarrier
				
				True_UndoEMS_CopyTorchBarrier:
				mov		r0, #1
		
		End_UndoEMS_CopyTorchBarrier:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_CopyAI
@-----------------------------------------


		UndoEMS_CopyAI:
		push	{r4,r6,r14}
		add		r4, #0x31 @Save data location
		
		ldrb	r0, [r4,#4]
		ldrb	r1, [r6,#0x0A]
		cmp		r0, r1
		bne		CopyAI_PrepareCreateUndoEntry
		
		add		r6, #0x40 @Unit RAM location
		
		@AI1, AI2
		ldrb	r0, [r4]
		ldrb	r1, [r6,#2]
		cmp		r0, r1
		bne		CopyAI_PrepareCreateUndoEntry
		
		ldrb	r0, [r4,#1]
		ldrb	r1, [r6,#4]
		cmp		r0, r1
		bne		CopyAI_PrepareCreateUndoEntry
			
			@AI1 counter, AI2 counter
			ldrb	r0, [r4,#2]
			ldrb	r1, [r6,#3]
			cmp		r0, r1
			bne		CopyAI_PrepareCreateUndoEntry
			
			ldrb	r0, [r4,#3]
			ldrb	r1, [r6,#5]
			cmp		r0, r1
			bne		CopyAI_PrepareCreateUndoEntry
			
				@AI3, AI4
				ldrb	r0, [r4,#5]
				ldrb	r1, [r6]
				cmp		r0, r1
				bne		CopyAI_PrepareCreateUndoEntry
				
				ldrb	r0, [r4,#6]
				ldrb	r1, [r6,#1]
				cmp		r0, r1
				bne		CopyAI_PrepareCreateUndoEntry
				
					pop		{r4,r6}
					b		False_UndoEMS_CopyAI
		
		CopyAI_PrepareCreateUndoEntry:
		pop		{r4,r6}
		mov		r0, #0x16 @UndoID
		blh		PrepareCreateUndoEntry, r1
		cmp		r0, #0
		beq		True_UndoEMS_CopyAI
		
			mov		r1, #0x16 @UndoID
			mov		r2, #0x31 @Save data location
			blh		CreateUndoEntry, r3
			
			False_UndoEMS_CopyAI:
			mov		r0, #0
			b		End_UndoEMS_CopyAI
			
			True_UndoEMS_CopyAI:
			mov		r0, #1
		
		End_UndoEMS_CopyAI:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

