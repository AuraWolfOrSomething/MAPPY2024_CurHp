.thumb
.align


.global NegateCritWeapons
.type NegateCritWeapons, %function
NegateCritWeapons:
push {r4-r7, r14}
mov r4, r0 @attacker
mov r5, r1 @defender

mov r0,r4
add r0,#0x4A
ldrh r0,[r0] 
mov r1,#0xFF
and r0,r1

bne GoBack

mov r0,r4
add r0,#0x66
mov r1,#0
strh r1,[r0]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align
