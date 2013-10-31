	LI R3 0x0 ;行号
	LI R4 0x0 ;列号
START:	;判断键盘是否可读
	NOP
	LI R0 0xBF
	SLL R0 R0 0x0
	NOP
	NOP
	NOP
	LW R0 R1 0x03
	NOP
	BEQZ R1 START
	NOP
LOAD:	;读取键盘
	LW R0 R2 0x02
	LI R0 0x38
	CMP R0 R2
	BTNEZ JUDGECOLUMN
	NOP
	ADDIU R3 0x1
	LI R4 0x0
	B START
	NOP
JUDGECOLUMN:	;判断是否达到行尾
	LI R0 0x10	;每行16字
	CMP R0 R4
	BTNEZ JUDGEROW
	NOP
	ADDIU R3 0x1	;行号+1
	LI R4 0x0		;列号归0
JUDGEROW:		;判断是否到达屏幕尾端
	LI R0 0x0E	;14行
	CMP R0 R3
	BTNEZ PRINT
	NOP
	LI R3 0x0	;行号清零
PRINT:	
	LI R0 0xFF
	SLL R0 R0 0x0	;显存起始地址
	SLL R1 R3 0x4	;行号 * 16
	ADDU R0 R1 R0
	ADDU R0 R4 R0	;偏移量 = 行号 * 16 + 列好
	ADDIU R4 0x1	;列号+1
	SW R0 R2 0x0
B START		;返回起始
NOP
JR R7
NOP
