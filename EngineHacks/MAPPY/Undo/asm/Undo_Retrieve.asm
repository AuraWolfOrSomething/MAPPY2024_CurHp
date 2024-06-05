.thumb

.include "../UndoDefs.s"

.global Undo_Retrieve
.type Undo_Retrieve, %function


		Undo_Retrieve:
		push	{r4-r7,r14}
		ldr		r4, =UndoDataRAMPointer
		ldr		r4, [r4]
		
		ldr		r5, =Undo_RetrieveFunctionNonUnitList
		
		Loop_RetrieveNonUnits_List:
		ldr		r1, [r5]
		cmp		r1, #0
		beq		RetrieveUnits

			ldrh	r2, [r5,#6]
			ldrh	r3, [r5,#4]
			lsr		r0, r3, #2
			lsl		r0, #2
			cmp		r0, r3
			blt		Loop_RetrieveNonUnits_Byte

			Loop_RetrieveNonUnits_Entry:
			ldr		r0, [r4,r2]
			str		r0, [r1,r2]
			add		r2, #4
			
				cmp		r2, r3
				blt		Loop_RetrieveNonUnits_Entry
			
			NextEntry_RetrieveNonUnits:
			add		r4, r3
			add		r5, #8
			b		Loop_RetrieveNonUnits_List
						
			Loop_RetrieveNonUnits_Byte:
			ldrb	r0, [r4,r2]
			strb	r0, [r1,r2]
			add		r2, #1
			cmp		r2, r3
			blt		Loop_RetrieveNonUnits_Byte
			
				b		NextEntry_RetrieveNonUnits
		
		RetrieveUnits:
		mov		r5, #0 @most recent unit id
		mov		r6, #0 @most recent unit retrieved
		
		Loop_UndoDataRAM:
		ldrb	r7, [r4]
		cmp		r7, #0
		beq		End_Undo_Retrieve
		
			ldrb	r0, [r4,#1]
			blh		GetUnit, r1
			mov		r1, r0
			mov		r0, r4
			ldr		r2, =Undo_RetrieveFunctionTable
			lsl		r3, r7, #2
			ldr		r2, [r2,r3]
			mov		lr, r2
			.short	0xF800
			
			ldr		r2, =UndoEntrySizeTable
			ldrb	r2, [r2,r7]
			
			add		r4, r2
			b		Loop_UndoDataRAM
		
		End_Undo_Retrieve:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

