.thumb

.include "../ShiftDefs.s"

.global InflictShift
.type InflictShift, %function


		InflictShift:
		@push	{r4-r7,r14} @r15 stack alignment
		push	{r4-r7} @r15 stack alignment
		mov		r7, r0 @proc stuff or something
		ldr		r4, =gActionData
		ldrb	r0, [r4,#0x0C]
		ldr		r6, =GetUnit
		mov		lr, r6
		.short	0xF800
		mov		r5, r0 @staff user
		ldrb	r1, [r4,#0x12]
		ldr		r2, =SetupSubjectBattleUnitForStaff
		mov		lr, r2
		.short	0xF800
		
		ldrb	r0, [r4,#0x0D]
		mov		lr, r6
		.short	0xF800
		mov		r6, r0 @target
		ldr		r1, =SetupTargetBattleUnitForStaff
		mov		lr, r1
		.short	0xF800
		
		mov		r0, r6
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldrb	r1, [r0,#1] @where debuff is in unit debuff
		mov		r2, #0x0F
		and		r1, r2
		add		r1, #0x30
		strb	r1, [r0,#1]
		
		FinalizeShiftEffect:
		mov		r0, r7
		ldr		r1, =FinishUpItemBattle
		mov		lr, r1
		.short	0xF800
		ldr		r0, =BeginBattleAnimations
		mov		lr, r0
		.short	0xF800
		pop		{r4-r7}
		pop		{r4} @r15 stack alignment
		mov		r8, r4 @r15 stack alignment
		pop		{r4-r7} @r15 stack alignment
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

