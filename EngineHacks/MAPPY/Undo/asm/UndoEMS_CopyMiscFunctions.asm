.thumb

.include "../UndoDefs.s"

.global UndoEMS_CopyPlayerDebuffs
.type UndoEMS_CopyPlayerDebuffs, %function

.global UndoEMS_CopyEnemyDebuffs
.type UndoEMS_CopyEnemyDebuffs, %function

.global UndoEMS_CopyNPCDebuffs
.type UndoEMS_CopyNPCDebuffs, %function


@-----------------------------------------
@UndoEMS_CopyPlayerDebuffs
@UndoEMS_CopyEnemyDebuffs
@UndoEMS_CopyNPCDebuffs
@-----------------------------------------


		.macro COPY_UNIT_FUNC Name, StructSize, UndoID, Allegiance, MaxUnits

		\Name :
		push	{r4-r7,r14}
		mov		r4, r8
		mov		r5, r9
		push	{r4-r5}
		sub		sp, #(\StructSize)
		mov		r4, r0
		mov		r5, r1
		mov		r6, #(\Allegiance + 1)
		mov		r7, #(\MaxUnits)
		
		ldr		r0, =gSuspendDebuffChunk
		ldrh	r0, [r0]
		add		r4, r0
		ldr		r0, [r2]
		ldr		r1, =TeamDebuffTables
		ldr		r1, [r1]
		sub		r0, r1
		add		r4, r0
		add		r4, #(\StructSize)
		
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
		
			@ldr		r1, =UndoEMS_CopyUnit
			@mov		lr, r1
			@mov		r1, r5
			@mov		r2, #(\StructSize)
			@mov		r3, #(\UndoID)
			@mov		r8, r4
			@mov		r4, sp
			@.short	0xF800
			@mov		r5, r0
			@mov		r4, r8
			
			ldrb	r1, [r0,#0x0B]
			mov		r8, r1
			blh		GetDebuffs, r1
			mov		r3, #0
			mov		r9, r7
			mov		r7, sp
			
			\Name\().Loop_CompareDebuffs :
			ldrb	r1, [r0,r3]
			ldrb	r2, [r7,r3]
			cmp		r1, r2
			bne		\Name\().CopyDebuffs
			
				add		r3, #1
				cmp		r3, #(\StructSize)
				blt		\Name\().Loop_CompareDebuffs
				
					b		\Name\().NextUnitDebuff
				
			\Name\().CopyDebuffs :
			mov		r0, #(\UndoID)
			strb	r0, [r5]
			mov		r0, r8
			strb	r0, [r5,#1]
			add		r5, #2
			mov		r1, #0
			
			\Name\().Loop_CopyDebuffs :
			ldrb	r0, [r7,r1]
			strb	r0, [r5,r1]
			add		r1, #1
			cmp		r1, #(\StructSize)
			blt		\Name\().Loop_CopyDebuffs
			
			add		r5, #(\StructSize)
			
			\Name\().NextUnitDebuff :
			mov		r7, r9
			
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
		pop		{r4-r5}
		mov		r9, r5
		mov		r8, r4
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg
		
		.endm
		
		COPY_UNIT_FUNC UndoEMS_CopyPlayerDebuffs, 0x08, 0x1A, 0x00, 60
		
		COPY_UNIT_FUNC UndoEMS_CopyEnemyDebuffs, 0x08, 0x1A, 0x80, 50
		
		COPY_UNIT_FUNC UndoEMS_CopyNPCDebuffs, 0x08, 0x1A, 0x40, 20

