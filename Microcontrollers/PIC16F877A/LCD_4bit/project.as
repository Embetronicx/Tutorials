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
# 3 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	psect config,class=CONFIG,delta=2 ;#
# 3 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	dw 0xFFFE & 0xFFFB & 0xFFFF & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_lcd_init
	FNCALL	_main,_cmd
	FNCALL	_main,_show
	FNCALL	_show,_dat
	FNCALL	_lcd_init,_cmd
	FNCALL	_dat,_lcd_delay
	FNCALL	_cmd,_lcd_delay
	FNROOT	_main
	global	_PORTB
psect	text106,local,class=CODE,delta=2
global __ptext106
__ptext106:
_PORTB	set	6
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RD2
_RD2	set	66
	global	_RD3
_RD3	set	67
	global	_TRISB
_TRISB	set	134
	global	_TRISD2
_TRISD2	set	1090
	global	_TRISD3
_TRISD3	set	1091
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
	retlw	119	;'w'
	retlw	119	;'w'
	retlw	119	;'w'
	retlw	46	;'.'
	retlw	69	;'E'
	retlw	109	;'m'
	retlw	98	;'b'
	retlw	101	;'e'
	retlw	84	;'T'
	retlw	114	;'r'
	retlw	111	;'o'
	retlw	110	;'n'
	retlw	105	;'i'
	retlw	99	;'c'
	retlw	88	;'X'
	retlw	46	;'.'
	retlw	99	;'c'
	retlw	111	;'o'
	retlw	109	;'m'
	retlw	0
psect	strings
	file	"project.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

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
	global	?_cmd
?_cmd:	; 0 bytes @ 0x0
	global	?_show
?_show:	; 0 bytes @ 0x0
	global	?_lcd_delay
?_lcd_delay:	; 0 bytes @ 0x0
	global	??_lcd_delay
??_lcd_delay:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_dat
?_dat:	; 0 bytes @ 0x0
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
	global	main@i
main@i:	; 2 bytes @ 0x7
	ds	2
;;Data sizes: Strings 20, constant 0, data 0, bss 0, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      9       9
;; BANK0           80      0       0
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; show@s	PTR unsigned char  size(1) Largest target is 20
;;		 -> STR_1(CODE[20]), 
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
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 2     2      0     270
;;                                              7 COMMON     2     2      0
;;                           _lcd_init
;;                                _cmd
;;                               _show
;; ---------------------------------------------------------------------------------
;; (1) _show                                                 2     2      0      90
;;                                              5 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             0     0      0      60
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (2) _dat                                                  3     3      0      60
;;                                              2 COMMON     3     3      0
;;                          _lcd_delay
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  3     3      0      60
;;                                              2 COMMON     3     3      0
;;                          _lcd_delay
;; ---------------------------------------------------------------------------------
;; (3) _lcd_delay                                            2     2      0      30
;;                                              0 COMMON     2     2      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 3
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_init
;;     _cmd
;;       _lcd_delay
;;   _cmd
;;     _lcd_delay
;;   _show
;;     _dat
;;       _lcd_delay
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      9       9       1       64.3%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       3       2        0.0%
;;ABS                  0      0       0       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0       0      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 16 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2    7[COMMON] unsigned int 
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
;;      Locals:         2       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_lcd_init
;;		_cmd
;;		_show
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	line	16
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 5
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	18
	
l2683:	
;LCD4BIT.C: 17: unsigned int i;
;LCD4BIT.C: 18: TRISB=TRISD2=TRISD3=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1091/8)^080h,(1091)&7
	bcf	(1090/8)^080h,(1090)&7
	movlw	0
	btfsc	(1090/8)^080h,(1090)&7
	movlw	1
	movwf	(134)^080h	;volatile
	line	19
	
l2685:	
;LCD4BIT.C: 19: lcd_init();
	fcall	_lcd_init
	line	20
	
l2687:	
;LCD4BIT.C: 20: cmd(0x90);
	movlw	(090h)
	fcall	_cmd
	line	21
	
l2689:	
;LCD4BIT.C: 21: show("www.EmbeTronicX.com");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	goto	l2691
	line	22
;LCD4BIT.C: 22: while(1)
	
l693:	
	line	24
	
l2691:	
;LCD4BIT.C: 23: {
;LCD4BIT.C: 24: for(i=0;i<15000;i++);
	clrf	(main@i)
	clrf	(main@i+1)
	
l2693:	
	movlw	high(03A98h)
	subwf	(main@i+1),w
	movlw	low(03A98h)
	skipnz
	subwf	(main@i),w
	skipc
	goto	u2271
	goto	u2270
u2271:
	goto	l2697
u2270:
	goto	l2699
	
l2695:	
	goto	l2699
	
l694:	
	
l2697:	
	movlw	low(01h)
	addwf	(main@i),f
	skipnc
	incf	(main@i+1),f
	movlw	high(01h)
	addwf	(main@i+1),f
	movlw	high(03A98h)
	subwf	(main@i+1),w
	movlw	low(03A98h)
	skipnz
	subwf	(main@i),w
	skipc
	goto	u2281
	goto	u2280
u2281:
	goto	l2697
u2280:
	goto	l2699
	
l695:	
	line	25
	
l2699:	
;LCD4BIT.C: 25: cmd(0x18);
	movlw	(018h)
	fcall	_cmd
	line	26
	
l2701:	
;LCD4BIT.C: 26: for(i=0;i<15000;i++);
	clrf	(main@i)
	clrf	(main@i+1)
	
l2703:	
	movlw	high(03A98h)
	subwf	(main@i+1),w
	movlw	low(03A98h)
	skipnz
	subwf	(main@i),w
	skipc
	goto	u2291
	goto	u2290
u2291:
	goto	l2707
u2290:
	goto	l2691
	
l2705:	
	goto	l2691
	
l696:	
	
l2707:	
	movlw	low(01h)
	addwf	(main@i),f
	skipnc
	incf	(main@i+1),f
	movlw	high(01h)
	addwf	(main@i+1),f
	movlw	high(03A98h)
	subwf	(main@i+1),w
	movlw	low(03A98h)
	skipnz
	subwf	(main@i),w
	skipc
	goto	u2301
	goto	u2300
u2301:
	goto	l2707
u2300:
	goto	l2691
	
l697:	
	goto	l2691
	line	28
	
l698:	
	line	22
	goto	l2691
	
l699:	
	line	29
	
l700:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_show
psect	text107,local,class=CODE,delta=2
global __ptext107
__ptext107:

;; *************** function _show *****************
;; Defined at:
;;		line 75 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_1(20), 
;; Auto vars:     Size  Location     Type
;;  s               1    6[COMMON] PTR unsigned char 
;;		 -> STR_1(20), 
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
psect	text107
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	line	75
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 5
; Regs used in _show: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	76
	
l2675:	
;LCD4BIT.C: 76: while(*s) {
	goto	l2681
	
l713:	
	line	77
	
l2677:	
;LCD4BIT.C: 77: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
l2679:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	l2681
	line	78
	
l712:	
	line	76
	
l2681:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2261
	goto	u2260
u2261:
	goto	l2677
u2260:
	goto	l715
	
l714:	
	line	79
	
l715:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	_lcd_init
psect	text108,local,class=CODE,delta=2
global __ptext108
__ptext108:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 32 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
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
psect	text108
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	line	32
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 5
; Regs used in _lcd_init: [wreg+status,2+status,0+pclath+cstack]
	line	33
	
l2673:	
;LCD4BIT.C: 33: cmd(0x02);
	movlw	(02h)
	fcall	_cmd
	line	34
;LCD4BIT.C: 34: cmd(0x28);
	movlw	(028h)
	fcall	_cmd
	line	35
;LCD4BIT.C: 35: cmd(0x0e);
	movlw	(0Eh)
	fcall	_cmd
	line	36
;LCD4BIT.C: 36: cmd(0x06);
	movlw	(06h)
	fcall	_cmd
	line	37
;LCD4BIT.C: 37: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	38
	
l703:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_dat
psect	text109,local,class=CODE,delta=2
global __ptext109
__ptext109:

;; *************** function _dat *****************
;; Defined at:
;;		line 58 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
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
;;		_show
;; This function uses a non-reentrant model
;;
psect	text109
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	line	58
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 5
; Regs used in _dat: [wreg+status,2+status,0+pclath+cstack]
;dat@b stored from wreg
	movwf	(dat@b)
	line	59
	
l2653:	
;LCD4BIT.C: 59: RD2=1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(66/8),(66)&7
	line	60
	
l2655:	
;LCD4BIT.C: 60: PORTB&=0x0F;
	movlw	(0Fh)
	movwf	(??_dat+0)+0
	movf	(??_dat+0)+0,w
	andwf	(6),f	;volatile
	line	61
;LCD4BIT.C: 61: PORTB|=(b&0xf0);
	movf	(dat@b),w
	andlw	0F0h
	movwf	(??_dat+0)+0
	movf	(??_dat+0)+0,w
	iorwf	(6),f	;volatile
	line	62
	
l2657:	
;LCD4BIT.C: 62: RD3=1;
	bsf	(67/8),(67)&7
	line	63
	
l2659:	
;LCD4BIT.C: 63: lcd_delay();
	fcall	_lcd_delay
	line	64
	
l2661:	
;LCD4BIT.C: 64: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	65
	
l2663:	
;LCD4BIT.C: 65: lcd_delay();
	fcall	_lcd_delay
	line	66
;LCD4BIT.C: 66: PORTB&=0x0f;
	movlw	(0Fh)
	movwf	(??_dat+0)+0
	movf	(??_dat+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	67
;LCD4BIT.C: 67: PORTB|=(b<<4&0xf0);
	movf	(dat@b),w
	movwf	(??_dat+0)+0
	movlw	(04h)-1
u2255:
	clrc
	rlf	(??_dat+0)+0,f
	addlw	-1
	skipz
	goto	u2255
	clrc
	rlf	(??_dat+0)+0,w
	andlw	0F0h
	movwf	(??_dat+1)+0
	movf	(??_dat+1)+0,w
	iorwf	(6),f	;volatile
	line	68
	
l2665:	
;LCD4BIT.C: 68: RD3=1;
	bsf	(67/8),(67)&7
	line	69
	
l2667:	
;LCD4BIT.C: 69: lcd_delay();
	fcall	_lcd_delay
	line	70
	
l2669:	
;LCD4BIT.C: 70: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	71
	
l2671:	
;LCD4BIT.C: 71: lcd_delay();
	fcall	_lcd_delay
	line	72
	
l709:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
	global	_cmd
psect	text110,local,class=CODE,delta=2
global __ptext110
__ptext110:

;; *************** function _cmd *****************
;; Defined at:
;;		line 41 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
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
psect	text110
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	line	41
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 6
; Regs used in _cmd: [wreg+status,2+status,0+pclath+cstack]
;cmd@a stored from wreg
	movwf	(cmd@a)
	line	42
	
l2633:	
;LCD4BIT.C: 42: RD2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(66/8),(66)&7
	line	43
	
l2635:	
;LCD4BIT.C: 43: PORTB&=0x0F;
	movlw	(0Fh)
	movwf	(??_cmd+0)+0
	movf	(??_cmd+0)+0,w
	andwf	(6),f	;volatile
	line	44
;LCD4BIT.C: 44: PORTB|=(a&0xf0);
	movf	(cmd@a),w
	andlw	0F0h
	movwf	(??_cmd+0)+0
	movf	(??_cmd+0)+0,w
	iorwf	(6),f	;volatile
	line	45
	
l2637:	
;LCD4BIT.C: 45: RD3=1;
	bsf	(67/8),(67)&7
	line	46
	
l2639:	
;LCD4BIT.C: 46: lcd_delay();
	fcall	_lcd_delay
	line	47
	
l2641:	
;LCD4BIT.C: 47: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	48
	
l2643:	
;LCD4BIT.C: 48: lcd_delay();
	fcall	_lcd_delay
	line	49
;LCD4BIT.C: 49: PORTB&=0x0f;
	movlw	(0Fh)
	movwf	(??_cmd+0)+0
	movf	(??_cmd+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	andwf	(6),f	;volatile
	line	50
;LCD4BIT.C: 50: PORTB|=(a<<4&0xf0);
	movf	(cmd@a),w
	movwf	(??_cmd+0)+0
	movlw	(04h)-1
u2245:
	clrc
	rlf	(??_cmd+0)+0,f
	addlw	-1
	skipz
	goto	u2245
	clrc
	rlf	(??_cmd+0)+0,w
	andlw	0F0h
	movwf	(??_cmd+1)+0
	movf	(??_cmd+1)+0,w
	iorwf	(6),f	;volatile
	line	51
	
l2645:	
;LCD4BIT.C: 51: RD3=1;
	bsf	(67/8),(67)&7
	line	52
	
l2647:	
;LCD4BIT.C: 52: lcd_delay();
	fcall	_lcd_delay
	line	53
	
l2649:	
;LCD4BIT.C: 53: RD3=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
	line	54
	
l2651:	
;LCD4BIT.C: 54: lcd_delay();
	fcall	_lcd_delay
	line	55
	
l706:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
	global	_lcd_delay
psect	text111,local,class=CODE,delta=2
global __ptext111
__ptext111:

;; *************** function _lcd_delay *****************
;; Defined at:
;;		line 82 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
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
psect	text111
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Lcd\LCD4BIT.C"
	line	82
	global	__size_of_lcd_delay
	__size_of_lcd_delay	equ	__end_of_lcd_delay-_lcd_delay
	
_lcd_delay:	
	opt	stack 5
; Regs used in _lcd_delay: [wreg+status,2]
	line	84
	
l1767:	
;LCD4BIT.C: 83: unsigned int lcd_delay;
;LCD4BIT.C: 84: for(lcd_delay=0;lcd_delay<=1000;lcd_delay++);
	clrf	(lcd_delay@lcd_delay)
	clrf	(lcd_delay@lcd_delay+1)
	
l1769:	
	movlw	high(03E9h)
	subwf	(lcd_delay@lcd_delay+1),w
	movlw	low(03E9h)
	skipnz
	subwf	(lcd_delay@lcd_delay),w
	skipc
	goto	u11
	goto	u10
u11:
	goto	l1773
u10:
	goto	l720
	
l1771:	
	goto	l720
	
l718:	
	
l1773:	
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
	goto	u21
	goto	u20
u21:
	goto	l1773
u20:
	goto	l720
	
l719:	
	line	85
	
l720:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_delay
	__end_of_lcd_delay:
;; =============== function _lcd_delay ends ============

	signat	_lcd_delay,88
psect	text112,local,class=CODE,delta=2
global __ptext112
__ptext112:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
