.thumb

.global FutureIsTurnEventEligible
.type FutureIsTurnEventEligible, %function


		FutureIsTurnEventEligible:
		
		@SVAL
		mov		r2, #5
		lsl		r2, #8
		add		r2, #0x40
		
		@If next event code isn't SVAL s0, return true
		ldr		r1, [r0]
		cmp		r1, r2
		bne		ReturnTrue
		
			@If attemping to set 0, return false
			ldr		r0, [r0,#4]
			cmp		r0, #0
			beq		End
			
				cmp		r0, #2
				bne		ReturnTrue

					@Return false
					mov		r0, #0
					b		End
		
		ReturnTrue:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

