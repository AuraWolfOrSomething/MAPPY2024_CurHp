
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gChapterData, 0x0202BCF0
.equ gActionData, 0x0203A958

.equ WriteAndVerifySramFast, 0x080D184C|1
.equ ReadSramFastAddr, 0x030067A0

.equ String_GetFromIndex, 0x0800A240
