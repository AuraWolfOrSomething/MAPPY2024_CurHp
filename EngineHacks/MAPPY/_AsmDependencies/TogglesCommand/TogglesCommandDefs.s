
.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.equ gMenu_MapMenu, 0x0859D214

.equ ProcGoto, 0x08002F24

.equ LoadDialogueBoxGfx, 0x08089804
.equ Text_InitFont, 0x08003C94
.equ EndPlayerPhaseSideWindows, 0x0808D150
.equ HideMoveRangeGraphics, 0x0801DACC
.equ StartPrepScreenMenu, 0x08096FAC
.equ SetPrepScreenMenuItem, 0x08097024

.equ Routine_080333C5, 0x080333C5
.equ Routine_080333A5, 0x080333A5
.equ Routine_08033635, 0x08033635

.equ Routine_08033620, 0x08033620
.equ SetPrepScreenMenuOnBPress, 0x08096FD0
.equ SetPrepScreenMenuOnStartPress, 0x08096FEC
.equ SetPrepScreenMenuOnEnd, 0x08097008
.equ DrawPrepScreenMenuFrameAt, 0x08097154
.equ SetPrepScreenMenuSelectedItem, 0x080970CC
.equ EnableBgSyncByMask, 0x08001FAC
