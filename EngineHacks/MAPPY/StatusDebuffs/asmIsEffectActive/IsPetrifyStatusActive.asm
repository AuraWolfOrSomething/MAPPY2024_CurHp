.thumb

.global IsPetrifyStatusActive
.type IsPetrifyStatusActive, %function


		IsPetrifyStatusActive:
		mov		r1, #0x30
		ldrb	r0, [r0,r1]
		lsl		r1, r0, #28
		lsr		r1, #28
		mov		r2, #0x0B @status id
		cmp		r1, r2
		bne		ReturnFalse
		
			lsr		r0, #4 @return duration
			b		End
		
		ReturnFalse:
		mov		r0, #0
		
		End:
		bx		r14
		
		.align
		.ltorg

