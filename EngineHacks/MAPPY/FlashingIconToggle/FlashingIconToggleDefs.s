
.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@Status
.equ CheckEventID, 0x08083DA8 

@Toggle
.equ SetEventID, 0x08083D80 
.equ UnsetEventID, 0x08083D94 

@Map Menu
.equ m4aSongNumStart, 0x080D01FC
.equ gProc_Menu, 0x085B64D0
.equ ProcFind, 0x08002E9C

@Prep Screen
.equ BreakProcLoop, 0x08002E94
.equ GoToViewMap, 0x0803334D
.equ ProcGoto, 0x08002F24

@Usability
.equ gChapterData, 0x0202BCF0
