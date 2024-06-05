
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gActiveUnit, 0x03004E50
.equ gMapTerrain, 0x0202E4DC
.equ GetLocationEventCommandAt, 0x08084078
.equ CanUnitNotUseMagic, 0x08018D08
.equ MakeTargetListForTalk, 0x08025610
.equ GetTargetListSize, 0x0804FD28
.equ MakeTargetListForSupport, 0x08025644
.equ CanUnitOpenLock, 0x08018A9C
.equ MakeTargetListForDoorAndBridges, 0x08025814
.equ MakeRescueTargetList, 0x080253B4
.equ gGameState, 0x0202BCB0
.equ MakeDropTargetList, 0x08025440
.equ MakeTakeTargetList, 0x080254E0
.equ MakeGiveTargetList, 0x08025594
.equ MakeTradeTargetList, 0x080252D0
.equ gChapterData, 0x0202BCF0
.equ IsSupplyLordAdjacent, 0x08023EF0
.equ AjaxFourSides, 0x080D7C04
.equ gMapUnit, 0x0202E4D8
.equ GetUnit, 0x08019430
.equ CheckEventID, 0x08083DA8
