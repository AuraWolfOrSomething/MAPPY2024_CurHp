.thumb
.org 0x0

@bl'd to at 24670
@since I cannot find a way to distinguish when a character is healing vs talk/support/dance/play, we're going to copy the entire function, essentially
@r0 = char data of target
ldr		r1, ShowHealAmount_Func
mov		lr, r1
.short	0xF800
pop		{r4}
pop		{r1}
bx		r1

.align

ShowHealAmount_Func:
