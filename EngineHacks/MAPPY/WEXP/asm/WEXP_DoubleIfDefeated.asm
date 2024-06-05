.thumb

.global WEXP_DoubleIfDefeated
.type WEXP_DoubleIfDefeated, %function

		WEXP_DoubleIfDefeated:
		add     r1, #0x7B
		ldr     r1, [r1]
		lsl     r1, r1, #0x18
		asr     r1, r1, #0x18
		mul     r1, r0
		mov		r0, r1
		bx		r14
		
		.align
		.ltorg

