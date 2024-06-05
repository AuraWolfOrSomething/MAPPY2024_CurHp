
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ CheckIfUnitHasItem, 0x080179F8
.equ gTargetBattleUnit, 0x0203A56C
.equ gActiveBattleUnit, 0x0203A4EC

.equ CheckEventId, 0x08083DA8
.equ RefreshEntityMaps, 0x0801A1F4
.equ CanActiveUnitMove, 0x08018BD8
