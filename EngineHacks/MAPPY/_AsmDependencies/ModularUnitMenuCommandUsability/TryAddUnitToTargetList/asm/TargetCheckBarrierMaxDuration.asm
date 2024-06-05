.thumb

.equ origin, 0
.include "../TryAddUnitToTargetListDefs.s"

.global TargetCheckBarrierMaxDuration
.type TargetCheckBarrierMaxDuration, %function

@not a valid target if at barrier max duration


		TargetCheckBarrierMaxDuration:
		mov		r0, #0
		mov		r2, #0x31
		ldrb	r1, [r1,r2]
		lsr		r1, #4
		cmp		r1, #6
		bhi		End
		
			mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

