@Originally at 188A8
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ChapterData, 0x202BCF0 
.equ GetUnit, 0x8019430
.type ProcessPureWater, %function 
.global ProcessPureWater
ProcessPureWater: 
@This should do what the code in place did
cmp     r0,#0x0
beq     noBarrier
lsr     r1,r2,#0x4
sub     r1,#0x1
lsl     r0,r1,#0x4
noBarrier:
mov     r1,#0xF
mov r9, r1
and     r1,r2
cmp r1, #0x0
beq noTorch
sub r1, #0x1
mov r2, #0x1
mov r8, r2
noTorch: 
orr r0, r1
mov r3, r4
add     r3,#0x31
strb r0, [r3]
@no need to do anything
ldr r3, ReturnLocation
BXR3:
bx r3
.ltorg 

.global ProcessDebuffs
.type ProcessDebuffs, %function 
ProcessDebuffs: 
push {r4-r7, lr} 
mov r4, r8 
push {r4} 
ldr r0, =ChapterData 
ldrb r7, [r0, #0xF] @ phase / starting deployment ID 
mov r3, #0x40 
add r3, r7 @ ending point 
mov r8, r3 
cmp r7, #0 
beq UnitLoop 
sub r7, #1 @ players start at 1, npcs 0x40, enemies 0x80 
UnitLoop: 
add r7, #1 
cmp r7, r8  
blt Continue 
b DoneProcessDebuffs 
Continue: 
mov r0, r7 
blh GetUnit 
mov r4, r0
bl IsUnitOnField @(Unit* unit)
cmp r0, #0 
beq UnitLoop 

mov r0, r4
blh	GetDebuffs, r1
mov r3, r0
ldr r2, [r3]
mov r0, #0

@Do not remove Absorb debuff
ldrb r4, [r3,#3]
lsl r4, #24

processDebuffLoop:
mov r1, #0xF    @One debuff nibble
lsl r1, r0
and r1, r2
cmp r1, #0x0
beq noDebuff
lsr r1, r0
sub r1, #0x1    @decrement if there
lsl r1, r0
orr r4, r1
noDebuff: 
add r0, #0x4    @next nibble
cmp r0, #0x0C @anything in the third byte is automatically cleared (debuffs with a one turn duration)
ble processDebuffLoop
str r4, [r3]    @Store processed debuffs/no rallies

@Now the buffs
ldrh r2, [r3,#4]
mov r0, #0
mov r4, #0

processBuffLoop:
mov r1, #0xF    @One buff nibble
lsl r1, r0
and r1, r2
cmp r1, #0x0
beq noBuff
lsr r1, r0
sub r1, #0x1    @decrement if there
lsl r1, r0
orr r4, r1
noBuff: 
add r0, #4    @next nibble
cmp r0, #4 @anything in the second byte is automatically cleared (buffs with a one turn duration)
ble processBuffLoop
strh r4, [r3,#4]

b UnitLoop
DoneProcessDebuffs:
pop {r4} 
mov r8, r4 
mov r0, #0 @ no blocking proc / animation 
pop {r4-r7}
pop {r1} 
bx r1
.ltorg 

.global GetNewTemporaryStatValue
.type GetNewTemporaryStatValue, %function 
GetNewTemporaryStatValue:
@ given r0 as a signed buff, restore towards 0 
cmp r0, #0 
beq GotStatValue 
cmp r0, #0 
bgt DecrementBuff @ is this positive? 

@ DecrementDebuff 
ldr r2, =DebuffRestorePerTurnAmount_Link
ldr r2, [r2] 
add r0, r2 
cmp r0, #0 
ble GotStatValue 
mov r0, #0 
b GotStatValue 

DecrementBuff: 
cmp r1, #1 
beq GotStatValue 
ldr r2, =BuffDepletePerTurnAmount_Link
ldr r2, [r2] 
sub r0, r2 
cmp r0, #0 
bge GotStatValue 
mov r0, #0 
b GotStatValue 

GotStatValue: 
bx lr 
.ltorg 


.align
ReturnLocation:
    .long 0x80188E1
