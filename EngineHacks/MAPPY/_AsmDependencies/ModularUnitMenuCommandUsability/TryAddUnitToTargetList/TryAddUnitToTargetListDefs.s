
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gUnitSubject, 0x02033F3C
.equ AddTarget, 0x0804F8BC

.equ AreAllegiancesAllied, 0x08024D8C
.equ AreAllegiancesEqual, 0x08024DA4

.equ bl_AreAllegiancesEqual, . + 0x08024DA4 - origin
.equ gChapterData, 0x0202BCF0
.equ bl_GetUnit, . + 0x08019430 - origin

.equ IsItemHammernable, 0x08017080
.equ GetUnit, 0x08019430
.equ CanUnitRescue, 0x0801831C
