.thumb

.include "../IneptDefs.s"

.global IneptUsability
.type IneptUsability, %function


		IneptUsability:
		@push	{r14} @r15 stack alignment
		mov		r2, r1
		ldr		r1, =IneptStaffRangeSetup
		ldr		r3, =IsGeneratedTargetListEmpty
		mov		lr, r3
		.short	0xF800
		pop		{r4-r5} @r15 stack alignment
		pop		{r1}
		bx		r1
		
		.align
		.ltorg
