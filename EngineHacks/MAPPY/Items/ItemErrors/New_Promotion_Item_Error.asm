.thumb

.equ origin, 0x08028E20

.equ gGameState, 0x0202BCB0

.global New_Promotion_Item_Error
.type New_Promotion_Item_Error, %function


		New_Promotion_Item_Error:
		ldr		r0, =PromotionItemErrorTextLinks
		ldr		r1, =gGameState
		ldrb	r1, [r1,#4]
		mov		r2, #0x10
		tst		r1, r2
		beq		NotPreparationsMessage
			
			@Not Flow:
			ldrh	r0, [r0]
			b		End
			
			NotPreparationsMessage:
			ldrh	r0, [r0,#2]
			
		End:
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

