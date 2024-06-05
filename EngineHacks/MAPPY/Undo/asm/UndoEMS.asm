.thumb

.include "../UndoDefs.s"

.global UndoEMS_Copy
.type UndoEMS_Copy, %function

.global UndoEMS_PlayerUnits
.type UndoEMS_PlayerUnits, %function

.global UndoEMS_EnemyUnits
.type UndoEMS_EnemyUnits, %function

.global UndoEMS_NPCUnits
.type UndoEMS_NPCUnits, %function

.global UndoEMS_Reset
.type UndoEMS_Reset, %function

.global UndoEMS_Save
.type UndoEMS_Save, %function

.global UndoEMS_Load
.type UndoEMS_Load, %function


@-----------------------------------------
@UndoEMS_Copy
@-----------------------------------------


		UndoEMS_Copy:
		push	{r4-r7,r14}
		add		sp, #-0x20

		mov		r0, #4
		blh		GetSaveSourceAddress, r1
		mov		r4, r0
		str		r0, [sp,#0x18]
		
		ldr		r5, =UndoDataRAMPointer
		ldr		r5, [r5]
		mov		r7, #0
		ldr		r6, =UndoCopyListNonUnitSizePointer
		ldrh	r6, [r6]
		
		Loop_Copy:
		add		r0, r4, r7
		mov		r1, sp
		mov		r2, #8
		ldr		r3, =ReadSramFastAddr
		ldr		r3, [r3]
		mov		lr, r3
		.short	0xF800
		ldr		r0, [sp]
		str		r0, [r5,r7]
		add		r1, r7, #4
		ldr		r0, [sp,#4]
		str		r0, [r5,r1]
		add		r7, #8
		cmp		r7, r6
		blt		Loop_Copy

		add		r5, r6

		mov		r0, #1
		ldr		r1, =UndoDataRAMPointer
		ldr		r1, [r1]
		str		r0, [r1]

		mov		r0, r4
		ldr		r2, =gSuspendPlayerUnitChunk
		ldrh	r1, [r2]
		add		r0, r1
		mov		r1, r5
		ldrh	r2, [r2,#2]
		blh		UndoEMS_PlayerUnits, r3
		cmp		r0, #0
		beq		UndoOverfilled
		
		mov		r1, r0
		mov		r0, r4
		ldr		r2, =gSuspendEnemyUnitChunk
		ldrh	r3, [r2]
		add		r0, r3
		ldrh	r2, [r2,#2]
		blh		UndoEMS_EnemyUnits, r3
		cmp		r0, #0
		beq		UndoOverfilled
		
		mov		r1, r0
		mov		r0, r4
		ldr		r2, =gSuspendNPCUnitChunk
		ldrh	r3, [r2]
		add		r0, r3
		ldrh	r2, [r2,#2]
		blh		UndoEMS_NPCUnits, r3
		cmp		r0, #0
		beq		UndoOverfilled
		
		mov		r5, r0
		ldr		r6, =UndoEMS_CopyMiscFunctionList
		
		Loop_UndoEMS_CopyMiscFunctionList:
		ldr		r3, [r6]
		cmp		r3, #0
		beq		End_UndoEMS_Copy
		
			mov		r0, r4
			mov		r1, r5
			ldr		r2, [r6,#4]
			mov		lr, r3
			.short	0xF800
			cmp		r0, #0
			beq		UndoOverfilled
			
				mov		r5, r0
				add		r6, #8
				b		Loop_UndoEMS_CopyMiscFunctionList
		
		@mov		r1, r0
		@mov		r0, r4
		@blh		UndoEMS_CopyMiscFunctions, r2
		@cmp		r0, #0
		@bne		End_UndoEMS_Copy
			
		UndoOverfilled:
		blh		UndoEMS_Reset, r0
		
		End_UndoEMS_Copy:
		add		sp, #0x20
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_PlayerUnits
@UndoEMS_EnemyUnits
@UndoEMS_NPCUnits
@-----------------------------------------


		.macro COPY_UNIT_FUNC Name, StructSize, UndoID, Allegiance

		\Name :
		push	{r4-r7,r14}
		mov		r4, r8
		push	{r4}
		sub		sp, #(\StructSize)
		mov		r4, r0
		mov		r5, r1
		
		mov		r0, r2
		mov		r1, #(\StructSize)
		swi		#6
		mov		r7, r0
		mov		r6, #(\Allegiance + 1)
		
		\Name\().Loop_ReadSram :
		mov		r0, r4
		mov		r1, sp
		mov		r2, #(\StructSize)
		ldr		r3, =ReadSramFastAddr
		ldr		r3, [r3]
		mov		lr, r3
		.short	0xF800
		
		mov		r0, r6
		blh		GetUnit, r1
		cmp		r0, #0
		beq		\Name\().ReturnRam
		
			ldr		r1, =UndoEMS_CopyUnit
			mov		lr, r1
			mov		r1, r5
			mov		r2, #(\StructSize)
			mov		r3, #(\UndoID)
			mov		r8, r4
			mov		r4, sp
			.short	0xF800
			mov		r5, r0
			mov		r4, r8
			
			@is there still room in undo data
			ldr		r0, =UndoDataRAMPointer
			ldr		r0, [r0]
			ldr		r1, =UndoCopyListTotalSizePointer
			ldrh	r1, [r1]
			add		r0, r1
			sub		r0, r5
			add		r4, #(\StructSize)
			mov		r1, #(\StructSize)
			add		r1, #UndoBaseSize
			@ldr		r2, =UndoEntrySizeTable
			@mov		r3, #UndoID_AllMisc
			@ldrb	r2, [r2,r3]
			@add		r1, r2
			cmp		r0, r1
			blt		\Name\().ReturnZero
			
				add		r6, #1
				sub		r7, #1
				bgt		\Name\().Loop_ReadSram
				
					\Name\().ReturnRam :
					mov		r0, r5
					b		\Name\().End
					
					\Name\().ReturnZero :
					mov		r0, #0
				
		\Name\().End :
		add		sp, #(\StructSize)
		pop		{r4}
		mov		r8, r4
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg
		
		.endm
		
		COPY_UNIT_FUNC UndoEMS_PlayerUnits, PlayerSuspendUnitSize, 0x17, 0x00
		
		COPY_UNIT_FUNC UndoEMS_EnemyUnits, EnemySuspendUnitSize, 0x18, 0x80
		
		COPY_UNIT_FUNC UndoEMS_NPCUnits, NPCSuspendUnitSize, 0x19, 0x40


@-----------------------------------------
@UndoEMS_Reset
@-----------------------------------------


		UndoEMS_Reset:
		mov		r0, #0
		ldr		r1, =UndoDataRAMPointer
		ldr		r1, [r1]
		ldr		r2, =UndoCopyListTotalSizePointer
		ldrh	r2, [r2]
		add		r2, r1
		
		Loop_Reset:
		str		r0, [r1]
		add		r1, #4
		cmp		r1, r2
		blt		Loop_Reset
		
		bx		r14
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_Save
@-----------------------------------------

@observations from EMS unit saving
@r0 = current location in save data
@r1 = declared size of chunk
@save unit into space allocated from stack, then call WriteAndVerifySramFast

		UndoEMS_Save:
		push	{r4,r14}
		mov		r4, r0 @current spot in save data
		sub		sp, #4
		mov		r2, r1
		@mov		r2, #1

		@Transfer from RAM to IRAM
		ldr		r0, =UndoStatusRAMPointer
		ldr		r0, [r0]
		mov		r1, sp
		ldr		r3, [r0]
		str		r3, [r1]
		
		@Transfer from IRAM to Cart RAM
		mov		r0, sp
		mov		r1, r4
		blh		WriteAndVerifySramFast, r3
		
		@the end :)
		add		sp, #4
		pop		{r4}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@UndoEMS_Load
@-----------------------------------------

		UndoEMS_Load:
		push	{r14}
		mov		r2, r1 @size
		
		ldr		r1, =UndoStatusRAMPointer
		ldr		r1, [r1]
		ldr 	r3, =ReadSramFastAddr
		ldr 	r3, [r3] @ r3 = ReadSramFast
		mov 	lr, r3
		.short 	0xF800
		
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

