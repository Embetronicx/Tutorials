opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F877A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 3 "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	psect config,class=CONFIG,delta=2 ;#
# 3 "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	dw 0xFFFE & 0xFFFB & 0xFFFF & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_lcd_init
	FNCALL	_main,_keyinit
	FNCALL	_main,_cmd
	FNCALL	_main,_show
	FNCALL	_main,_key
	FNCALL	_main,_dat
	FNCALL	_show,_dat
	FNCALL	_lcd_init,_cmd
	FNCALL	_dat,_lcd_delay
	FNCALL	_cmd,_lcd_delay
	FNROOT	_main
	global	_keypad
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	27

;initializer for _keypad
	retlw	037h
	retlw	038h
	retlw	039h
	retlw	02Fh
	retlw	034h
	retlw	035h
	retlw	036h
	retlw	02Ah
	retlw	031h
	retlw	032h
	retlw	033h
	retlw	02Dh
	retlw	043h
	retlw	030h
	retlw	03Dh
	retlw	02Bh
	global	_colloc
	global	_rowloc
	global	_PORTB
_PORTB	set	6
	global	_PORTD
_PORTD	set	8
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RB0
_RB0	set	48
	global	_RB1
_RB1	set	49
	global	_RB2
_RB2	set	50
	global	_RB3
_RB3	set	51
	global	_RB4
_RB4	set	52
	global	_RB5
_RB5	set	53
	global	_RB6
_RB6	set	54
	global	_RB7
_RB7	set	55
	global	_RD2
_RD2	set	66
	global	_RD3
_RD3	set	67
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_TRISB
_TRISB	set	134
	global	_TRISD
_TRISD	set	136
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	
STR_1:	
	retlw	32	;' '
	retlw	32	;' '
	retlw	69	;'E'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	32	;' '
	retlw	116	;'t'
	retlw	104	;'h'
	retlw	101	;'e'
	retlw	32	;' '
	retlw	75	;'K'
	retlw	101	;'e'
	retlw	121	;'y'
	retlw	32	;' '
	retlw	0
psect	strings
	file	"keypad.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_colloc:
       ds      1

_rowloc:
       ds      1

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
_keypad:
       ds      16

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
global btemp
psect inittext,class=CODE,delta=2
global init_fetch,btemp
;	Called with low address in FSR and high address in W
init_fetch:
	movf btemp,w
	movwf pclath
	movf btemp+1,w
	movwf pc
global init_ram
;Called with:
;	high address of idata address in btemp 
;	low address of idata address in btemp+1 
;	low address of data in FSR
;	high address + 1 of data in btemp-1
init_ram:
	fcall init_fetch
	movwf indf,f
	incf fsr,f
	movf fsr,w
	xorwf btemp-1,w
	btfsc status,2
	retlw 0
	incf btemp+1,f
	btfsc status,2
	incf btemp,f
	goto init_ram
; Initialize objects allocated to BANK0
psect cinit,class=CODE,delta=2
global init_ram, __pidataBANK0
	bcf	status, 7	;select IRP bank0
	movlw low(__pdataBANK0+16)
	movwf btemp-1,f
	movlw high(__pidataBANK0)
	movwf btemp,f
	movlw low(__pidataBANK0)
	movwf btemp+1,f
	movlw low(__pdataBANK0)
	movwf fsr,f
	fcall init_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_lcd_init
?_lcd_init:	; 0 bytes @ 0x0
	global	?_keyinit
?_keyinit:	; 0 bytes @ 0x0
	global	??_keyinit
??_keyinit:	; 0 bytes @ 0x0
	global	?_cmd
?_cmd:	; 0 bytes @ 0x0
	global	?_show
?_show:	; 0 bytes @ 0x0
	global	??_key
??_key:	; 0 bytes @ 0x0
	global	?_dat
?_dat:	; 0 bytes @ 0x0
	global	?_lcd_delay
?_lcd_delay:	; 0 bytes @ 0x0
	global	??_lcd_delay
??_lcd_delay:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_key
?_key:	; 1 bytes @ 0x0
	global	lcd_delay@lcd_delay
lcd_delay@lcd_delay:	; 2 bytes @ 0x0
	ds	2
	global	??_cmd
??_cmd:	; 0 bytes @ 0x2
	global	??_dat
??_dat:	; 0 bytes @ 0x2
	ds	2
	global	cmd@a
cmd@a:	; 1 bytes @ 0x4
	global	dat@b
dat@b:	; 1 bytes @ 0x4
	ds	1
	global	??_lcd_init
??_lcd_init:	; 0 bytes @ 0x5
	global	??_show
??_show:	; 0 bytes @ 0x5
	ds	1
	global	show@s
show@s:	; 1 bytes @ 0x6
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x7
	ds	1
	global	main@b
main@b:	; 1 bytes @ 0x8
	ds	1
;;Data sizes: Strings 17, constant 0, data 16, bss 2, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      9      11
;; BANK0           80      0      16
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; show@s	PTR unsigned char  size(1) Largest target is 17
;;		 -> STR_1(CODE[17]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_show
;;   _show->_dat
;;   _lcd_init->_cmd
;;   _dat->_lcd_delay
;;   _cmd->_lcd_delay
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 4     4      0     285
;;                                              7 COMMON     2     2      0
;;                           _lcd_init
;;                            _keyinit
;;                                _cmd
;;                               _show
;;                                _key
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _show                                                 2     2      0      90
;;                                              5 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             0     0      0      60
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _dat                                                  3     3      0      60
;;                                              2 COMMON     3     3      0
;;                          _lcd_delay
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  3     3      0      60
;;                                              2 COMMON     3     3      0
;;                          _lcd_delay
;; ---------------------------------------------------------------------------------
;; (2) _lcd_delay                                            2     2      0      30
;;                                              0 COMMON     2     2      0
;; ---------------------------------------------------------------------------------
;; (1) _key                                                  3     3      0       0
;;                                              0 COMMON     3     3      0
;; ---------------------------------------------------------------------------------
;; (1) _keyinit                                              1     1      0       0
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_init
;;     _cmd
;;       _lcd_delay
;;   _keyinit
;;   _cmd
;;     _lcd_delay
;;   _show
;;     _dat
;;       _lcd_delay
;;   _key
;;   _dat
;;     _lcd_delay
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      1E      12        0.0%
;;ABS                  0      0      1B       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       3       2        0.0%
;;BANK0               50      0      10       5       20.0%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      9       B       1       78.6%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 31 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2    0        unsigned int 
;;  b               1    8[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_lcd_init
;;		_keyinit
;;		_cmd
;;		_show
;;		_key
;;		_dat
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	31
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 5
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	33
	
l2817:	
;key.c: 32: unsigned int i;
;key.c: 33: TRISD=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	line	34
	
l2819:	
;key.c: 34: lcd_init();
	fcall	_lcd_init
	line	35
	
l2821:	
;key.c: 35: keyinit();
	fcall	_keyinit
	line	37
	
l2823:	
;key.c: 36: unsigned char b;
;key.c: 37: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	38
	
l2825:	
;key.c: 38: show("  Enter the Key ");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	goto	l2827
	line	39
;key.c: 39: while(1)
	
l705:	
	line	41
	
l2827:	
;key.c: 40: {
;key.c: 41: cmd(0xc7);
	movlw	(0C7h)
	fcall	_cmd
	line	42
	
l2829:	
;key.c: 42: b=key();
	fcall	_key
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(main@b)
	line	43
	
l2831:	
;key.c: 43: dat(b);
	movf	(main@b),w
	fcall	_dat
	goto	l2827
	line	45
	
l706:	
	line	39
	goto	l2827
	
l707:	
	line	46
	
l708:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_show
psect	text131,local,class=CODE,delta=2
global __ptext131
__ptext131:

;; *************** function _show *****************
;; Defined at:
;;		line 92 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_1(17), 
;; Auto vars:     Size  Location     Type
;;  s               1    6[COMMON] PTR unsigned char 
;;		 -> STR_1(17), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_dat
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text131
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	92
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 5
; Regs used in _show: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	93
	
l2809:	
;key.c: 93: while(*s) {
	goto	l2815
	
l721:	
	line	94
	
l2811:	
;key.c: 94: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
l2813:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	l2815
	line	95
	
l720:	
	line	93
	
l2815:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2741
	goto	u2740
u2741:
	goto	l2811
u2740:
	goto	l723
	
l722:	
	line	96
	
l723:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	_lcd_init
psect	text132,local,class=CODE,delta=2
global __ptext132
__ptext132:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 49 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_cmd
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text132
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	49
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 5
; Regs used in _lcd_init: [wreg+status,2+status,0+pclath+cstack]
	line	50
	
l2807:	
;key.c: 50: cmd(0x02);
	movlw	(02h)
	fcall	_cmd
	line	51
;key.c: 51: cmd(0x28);
	movlw	(028h)
	fcall	_cmd
	line	52
;key.c: 52: cmd(0x0e);
	movlw	(0Eh)
	fcall	_cmd
	line	53
;key.c: 53: cmd(0x06);
	movlw	(06h)
	fcall	_cmd
	line	54
;key.c: 54: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	55
	
l711:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_dat
psect	text133,local,class=CODE,delta=2
global __ptext133
__ptext133:

;; *************** function _dat *****************
;; Defined at:
;;		line 75 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;  b               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  b               1    4[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_lcd_delay
;; This function is called by:
;;		_main
;;		_show
;; This function uses a non-reentrant model
;;
psect	text133
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	75
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 6
; Regs used in _dat: [wreg+status,2+status,0+pclath+cstack]
;dat@b stored from wreg
	movwf	(dat@b)
	line	76
	
l2787:	
;key.c: 76: RD2=1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(66/8),(66)&7
	line	77
	
l2789:	
;key.c: 77: PORTD&=0x0F;
	movlw	(0Fh)
	movwf	(??_dat+0)+0
	movf	(??_dat+0)+0,w
	andwf	(8),f	;volatile
	line	78
;key.c: 78: PORTD|=(b&0xf0);
	movf	(dat@b),w
	andlw	0F0h
	movwf	(??_dat+0)+0
	movf	(??_dat+0)+0,w
	iorwf	(8),f	;volatile
	line	79
	
l2791:	
;key.c: 79: RD3=1;
	bsf	(67/8),(67)&7
	line	80
	
l2793:	
;key.c: 80: lcd_delay();
	fcall	_lcd_delay
	line	81
	
l2795:	
;key.c: 81: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	82
	
l2797:	
;key.c: 82: lcd_delay();
	fcall	_lcd_delay
	line	83
;key.c: 83: PORTD&=0x0f;
	movlw	(0Fh)
	movwf	(??_dat+0)+0
	movf	(??_dat+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(8),f	;volatile
	line	84
;key.c: 84: PORTD|=(b<<4&0xf0);
	movf	(dat@b),w
	movwf	(??_dat+0)+0
	movlw	(04h)-1
u2735:
	clrc
	rlf	(??_dat+0)+0,f
	addlw	-1
	skipz
	goto	u2735
	clrc
	rlf	(??_dat+0)+0,w
	andlw	0F0h
	movwf	(??_dat+1)+0
	movf	(??_dat+1)+0,w
	iorwf	(8),f	;volatile
	line	85
	
l2799:	
;key.c: 85: RD3=1;
	bsf	(67/8),(67)&7
	line	86
	
l2801:	
;key.c: 86: lcd_delay();
	fcall	_lcd_delay
	line	87
	
l2803:	
;key.c: 87: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	88
	
l2805:	
;key.c: 88: lcd_delay();
	fcall	_lcd_delay
	line	89
	
l717:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
	global	_cmd
psect	text134,local,class=CODE,delta=2
global __ptext134
__ptext134:

;; *************** function _cmd *****************
;; Defined at:
;;		line 58 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;  a               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  a               1    4[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_lcd_delay
;; This function is called by:
;;		_main
;;		_lcd_init
;; This function uses a non-reentrant model
;;
psect	text134
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	58
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 6
; Regs used in _cmd: [wreg+status,2+status,0+pclath+cstack]
;cmd@a stored from wreg
	movwf	(cmd@a)
	line	59
	
l2767:	
;key.c: 59: RD2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(66/8),(66)&7
	line	60
	
l2769:	
;key.c: 60: PORTD&=0x0F;
	movlw	(0Fh)
	movwf	(??_cmd+0)+0
	movf	(??_cmd+0)+0,w
	andwf	(8),f	;volatile
	line	61
;key.c: 61: PORTD|=(a&0xf0);
	movf	(cmd@a),w
	andlw	0F0h
	movwf	(??_cmd+0)+0
	movf	(??_cmd+0)+0,w
	iorwf	(8),f	;volatile
	line	62
	
l2771:	
;key.c: 62: RD3=1;
	bsf	(67/8),(67)&7
	line	63
	
l2773:	
;key.c: 63: lcd_delay();
	fcall	_lcd_delay
	line	64
	
l2775:	
;key.c: 64: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	65
	
l2777:	
;key.c: 65: lcd_delay();
	fcall	_lcd_delay
	line	66
;key.c: 66: PORTD&=0x0f;
	movlw	(0Fh)
	movwf	(??_cmd+0)+0
	movf	(??_cmd+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(8),f	;volatile
	line	67
;key.c: 67: PORTD|=(a<<4&0xf0);
	movf	(cmd@a),w
	movwf	(??_cmd+0)+0
	movlw	(04h)-1
u2725:
	clrc
	rlf	(??_cmd+0)+0,f
	addlw	-1
	skipz
	goto	u2725
	clrc
	rlf	(??_cmd+0)+0,w
	andlw	0F0h
	movwf	(??_cmd+1)+0
	movf	(??_cmd+1)+0,w
	iorwf	(8),f	;volatile
	line	68
	
l2779:	
;key.c: 68: RD3=1;
	bsf	(67/8),(67)&7
	line	69
	
l2781:	
;key.c: 69: lcd_delay();
	fcall	_lcd_delay
	line	70
	
l2783:	
;key.c: 70: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	71
	
l2785:	
;key.c: 71: lcd_delay();
	fcall	_lcd_delay
	line	72
	
l714:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
	global	_lcd_delay
psect	text135,local,class=CODE,delta=2
global __ptext135
__ptext135:

;; *************** function _lcd_delay *****************
;; Defined at:
;;		line 99 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  lcd_delay       2    0[COMMON] unsigned int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_cmd
;;		_dat
;; This function uses a non-reentrant model
;;
psect	text135
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	99
	global	__size_of_lcd_delay
	__size_of_lcd_delay	equ	__end_of_lcd_delay-_lcd_delay
	
_lcd_delay:	
	opt	stack 6
; Regs used in _lcd_delay: [wreg+status,2]
	line	101
	
l1901:	
;key.c: 100: unsigned int lcd_delay;
;key.c: 101: for(lcd_delay=0;lcd_delay<=1000;lcd_delay++);
	clrf	(lcd_delay@lcd_delay)
	clrf	(lcd_delay@lcd_delay+1)
	
l1903:	
	movlw	high(03E9h)
	subwf	(lcd_delay@lcd_delay+1),w
	movlw	low(03E9h)
	skipnz
	subwf	(lcd_delay@lcd_delay),w
	skipc
	goto	u491
	goto	u490
u491:
	goto	l1907
u490:
	goto	l728
	
l1905:	
	goto	l728
	
l726:	
	
l1907:	
	movlw	low(01h)
	addwf	(lcd_delay@lcd_delay),f
	skipnc
	incf	(lcd_delay@lcd_delay+1),f
	movlw	high(01h)
	addwf	(lcd_delay@lcd_delay+1),f
	movlw	high(03E9h)
	subwf	(lcd_delay@lcd_delay+1),w
	movlw	low(03E9h)
	skipnz
	subwf	(lcd_delay@lcd_delay),w
	skipc
	goto	u501
	goto	u500
u501:
	goto	l1907
u500:
	goto	l728
	
l727:	
	line	102
	
l728:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_delay
	__end_of_lcd_delay:
;; =============== function _lcd_delay ends ============

	signat	_lcd_delay,88
	global	_key
psect	text136,local,class=CODE,delta=2
global __ptext136
__ptext136:

;; *************** function _key *****************
;; Defined at:
;;		line 111 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          3       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text136
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	111
	global	__size_of_key
	__size_of_key	equ	__end_of_key-_key
	
_key:	
	opt	stack 7
; Regs used in _key: [wreg-fsr0h+status,2+status,0]
	line	112
	
l1815:	
;key.c: 112: PORTB=0X00;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(6)	;volatile
	line	113
;key.c: 113: while(RB4&&RB5&&RB6&&RB7);
	goto	l734
	
l735:	
	
l734:	
	btfss	(52/8),(52)&7
	goto	u11
	goto	u10
u11:
	goto	l739
u10:
	
l1817:	
	btfss	(53/8),(53)&7
	goto	u21
	goto	u20
u21:
	goto	l739
u20:
	
l1819:	
	btfss	(54/8),(54)&7
	goto	u31
	goto	u30
u31:
	goto	l739
u30:
	
l1821:	
	btfsc	(55/8),(55)&7
	goto	u41
	goto	u40
u41:
	goto	l734
u40:
	goto	l739
	
l737:	
	goto	l739
	
l738:	
	line	114
;key.c: 114: while(!RB4||!RB5||!RB6||!RB7) {
	goto	l739
	
l740:	
	line	115
;key.c: 115: RB0=0;
	bcf	(48/8),(48)&7
	line	116
;key.c: 116: RB1=RB2=RB3=1;
	bsf	(51/8),(51)&7
	btfsc	(51/8),(51)&7
	goto	u51
	goto	u50
	
u51:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(50/8),(50)&7
	goto	u64
u50:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(50/8),(50)&7
u64:
	btfsc	(50/8),(50)&7
	goto	u61
	goto	u60
	
u61:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(49/8),(49)&7
	goto	u74
u60:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(49/8),(49)&7
u74:
	line	117
;key.c: 117: if(!RB4||!RB5||!RB6||!RB7) {
	btfss	(52/8),(52)&7
	goto	u81
	goto	u80
u81:
	goto	l743
u80:
	
l1823:	
	btfss	(53/8),(53)&7
	goto	u91
	goto	u90
u91:
	goto	l743
u90:
	
l1825:	
	btfss	(54/8),(54)&7
	goto	u101
	goto	u100
u101:
	goto	l743
u100:
	
l1827:	
	btfsc	(55/8),(55)&7
	goto	u111
	goto	u110
u111:
	goto	l741
u110:
	
l743:	
	line	118
;key.c: 118: rowloc=0;
	clrf	(_rowloc)
	line	119
;key.c: 119: break;
	goto	l744
	line	120
	
l741:	
	line	121
;key.c: 120: }
;key.c: 121: RB1=0;RB0=1;
	bcf	(49/8),(49)&7
	bsf	(48/8),(48)&7
	line	122
;key.c: 122: if(!RB4||!RB5||!RB6||!RB7) {
	btfss	(52/8),(52)&7
	goto	u121
	goto	u120
u121:
	goto	l1835
u120:
	
l1829:	
	btfss	(53/8),(53)&7
	goto	u131
	goto	u130
u131:
	goto	l1835
u130:
	
l1831:	
	btfss	(54/8),(54)&7
	goto	u141
	goto	u140
u141:
	goto	l1835
u140:
	
l1833:	
	btfsc	(55/8),(55)&7
	goto	u151
	goto	u150
u151:
	goto	l745
u150:
	goto	l1835
	
l747:	
	line	123
	
l1835:	
;key.c: 123: rowloc=1;
	clrf	(_rowloc)
	bsf	status,0
	rlf	(_rowloc),f
	line	124
;key.c: 124: break;
	goto	l744
	line	125
	
l745:	
	line	126
;key.c: 125: }
;key.c: 126: RB2=0;RB1=1;
	bcf	(50/8),(50)&7
	bsf	(49/8),(49)&7
	line	127
;key.c: 127: if(!RB4||!RB5||!RB6||!RB7) {
	btfss	(52/8),(52)&7
	goto	u161
	goto	u160
u161:
	goto	l1843
u160:
	
l1837:	
	btfss	(53/8),(53)&7
	goto	u171
	goto	u170
u171:
	goto	l1843
u170:
	
l1839:	
	btfss	(54/8),(54)&7
	goto	u181
	goto	u180
u181:
	goto	l1843
u180:
	
l1841:	
	btfsc	(55/8),(55)&7
	goto	u191
	goto	u190
u191:
	goto	l748
u190:
	goto	l1843
	
l750:	
	line	128
	
l1843:	
;key.c: 128: rowloc=2;
	movlw	(02h)
	movwf	(??_key+0)+0
	movf	(??_key+0)+0,w
	movwf	(_rowloc)
	line	129
;key.c: 129: break;
	goto	l744
	line	130
	
l748:	
	line	131
;key.c: 130: }
;key.c: 131: RB3=0; RB2=1;
	bcf	(51/8),(51)&7
	bsf	(50/8),(50)&7
	line	132
;key.c: 132: if(!RB4||!RB5||!RB6||!RB7){
	btfss	(52/8),(52)&7
	goto	u201
	goto	u200
u201:
	goto	l1851
u200:
	
l1845:	
	btfss	(53/8),(53)&7
	goto	u211
	goto	u210
u211:
	goto	l1851
u210:
	
l1847:	
	btfss	(54/8),(54)&7
	goto	u221
	goto	u220
u221:
	goto	l1851
u220:
	
l1849:	
	btfsc	(55/8),(55)&7
	goto	u231
	goto	u230
u231:
	goto	l739
u230:
	goto	l1851
	
l753:	
	line	133
	
l1851:	
;key.c: 133: rowloc=3;
	movlw	(03h)
	movwf	(??_key+0)+0
	movf	(??_key+0)+0,w
	movwf	(_rowloc)
	line	134
;key.c: 134: break;
	goto	l744
	line	135
	
l751:	
	line	136
	
l739:	
	line	114
	btfss	(52/8),(52)&7
	goto	u241
	goto	u240
u241:
	goto	l740
u240:
	
l1853:	
	btfss	(53/8),(53)&7
	goto	u251
	goto	u250
u251:
	goto	l740
u250:
	
l1855:	
	btfss	(54/8),(54)&7
	goto	u261
	goto	u260
u261:
	goto	l740
u260:
	
l1857:	
	btfss	(55/8),(55)&7
	goto	u271
	goto	u270
u271:
	goto	l740
u270:
	
l744:	
	line	137
;key.c: 135: }
;key.c: 136: }
;key.c: 137: if(RB4==0&&RB5!=0&&RB6!=0&&RB7!=0)
	btfsc	(52/8),(52)&7
	goto	u281
	goto	u280
u281:
	goto	l754
u280:
	
l1859:	
	btfss	(53/8),(53)&7
	goto	u291
	goto	u290
u291:
	goto	l754
u290:
	
l1861:	
	btfss	(54/8),(54)&7
	goto	u301
	goto	u300
u301:
	goto	l754
u300:
	
l1863:	
	btfss	(55/8),(55)&7
	goto	u311
	goto	u310
u311:
	goto	l754
u310:
	line	138
	
l1865:	
;key.c: 138: colloc=0;
	clrf	(_colloc)
	goto	l761
	line	139
	
l754:	
;key.c: 139: else if(RB4!=0&&RB5==0&&RB6!=0&&RB7!=0)
	btfss	(52/8),(52)&7
	goto	u321
	goto	u320
u321:
	goto	l756
u320:
	
l1867:	
	btfsc	(53/8),(53)&7
	goto	u331
	goto	u330
u331:
	goto	l756
u330:
	
l1869:	
	btfss	(54/8),(54)&7
	goto	u341
	goto	u340
u341:
	goto	l756
u340:
	
l1871:	
	btfss	(55/8),(55)&7
	goto	u351
	goto	u350
u351:
	goto	l756
u350:
	line	140
	
l1873:	
;key.c: 140: colloc=1;
	clrf	(_colloc)
	bsf	status,0
	rlf	(_colloc),f
	goto	l761
	line	141
	
l756:	
;key.c: 141: else if(RB4!=0&&RB5!=0&&RB6==0&&RB7!=0)
	btfss	(52/8),(52)&7
	goto	u361
	goto	u360
u361:
	goto	l758
u360:
	
l1875:	
	btfss	(53/8),(53)&7
	goto	u371
	goto	u370
u371:
	goto	l758
u370:
	
l1877:	
	btfsc	(54/8),(54)&7
	goto	u381
	goto	u380
u381:
	goto	l758
u380:
	
l1879:	
	btfss	(55/8),(55)&7
	goto	u391
	goto	u390
u391:
	goto	l758
u390:
	line	142
	
l1881:	
;key.c: 142: colloc=2;
	movlw	(02h)
	movwf	(??_key+0)+0
	movf	(??_key+0)+0,w
	movwf	(_colloc)
	goto	l761
	line	143
	
l758:	
;key.c: 143: else if(RB4!=0&&RB5!=0&&RB6!=0&&RB7==0)
	btfss	(52/8),(52)&7
	goto	u401
	goto	u400
u401:
	goto	l761
u400:
	
l1883:	
	btfss	(53/8),(53)&7
	goto	u411
	goto	u410
u411:
	goto	l761
u410:
	
l1885:	
	btfss	(54/8),(54)&7
	goto	u421
	goto	u420
u421:
	goto	l761
u420:
	
l1887:	
	btfsc	(55/8),(55)&7
	goto	u431
	goto	u430
u431:
	goto	l761
u430:
	line	144
	
l1889:	
;key.c: 144: colloc=3;
	movlw	(03h)
	movwf	(??_key+0)+0
	movf	(??_key+0)+0,w
	movwf	(_colloc)
	goto	l761
	
l760:	
	goto	l761
	line	145
	
l759:	
	goto	l761
	
l757:	
	goto	l761
	
l755:	
;key.c: 145: while(RB4==0||RB5==0||RB6==0||RB7==0);
	goto	l761
	
l762:	
	
l761:	
	btfss	(52/8),(52)&7
	goto	u441
	goto	u440
u441:
	goto	l761
u440:
	
l1891:	
	btfss	(53/8),(53)&7
	goto	u451
	goto	u450
u451:
	goto	l761
u450:
	
l1893:	
	btfss	(54/8),(54)&7
	goto	u461
	goto	u460
u461:
	goto	l761
u460:
	
l1895:	
	btfss	(55/8),(55)&7
	goto	u471
	goto	u470
u471:
	goto	l761
u470:
	goto	l1897
	
l763:	
	line	146
	
l1897:	
;key.c: 146: return (keypad[rowloc][colloc]);
	movf	(_rowloc),w
	movwf	(??_key+0)+0
	movlw	02h
u485:
	clrc
	rlf	(??_key+0)+0,f
	addlw	-1
	skipz
	goto	u485
	movlw	(_keypad)&0ffh
	addwf	0+(??_key+0)+0,w
	movwf	(??_key+1)+0
	movf	(_colloc),w
	addwf	0+(??_key+1)+0,w
	movwf	(??_key+2)+0
	movf	0+(??_key+2)+0,w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	goto	l764
	
l1899:	
	line	147
	
l764:	
	return
	opt stack 0
GLOBAL	__end_of_key
	__end_of_key:
;; =============== function _key ends ============

	signat	_key,89
	global	_keyinit
psect	text137,local,class=CODE,delta=2
global __ptext137
__ptext137:

;; *************** function _keyinit *****************
;; Defined at:
;;		line 105 in file "D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text137
	file	"D:\SLR\Interlogicx\codes\Others\PIC\PIC16F pgms\KEYPAD\key.c"
	line	105
	global	__size_of_keyinit
	__size_of_keyinit	equ	__end_of_keyinit-_keyinit
	
_keyinit:	
	opt	stack 7
; Regs used in _keyinit: [wreg+status,2+status,0]
	line	106
	
l1811:	
;key.c: 106: TRISB=0XF0;
	movlw	(0F0h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(134)^080h	;volatile
	line	107
	
l1813:	
;key.c: 107: OPTION_REG&=0X7F;
	movlw	(07Fh)
	movwf	(??_keyinit+0)+0
	movf	(??_keyinit+0)+0,w
	andwf	(129)^080h,f	;volatile
	line	108
	
l731:	
	return
	opt stack 0
GLOBAL	__end_of_keyinit
	__end_of_keyinit:
;; =============== function _keyinit ends ============

	signat	_keyinit,88
psect	text138,local,class=CODE,delta=2
global __ptext138
__ptext138:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
