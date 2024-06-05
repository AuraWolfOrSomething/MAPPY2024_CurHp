
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ WriteAndVerifySramFast, 0x080D184C|1
.equ ReadSramFastAddr, 0x030067A0
.equ IsSramWorking, 0x080A2CB0|1
.equ GetSaveTargetAddress, 0x080A3064|1
.equ SaveMetadata_Save, 0x080A2F94|1

.equ PlayerSuspendUnitSize, 0x34
.equ EnemySuspendUnitSize, 0x38
.equ NPCSuspendUnitSize, 0x38
.equ UndoBaseSize, 0x02
.equ UndoID_PlayerUnit, 0x17
.equ UndoID_EnemyUnit, 0x18
.equ UndoID_NPCUnit, 0x19

.equ UndoID_AllMisc, 0xFF
.equ DebuffEntrySize, 8

.equ GetSaveSourceAddress, 0x080A3114
.equ GetGameClock, 0x08000D28
.equ gChapterData, 0x0202BCF0
.equ GetUnit, 0x08019430

.equ GetCharacterData, 0x08019464
.equ GetClassData, 0x08019444

.equ MenuCallHelpBox, 0x0804F580
.equ m4aSongNumStart, 0x080D01FC
.equ EndBMAPMAIN, 0x080311F0
.equ gProcStatePool, 0x02024E68
.equ GameControl_8030FE4, 0x08030FE4

.equ Text_SetColorId, 0x08003E60
.equ String_GetFromIndex, 0x0800A240
.equ Text_DrawString, 0x08004004
.equ GetBgMapBuffer, 0x08001C4C
.equ Text_Display, 0x08003E70
