.thumb

.global MaxMovCap
.type MaxMovCap, %function 
MaxMovCap:
@ r0 = movement 
@ r1 = unit 
ldr r2, =MaxMovementValue_Link
ldr r2, [r2] 
cmp r0, r2 
ble NoCapHere
mov r0, r2 
NoCapHere: 
@ returns new movement 
bx lr 
.ltorg 

