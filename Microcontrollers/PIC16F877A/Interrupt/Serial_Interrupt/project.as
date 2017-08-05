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
# 7 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\code.c"
	psect config,class=CONFIG,delta=2 ;#
# 7 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\code.c"
	dw 0xFFFE & 0xFFFB & 0xFFFF & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_lcd_init
	FNCALL	_main,_serial_init
	FNCALL	_main,_cmd
	FNCALL	_lcd_init,_cmd
	FNROOT	_main
	FNCALL	_ser,_tx
	FNCALL	_ser,i1_cmd
	FNCALL	_ser,_show
	FNCALL	_ser,_dat
	FNCALL	_show,_dat
	FNCALL	intlevel1,_ser
	global	intlevel1
	FNROOT	intlevel1
	global	_i
	global	_z
	global	_INTCON
psect	text257,local,class=CODE,delta=2
global __ptext257
__ptext257:
_INTCON	set	11
	global	_PORTD
_PORTD	set	8
	global	_RCREG
_RCREG	set	26
	global	_RCSTA
_RCSTA	set	24
	global	_TXREG
_TXREG	set	25
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RC0
_RC0	set	56
	global	_RC1
_RC1	set	57
	global	_RC2
_RC2	set	58
	global	_RCIF
_RCIF	set	101
	global	_TXIF
_TXIF	set	100
	global	_PIE1
_PIE1	set	140
	global	_SPBRG
_SPBRG	set	153
	global	_TRISD
_TRISD	set	136
	global	_TXSTA
_TXSTA	set	152
	global	_TRISC0
_TRISC0	set	1080
	global	_TRISC1
_TRISC1	set	1081
	global	_TRISC2
_TRISC2	set	1082
	global	_TRISC6
_TRISC6	set	1086
	global	_TRISC7
_TRISC7	set	1087
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
	retlw	83	;'S'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	105	;'i'
	retlw	97	;'a'
	retlw	108	;'l'
	retlw	32	;' '
	retlw	105	;'i'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	114	;'r'
	retlw	117	;'u'
	retlw	112	;'p'
	retlw	116	;'t'
	retlw	0
psect	strings
	
STR_2:	
	retlw	32	;' '
	retlw	32	;' '
	retlw	75	;'K'
	retlw	101	;'e'
	retlw	121	;'y'
	retlw	32	;' '
	retlw	58	;':'
	retlw	32	;' '
	retlw	0
psect	strings
	file	"project.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_i:
       ds      2

_z:
       ds      2

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_cmd
?_cmd:	; 0 bytes @ 0x0
	global	?_serial_init
?_serial_init:	; 0 bytes @ 0x0
	global	?_tx
?_tx:	; 0 bytes @ 0x0
	global	??_tx
??_tx:	; 0 bytes @ 0x0
	global	?_lcd_init
?_lcd_init:	; 0 bytes @ 0x0
	global	?_dat
?_dat:	; 0 bytes @ 0x0
	global	??_dat
??_dat:	; 0 bytes @ 0x0
	global	?_show
?_show:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_ser
?_ser:	; 0 bytes @ 0x0
	global	?i1_cmd
?i1_cmd:	; 0 bytes @ 0x0
	global	??i1_cmd
??i1_cmd:	; 0 bytes @ 0x0
	global	tx@dat
tx@dat:	; 1 bytes @ 0x0
	global	dat@b
dat@b:	; 1 bytes @ 0x0
	global	i1cmd@a
i1cmd@a:	; 1 bytes @ 0x0
	ds	1
	global	??_show
??_show:	; 0 bytes @ 0x1
	ds	1
	global	show@s
show@s:	; 1 bytes @ 0x2
	ds	1
	global	??_ser
??_ser:	; 0 bytes @ 0x3
	ds	5
	global	ser@a
ser@a:	; 1 bytes @ 0x8
	ds	1
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_cmd
??_cmd:	; 0 bytes @ 0x0
	global	??_serial_init
??_serial_init:	; 0 bytes @ 0x0
	global	cmd@a
cmd@a:	; 1 bytes @ 0x0
	ds	1
	global	??_lcd_init
??_lcd_init:	; 0 bytes @ 0x1
	global	??_main
??_main:	; 0 bytes @ 0x1
	ds	1
;;Data sizes: Strings 26, constant 0, data 0, bss 4, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      9      13
;; BANK0           80      2       2
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; show@s	PTR unsigned char  size(1) Largest target is 17
;;		 -> STR_2(CODE[9]), STR_1(CODE[17]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _ser in COMMON
;;
;;   _ser->_show
;;   _show->_dat
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_cmd
;;   _lcd_init->_cmd
;;
;; Critical Paths under _ser in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _ser in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _ser in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _ser in BANK2
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
;; (0) _main                                                 1     1      0      44
;;                                              1 BANK0      1     1      0
;;                           _lcd_init
;;                        _serial_init
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             0     0      0      22
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  1     1      0      22
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (1) _serial_init                                          0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 1
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (3) _ser                                                  6     6      0     193
;;                                              3 COMMON     6     6      0
;;                                 _tx
;;                              i1_cmd
;;                               _show
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (4) _show                                                 2     2      0      45
;;                                              1 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (4) i1_cmd                                                1     1      0      73
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (4) _dat                                                  1     1      0      15
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (4) _tx                                                   1     1      0      15
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 4
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_init
;;     _cmd
;;   _serial_init
;;   _cmd
;;
;; _ser (ROOT)
;;   _tx
;;   i1_cmd
;;   _show
;;     _dat
;;   _dat
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      9       D       1       92.9%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       8       2        0.0%
;;ABS                  0      0       F       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      2       2       5        2.5%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0      17      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 16 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_lcd_init
;;		_serial_init
;;		_cmd
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\code.c"
	line	16
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 3
; Regs used in _main: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	17
	
l2874:	
;code.c: 17: TRISD=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	line	18
	
l2876:	
;code.c: 18: INTCON|=0b11000000;
	movlw	(0C0h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	iorwf	(11),f	;volatile
	line	19
	
l2878:	
;code.c: 19: PIE1=0b00100000;
	movlw	(020h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(140)^080h	;volatile
	line	20
	
l2880:	
;code.c: 20: lcd_init();
	fcall	_lcd_init
	line	21
	
l2882:	
;code.c: 21: serial_init();
	fcall	_serial_init
	goto	l2884
	line	22
;code.c: 22: while(1) {
	
l731:	
	line	23
	
l2884:	
;code.c: 23: cmd(0x01);
	movlw	(01h)
	fcall	_cmd
	goto	l2884
	line	24
	
l732:	
	line	22
	goto	l2884
	
l733:	
	line	25
	
l734:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_lcd_init
psect	text258,local,class=CODE,delta=2
global __ptext258
__ptext258:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 15 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
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
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_cmd
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text258
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
	line	15
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 3
; Regs used in _lcd_init: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	16
	
l2870:	
;lcd.h: 16: TRISC0=TRISC1=TRISC2=TRISD=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	btfsc	((136)^080h),0	;volatile
	goto	u2541
	goto	u2540
	
u2541:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1082/8)^080h,(1082)&7
	goto	u2554
u2540:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1082/8)^080h,(1082)&7
u2554:
	btfsc	(1082/8)^080h,(1082)&7
	goto	u2551
	goto	u2550
	
u2551:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1081/8)^080h,(1081)&7
	goto	u2564
u2550:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1081/8)^080h,(1081)&7
u2564:
	btfsc	(1081/8)^080h,(1081)&7
	goto	u2561
	goto	u2560
	
u2561:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1080/8)^080h,(1080)&7
	goto	u2574
u2560:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1080/8)^080h,(1080)&7
u2574:
	line	17
	
l2872:	
;lcd.h: 17: cmd(0x38);
	movlw	(038h)
	fcall	_cmd
	line	18
;lcd.h: 18: cmd(0x0e);
	movlw	(0Eh)
	fcall	_cmd
	line	19
;lcd.h: 19: cmd(0x06);
	movlw	(06h)
	fcall	_cmd
	line	20
;lcd.h: 20: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	21
	
l712:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_cmd
psect	text259,local,class=CODE,delta=2
global __ptext259
__ptext259:

;; *************** function _cmd *****************
;; Defined at:
;;		line 24 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
;; Parameters:    Size  Location     Type
;;  a               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  a               1    0[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_lcd_init
;;		_main
;; This function uses a non-reentrant model
;;
psect	text259
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
	line	24
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 4
; Regs used in _cmd: [wreg+status,2+btemp+1]
;cmd@a stored from wreg
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(cmd@a)
	line	25
	
l2802:	
;lcd.h: 25: PORTD=a;
	movf	(cmd@a),w
	movwf	(8)	;volatile
	line	26
	
l2804:	
;lcd.h: 26: RC0=0;
	bcf	(56/8),(56)&7
	line	27
	
l2806:	
;lcd.h: 27: RC1=0;
	bcf	(57/8),(57)&7
	line	28
	
l2808:	
;lcd.h: 28: RC2=1;
	bsf	(58/8),(58)&7
	line	29
	
l2810:	
;lcd.h: 29: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l2812:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2465
	movlw	low(03E8h)
	subwf	(_i),w
u2465:

	skipc
	goto	u2461
	goto	u2460
u2461:
	goto	l2816
u2460:
	goto	l716
	
l2814:	
	goto	l716
	
l715:	
	
l2816:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l2818:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2475
	movlw	low(03E8h)
	subwf	(_i),w
u2475:

	skipc
	goto	u2471
	goto	u2470
u2471:
	goto	l2816
u2470:
	
l716:	
	line	30
;lcd.h: 30: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	31
	
l717:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
	global	_serial_init
psect	text260,local,class=CODE,delta=2
global __ptext260
__ptext260:

;; *************** function _serial_init *****************
;; Defined at:
;;		line 7 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\serial.h"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
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
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text260
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\serial.h"
	line	7
	global	__size_of_serial_init
	__size_of_serial_init	equ	__end_of_serial_init-_serial_init
	
_serial_init:	
	opt	stack 4
; Regs used in _serial_init: [wreg]
	line	8
	
l2796:	
;serial.h: 8: TRISC6=TRISC7=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1087/8)^080h,(1087)&7
	btfsc	(1087/8)^080h,(1087)&7
	goto	u2441
	goto	u2440
	
u2441:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1086/8)^080h,(1086)&7
	goto	u2454
u2440:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1086/8)^080h,(1086)&7
u2454:
	line	9
	
l2798:	
;serial.h: 9: TXSTA=0b00100010;
	movlw	(022h)
	movwf	(152)^080h	;volatile
	line	10
;serial.h: 10: RCSTA=0b10010000;
	movlw	(090h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(24)	;volatile
	line	11
;serial.h: 11: SPBRG=17;
	movlw	(011h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(153)^080h	;volatile
	line	12
	
l2800:	
;serial.h: 12: TXIF=RCIF=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(101/8),(101)&7
	bcf	(100/8),(100)&7
	line	13
	
l691:	
	return
	opt stack 0
GLOBAL	__end_of_serial_init
	__end_of_serial_init:
;; =============== function _serial_init ends ============

	signat	_serial_init,88
	global	_ser
psect	text261,local,class=CODE,delta=2
global __ptext261
__ptext261:

;; *************** function _ser *****************
;; Defined at:
;;		line 28 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  a               1    8[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          5       0       0       0       0
;;      Totals:         6       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_tx
;;		i1_cmd
;;		_show
;;		_dat
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text261
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\code.c"
	line	28
	global	__size_of_ser
	__size_of_ser	equ	__end_of_ser-_ser
	
_ser:	
	opt	stack 3
; Regs used in _ser: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_ser+1)
	movf	fsr0,w
	movwf	(??_ser+2)
	movf	pclath,w
	movwf	(??_ser+3)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_ser+4)
	ljmp	_ser
psect	text261
	line	29
	
i1l2820:	
;code.c: 29: unsigned char a = RCREG;
	movf	(26),w	;volatile
	movwf	(??_ser+0)+0
	movf	(??_ser+0)+0,w
	movwf	(ser@a)
	line	30
	
i1l2822:	
;code.c: 30: tx(a);
	movf	(ser@a),w
	fcall	_tx
	line	31
	
i1l2824:	
;code.c: 31: cmd(0x80);
	movlw	(080h)
	fcall	i1_cmd
	line	32
	
i1l2826:	
;code.c: 32: show("Serial interrupt");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	line	33
	
i1l2828:	
;code.c: 33: cmd(0xc0);
	movlw	(0C0h)
	fcall	i1_cmd
	line	34
	
i1l2830:	
;code.c: 34: show("  Key : ");
	movlw	((STR_2-__stringbase))&0ffh
	fcall	_show
	line	35
	
i1l2832:	
;code.c: 35: cmd(0xc8);
	movlw	(0C8h)
	fcall	i1_cmd
	line	36
	
i1l2834:	
;code.c: 36: dat(a);
	movf	(ser@a),w
	fcall	_dat
	line	37
	
i1l2836:	
;code.c: 37: for(z=0;z<=50000;z++);for(z=0;z<=50000;z++);
	clrf	(_z)
	clrf	(_z+1)
	
i1l2838:	
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u248_21
	goto	u248_20
u248_21:
	goto	i1l2842
u248_20:
	goto	i1l2844
	
i1l2840:	
	goto	i1l2844
	
i1l737:	
	
i1l2842:	
	movlw	low(01h)
	addwf	(_z),f
	skipnc
	incf	(_z+1),f
	movlw	high(01h)
	addwf	(_z+1),f
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u249_21
	goto	u249_20
u249_21:
	goto	i1l2842
u249_20:
	goto	i1l2844
	
i1l738:	
	
i1l2844:	
	clrf	(_z)
	clrf	(_z+1)
	
i1l2846:	
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u250_21
	goto	u250_20
u250_21:
	goto	i1l2850
u250_20:
	goto	i1l740
	
i1l2848:	
	goto	i1l740
	
i1l739:	
	
i1l2850:	
	movlw	low(01h)
	addwf	(_z),f
	skipnc
	incf	(_z+1),f
	movlw	high(01h)
	addwf	(_z+1),f
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u251_21
	goto	u251_20
u251_21:
	goto	i1l2850
u251_20:
	
i1l740:	
	line	38
;code.c: 38: TXIF=RCIF=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(101/8),(101)&7
	bcf	(100/8),(100)&7
	line	39
	
i1l741:	
	movf	(??_ser+4),w
	movwf	btemp+1
	movf	(??_ser+3),w
	movwf	pclath
	movf	(??_ser+2),w
	movwf	fsr0
	swapf	(??_ser+1)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_ser
	__end_of_ser:
;; =============== function _ser ends ============

	signat	_ser,88
	global	_show
psect	text262,local,class=CODE,delta=2
global __ptext262
__ptext262:

;; *************** function _show *****************
;; Defined at:
;;		line 44 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_2(9), STR_1(17), 
;; Auto vars:     Size  Location     Type
;;  s               1    2[COMMON] PTR unsigned char 
;;		 -> STR_2(9), STR_1(17), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
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
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_dat
;; This function is called by:
;;		_ser
;; This function uses a non-reentrant model
;;
psect	text262
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
	line	44
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 3
; Regs used in _show: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	45
	
i1l1846:	
;lcd.h: 45: while(*s)
	goto	i1l1852
	
i1l726:	
	line	47
	
i1l1848:	
;lcd.h: 46: {
;lcd.h: 47: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
i1l1850:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	i1l1852
	line	48
	
i1l725:	
	line	45
	
i1l1852:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u10_21
	goto	u10_20
u10_21:
	goto	i1l1848
u10_20:
	goto	i1l728
	
i1l727:	
	line	49
	
i1l728:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	i1_cmd
psect	text263,local,class=CODE,delta=2
global __ptext263
__ptext263:

;; *************** function i1_cmd *****************
;; Defined at:
;;		line 24 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
;; Parameters:    Size  Location     Type
;;  cmd             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  cmd             1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ser
;; This function uses a non-reentrant model
;;
psect	text263
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
	line	24
	global	__size_ofi1_cmd
	__size_ofi1_cmd	equ	__end_ofi1_cmd-i1_cmd
	
i1_cmd:	
	opt	stack 4
; Regs used in i1_cmd: [wreg+status,2+btemp+1]
;i1cmd@a stored from wreg
	movwf	(i1cmd@a)
	line	25
	
i1l2852:	
;lcd.h: 25: PORTD=a;
	movf	(i1cmd@a),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	26
	
i1l2854:	
;lcd.h: 26: RC0=0;
	bcf	(56/8),(56)&7
	line	27
	
i1l2856:	
;lcd.h: 27: RC1=0;
	bcf	(57/8),(57)&7
	line	28
	
i1l2858:	
;lcd.h: 28: RC2=1;
	bsf	(58/8),(58)&7
	line	29
	
i1l2860:	
;lcd.h: 29: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
i1l2862:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u252_25
	movlw	low(03E8h)
	subwf	(_i),w
u252_25:

	skipc
	goto	u252_21
	goto	u252_20
u252_21:
	goto	i1l2866
u252_20:
	goto	i1l716
	
i1l2864:	
	goto	i1l716
	
i1l715:	
	
i1l2866:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
i1l2868:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u253_25
	movlw	low(03E8h)
	subwf	(_i),w
u253_25:

	skipc
	goto	u253_21
	goto	u253_20
u253_21:
	goto	i1l2866
u253_20:
	
i1l716:	
	line	30
;lcd.h: 30: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	31
	
i1l717:	
	return
	opt stack 0
GLOBAL	__end_ofi1_cmd
	__end_ofi1_cmd:
;; =============== function i1_cmd ends ============

	signat	i1_cmd,88
	global	_dat
psect	text264,local,class=CODE,delta=2
global __ptext264
__ptext264:

;; *************** function _dat *****************
;; Defined at:
;;		line 34 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
;; Parameters:    Size  Location     Type
;;  b               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  b               1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_show
;;		_ser
;; This function uses a non-reentrant model
;;
psect	text264
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\lcd.h"
	line	34
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 4
; Regs used in _dat: [wreg+status,2+btemp+1]
;dat@b stored from wreg
	movwf	(dat@b)
	line	35
	
i1l1828:	
;lcd.h: 35: PORTD=b;
	movf	(dat@b),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	36
	
i1l1830:	
;lcd.h: 36: RC0=1;
	bsf	(56/8),(56)&7
	line	37
	
i1l1832:	
;lcd.h: 37: RC1=0;
	bcf	(57/8),(57)&7
	line	38
	
i1l1834:	
;lcd.h: 38: RC2=1;
	bsf	(58/8),(58)&7
	line	39
	
i1l1836:	
;lcd.h: 39: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
i1l1838:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u8_25
	movlw	low(03E8h)
	subwf	(_i),w
u8_25:

	skipc
	goto	u8_21
	goto	u8_20
u8_21:
	goto	i1l1842
u8_20:
	goto	i1l721
	
i1l1840:	
	goto	i1l721
	
i1l720:	
	
i1l1842:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
i1l1844:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u9_25
	movlw	low(03E8h)
	subwf	(_i),w
u9_25:

	skipc
	goto	u9_21
	goto	u9_20
u9_21:
	goto	i1l1842
u9_20:
	
i1l721:	
	line	40
;lcd.h: 40: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	41
	
i1l722:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
	global	_tx
psect	text265,local,class=CODE,delta=2
global __ptext265
__ptext265:

;; *************** function _tx *****************
;; Defined at:
;;		line 16 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\serial.h"
;; Parameters:    Size  Location     Type
;;  dat             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  dat             1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ser
;;		_tx_string
;; This function uses a non-reentrant model
;;
psect	text265
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\serial\serial.h"
	line	16
	global	__size_of_tx
	__size_of_tx	equ	__end_of_tx-_tx
	
_tx:	
	opt	stack 4
; Regs used in _tx: [wreg]
;tx@dat stored from wreg
	movwf	(tx@dat)
	line	17
	
i1l1794:	
;serial.h: 17: TXREG=dat;
	movf	(tx@dat),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(25)	;volatile
	line	18
;serial.h: 18: while(!TXIF);
	goto	i1l694
	
i1l695:	
	
i1l694:	
	btfss	(100/8),(100)&7
	goto	u3_21
	goto	u3_20
u3_21:
	goto	i1l694
u3_20:
	goto	i1l697
	
i1l696:	
	line	19
	
i1l697:	
	return
	opt stack 0
GLOBAL	__end_of_tx
	__end_of_tx:
;; =============== function _tx ends ============

	signat	_tx,4216
psect	text266,local,class=CODE,delta=2
global __ptext266
__ptext266:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
