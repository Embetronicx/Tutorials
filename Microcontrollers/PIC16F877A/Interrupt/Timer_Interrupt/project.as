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
	FNCALL	_main,_lcd_init
	FNCALL	_main,_timer_init
	FNCALL	_main,_intr_init
	FNCALL	_main,_cmd
	FNCALL	_lcd_init,_cmd
	FNROOT	_main
	FNCALL	_tmr0,i1_cmd
	FNCALL	_tmr0,_show
	FNCALL	_show,_dat
	FNCALL	intlevel1,_tmr0
	global	intlevel1
	FNROOT	intlevel1
	global	_b
	global	_c
	global	_a
	global	_i
	global	_z
	global	_INTCON
psect	text331,local,class=CODE,delta=2
global __ptext331
__ptext331:
_INTCON	set	11
	global	_PORTD
_PORTD	set	8
	global	_T1CON
_T1CON	set	16
	global	_T2CON
_T2CON	set	18
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
	global	_TMR0IF
_TMR0IF	set	90
	global	_TMR1IF
_TMR1IF	set	96
	global	_TMR2IF
_TMR2IF	set	97
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_PIE1
_PIE1	set	140
	global	_TRISD
_TRISD	set	136
	global	_TRISC0
_TRISC0	set	1080
	global	_TRISC1
_TRISC1	set	1081
	global	_TRISC2
_TRISC2	set	1082
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
	retlw	84	;'T'
	retlw	105	;'i'
	retlw	109	;'m'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	32	;' '
	retlw	48	;'0'
	retlw	32	;' '
	retlw	105	;'i'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	117	;'u'
	retlw	112	;'p'
	retlw	116	;'t'
	retlw	0
psect	strings
	
STR_2:	
	retlw	84	;'T'
	retlw	105	;'i'
	retlw	109	;'m'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	32	;' '
	retlw	49	;'1'
	retlw	32	;' '
	retlw	105	;'i'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	117	;'u'
	retlw	112	;'p'
	retlw	116	;'t'
	retlw	0
psect	strings
	
STR_3:	
	retlw	84	;'T'
	retlw	105	;'i'
	retlw	109	;'m'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	32	;' '
	retlw	50	;'2'
	retlw	32	;' '
	retlw	105	;'i'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	117	;'u'
	retlw	112	;'p'
	retlw	116	;'t'
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
_a:
       ds      2

_i:
       ds      2

_z:
       ds      2

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_b:
       ds      2

_c:
       ds      2

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
	clrf	((__pbssCOMMON)+4)&07Fh
	clrf	((__pbssCOMMON)+5)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
	clrf	((__pbssBANK0)+2)&07Fh
	clrf	((__pbssBANK0)+3)&07Fh
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
	global	?_lcd_init
?_lcd_init:	; 0 bytes @ 0x0
	global	?_dat
?_dat:	; 0 bytes @ 0x0
	global	??_dat
??_dat:	; 0 bytes @ 0x0
	global	?_show
?_show:	; 0 bytes @ 0x0
	global	?_tmr0
?_tmr0:	; 0 bytes @ 0x0
	global	?_intr_init
?_intr_init:	; 0 bytes @ 0x0
	global	?_timer_init
?_timer_init:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?i1_cmd
?i1_cmd:	; 0 bytes @ 0x0
	global	??i1_cmd
??i1_cmd:	; 0 bytes @ 0x0
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
	global	??_tmr0
??_tmr0:	; 0 bytes @ 0x3
	ds	4
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_cmd
??_cmd:	; 0 bytes @ 0x0
	global	??_intr_init
??_intr_init:	; 0 bytes @ 0x0
	global	??_timer_init
??_timer_init:	; 0 bytes @ 0x0
	global	cmd@a
cmd@a:	; 1 bytes @ 0x0
	ds	1
	global	??_lcd_init
??_lcd_init:	; 0 bytes @ 0x1
	global	??_main
??_main:	; 0 bytes @ 0x1
;;Data sizes: Strings 51, constant 0, data 0, bss 10, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      7      13
;; BANK0           80      1       5
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; show@s	PTR unsigned char  size(1) Largest target is 17
;;		 -> STR_3(CODE[17]), STR_2(CODE[17]), STR_1(CODE[17]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _tmr0 in COMMON
;;
;;   _tmr0->_show
;;   _show->_dat
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_cmd
;;   _lcd_init->_cmd
;;
;; Critical Paths under _tmr0 in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _tmr0 in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _tmr0 in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _tmr0 in BANK2
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
;; (0) _main                                                 0     0      0      62
;;                           _lcd_init
;;                         _timer_init
;;                          _intr_init
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             0     0      0      31
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _timer_init                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _intr_init                                            0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  1     1      0      31
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 1
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (3) _tmr0                                                 4     4      0     140
;;                                              3 COMMON     4     4      0
;;                              i1_cmd
;;                               _show
;; ---------------------------------------------------------------------------------
;; (4) _show                                                 2     2      0      67
;;                                              1 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (4) i1_cmd                                                1     1      0      73
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (5) _dat                                                  1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 5
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_init
;;     _cmd
;;   _timer_init
;;   _intr_init
;;   _cmd
;;
;; _tmr0 (ROOT)
;;   i1_cmd
;;   _show
;;     _dat
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      7       D       1       92.9%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       8       2        0.0%
;;ABS                  0      0      12       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      1       5       5        6.3%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0      1A      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 60 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
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
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_lcd_init
;;		_timer_init
;;		_intr_init
;;		_cmd
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
	line	60
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 3
; Regs used in _main: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	61
	
l2939:	
;code.c: 61: lcd_init();
	fcall	_lcd_init
	line	62
	
l2941:	
;code.c: 62: timer_init();
	fcall	_timer_init
	line	63
	
l2943:	
;code.c: 63: intr_init();
	fcall	_intr_init
	line	64
;code.c: 64: while(1) {
	
l739:	
	line	65
;code.c: 65: cmd(0x01);
	movlw	(01h)
	fcall	_cmd
	goto	l739
	line	66
	
l740:	
	line	64
	goto	l739
	
l741:	
	line	67
	
l742:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_lcd_init
psect	text332,local,class=CODE,delta=2
global __ptext332
__ptext332:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 15 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
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
psect	text332
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
	line	15
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 3
; Regs used in _lcd_init: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	16
	
l2935:	
;lcd.h: 16: TRISC0=TRISC1=TRISC2=TRISD=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	btfsc	((136)^080h),0	;volatile
	goto	u2721
	goto	u2720
	
u2721:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1082/8)^080h,(1082)&7
	goto	u2734
u2720:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1082/8)^080h,(1082)&7
u2734:
	btfsc	(1082/8)^080h,(1082)&7
	goto	u2731
	goto	u2730
	
u2731:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1081/8)^080h,(1081)&7
	goto	u2744
u2730:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1081/8)^080h,(1081)&7
u2744:
	btfsc	(1081/8)^080h,(1081)&7
	goto	u2741
	goto	u2740
	
u2741:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1080/8)^080h,(1080)&7
	goto	u2754
u2740:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1080/8)^080h,(1080)&7
u2754:
	line	17
	
l2937:	
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
	
l697:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_timer_init
psect	text333,local,class=CODE,delta=2
global __ptext333
__ptext333:

;; *************** function _timer_init *****************
;; Defined at:
;;		line 53 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
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
psect	text333
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
	line	53
	global	__size_of_timer_init
	__size_of_timer_init	equ	__end_of_timer_init-_timer_init
	
_timer_init:	
	opt	stack 4
; Regs used in _timer_init: [wreg]
	line	54
	
l2933:	
;code.c: 54: OPTION_REG=0b00000111;
	movlw	(07h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	55
;code.c: 55: T1CON=0b00000001;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(16)	;volatile
	line	56
;code.c: 56: T2CON=0b01111100;
	movlw	(07Ch)
	movwf	(18)	;volatile
	line	57
	
l736:	
	return
	opt stack 0
GLOBAL	__end_of_timer_init
	__end_of_timer_init:
;; =============== function _timer_init ends ============

	signat	_timer_init,88
	global	_intr_init
psect	text334,local,class=CODE,delta=2
global __ptext334
__ptext334:

;; *************** function _intr_init *****************
;; Defined at:
;;		line 47 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
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
psect	text334
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
	line	47
	global	__size_of_intr_init
	__size_of_intr_init	equ	__end_of_intr_init-_intr_init
	
_intr_init:	
	opt	stack 4
; Regs used in _intr_init: [wreg]
	line	48
	
l2931:	
;code.c: 48: INTCON=0xe0;
	movlw	(0E0h)
	movwf	(11)	;volatile
	line	49
;code.c: 49: PIE1=0x03;
	movlw	(03h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(140)^080h	;volatile
	line	50
	
l733:	
	return
	opt stack 0
GLOBAL	__end_of_intr_init
	__end_of_intr_init:
;; =============== function _intr_init ends ============

	signat	_intr_init,88
	global	_cmd
psect	text335,local,class=CODE,delta=2
global __ptext335
__ptext335:

;; *************** function _cmd *****************
;; Defined at:
;;		line 24 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
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
psect	text335
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
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
	
l2913:	
;lcd.h: 25: PORTD=a;
	movf	(cmd@a),w
	movwf	(8)	;volatile
	line	26
	
l2915:	
;lcd.h: 26: RC0=0;
	bcf	(56/8),(56)&7
	line	27
	
l2917:	
;lcd.h: 27: RC1=0;
	bcf	(57/8),(57)&7
	line	28
	
l2919:	
;lcd.h: 28: RC2=1;
	bsf	(58/8),(58)&7
	line	29
	
l2921:	
;lcd.h: 29: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l2923:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2705
	movlw	low(03E8h)
	subwf	(_i),w
u2705:

	skipc
	goto	u2701
	goto	u2700
u2701:
	goto	l2927
u2700:
	goto	l701
	
l2925:	
	goto	l701
	
l700:	
	
l2927:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l2929:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2715
	movlw	low(03E8h)
	subwf	(_i),w
u2715:

	skipc
	goto	u2711
	goto	u2710
u2711:
	goto	l2927
u2710:
	
l701:	
	line	30
;lcd.h: 30: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	31
	
l702:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
	global	_tmr0
psect	text336,local,class=CODE,delta=2
global __ptext336
__ptext336:

;; *************** function _tmr0 *****************
;; Defined at:
;;		line 11 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
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
;;      Locals:         0       0       0       0       0
;;      Temps:          4       0       0       0       0
;;      Totals:         4       0       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		i1_cmd
;;		_show
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text336
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\code.c"
	line	11
	global	__size_of_tmr0
	__size_of_tmr0	equ	__end_of_tmr0-_tmr0
	
_tmr0:	
	opt	stack 3
; Regs used in _tmr0: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_tmr0+0)
	movf	fsr0,w
	movwf	(??_tmr0+1)
	movf	pclath,w
	movwf	(??_tmr0+2)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_tmr0+3)
	ljmp	_tmr0
psect	text336
	line	12
	
i1l2835:	
;code.c: 12: if(TMR0IF) {
	btfss	(90/8),(90)&7
	goto	u252_21
	goto	u252_20
u252_21:
	goto	i1l716
u252_20:
	line	13
	
i1l2837:	
;code.c: 13: a++;
	movlw	low(01h)
	addwf	(_a),f
	skipnc
	incf	(_a+1),f
	movlw	high(01h)
	addwf	(_a+1),f
	line	14
;code.c: 14: if(a==42)
	movlw	02Ah
	xorwf	(_a),w
	iorwf	(_a+1),w
	skipz
	goto	u253_21
	goto	u253_20
u253_21:
	goto	i1l717
u253_20:
	line	16
	
i1l2839:	
;code.c: 15: {
;code.c: 16: cmd(0x80);
	movlw	(080h)
	fcall	i1_cmd
	line	17
	
i1l2841:	
;code.c: 17: show("Timer 0 interupt");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	line	18
	
i1l2843:	
;code.c: 18: a=0;
	clrf	(_a)
	clrf	(_a+1)
	line	19
	
i1l2845:	
;code.c: 19: for(z=0;z<=50000;z++);
	clrf	(_z)
	clrf	(_z+1)
	
i1l2847:	
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u254_21
	goto	u254_20
u254_21:
	goto	i1l2851
u254_20:
	goto	i1l717
	
i1l2849:	
	goto	i1l717
	
i1l718:	
	
i1l2851:	
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
	goto	u255_21
	goto	u255_20
u255_21:
	goto	i1l2851
u255_20:
	goto	i1l717
	
i1l719:	
	line	20
	
i1l717:	
	line	21
;code.c: 20: }
;code.c: 21: TMR0IF=0;
	bcf	(90/8),(90)&7
	line	22
;code.c: 22: } else if(TMR1IF) {
	goto	i1l730
	
i1l716:	
	btfss	(96/8),(96)&7
	goto	u256_21
	goto	u256_20
u256_21:
	goto	i1l721
u256_20:
	line	23
	
i1l2853:	
;code.c: 23: b++;
	movlw	low(01h)
	addwf	(_b),f
	skipnc
	incf	(_b+1),f
	movlw	high(01h)
	addwf	(_b+1),f
	line	24
;code.c: 24: if(b==84)
	movlw	054h
	xorwf	(_b),w
	iorwf	(_b+1),w
	skipz
	goto	u257_21
	goto	u257_20
u257_21:
	goto	i1l722
u257_20:
	line	26
	
i1l2855:	
;code.c: 25: {
;code.c: 26: cmd(0xc0);
	movlw	(0C0h)
	fcall	i1_cmd
	line	27
	
i1l2857:	
;code.c: 27: show("Timer 1 interupt");
	movlw	((STR_2-__stringbase))&0ffh
	fcall	_show
	line	28
	
i1l2859:	
;code.c: 28: b=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(_b)
	clrf	(_b+1)
	line	29
	
i1l2861:	
;code.c: 29: for(z=0;z<=50000;z++);
	clrf	(_z)
	clrf	(_z+1)
	
i1l2863:	
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u258_21
	goto	u258_20
u258_21:
	goto	i1l2867
u258_20:
	goto	i1l722
	
i1l2865:	
	goto	i1l722
	
i1l723:	
	
i1l2867:	
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
	goto	u259_21
	goto	u259_20
u259_21:
	goto	i1l2867
u259_20:
	goto	i1l722
	
i1l724:	
	line	30
	
i1l722:	
	line	31
;code.c: 30: }
;code.c: 31: TMR1IF=0;
	bcf	(96/8),(96)&7
	line	32
;code.c: 32: } else if(TMR2IF) {
	goto	i1l730
	
i1l721:	
	btfss	(97/8),(97)&7
	goto	u260_21
	goto	u260_20
u260_21:
	goto	i1l730
u260_20:
	line	33
	
i1l2869:	
;code.c: 33: c++;
	movlw	low(01h)
	addwf	(_c),f
	skipnc
	incf	(_c+1),f
	movlw	high(01h)
	addwf	(_c+1),f
	line	34
;code.c: 34: if(c==2025)
	movlw	high(07E9h)
	xorwf	(_c+1),w
	skipz
	goto	u261_25
	movlw	low(07E9h)
	xorwf	(_c),w
u261_25:

	skipz
	goto	u261_21
	goto	u261_20
u261_21:
	goto	i1l727
u261_20:
	line	36
	
i1l2871:	
;code.c: 35: {
;code.c: 36: cmd(0x80);
	movlw	(080h)
	fcall	i1_cmd
	line	37
	
i1l2873:	
;code.c: 37: show("Timer 2 interupt");
	movlw	((STR_3-__stringbase))&0ffh
	fcall	_show
	line	38
	
i1l2875:	
;code.c: 38: c=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(_c)
	clrf	(_c+1)
	line	39
	
i1l2877:	
;code.c: 39: for(z=0;z<=50000;z++);
	clrf	(_z)
	clrf	(_z+1)
	
i1l2879:	
	movlw	high(0C351h)
	subwf	(_z+1),w
	movlw	low(0C351h)
	skipnz
	subwf	(_z),w
	skipc
	goto	u262_21
	goto	u262_20
u262_21:
	goto	i1l2883
u262_20:
	goto	i1l727
	
i1l2881:	
	goto	i1l727
	
i1l728:	
	
i1l2883:	
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
	goto	u263_21
	goto	u263_20
u263_21:
	goto	i1l2883
u263_20:
	goto	i1l727
	
i1l729:	
	line	40
	
i1l727:	
	line	41
;code.c: 40: }
;code.c: 41: TMR2IF=0;
	bcf	(97/8),(97)&7
	goto	i1l730
	line	42
	
i1l726:	
	goto	i1l730
	line	44
	
i1l725:	
	goto	i1l730
	
i1l720:	
	
i1l730:	
	movf	(??_tmr0+3),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	btemp+1
	movf	(??_tmr0+2),w
	movwf	pclath
	movf	(??_tmr0+1),w
	movwf	fsr0
	swapf	(??_tmr0+0)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_tmr0
	__end_of_tmr0:
;; =============== function _tmr0 ends ============

	signat	_tmr0,88
	global	_show
psect	text337,local,class=CODE,delta=2
global __ptext337
__ptext337:

;; *************** function _show *****************
;; Defined at:
;;		line 44 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_3(17), STR_2(17), STR_1(17), 
;; Auto vars:     Size  Location     Type
;;  s               1    2[COMMON] PTR unsigned char 
;;		 -> STR_3(17), STR_2(17), STR_1(17), 
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
;;		_tmr0
;; This function uses a non-reentrant model
;;
psect	text337
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 3
; Regs used in _show: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	45
	
i1l2827:	
;lcd.h: 45: while(*s)
	goto	i1l2833
	
i1l711:	
	line	47
	
i1l2829:	
;lcd.h: 46: {
;lcd.h: 47: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
i1l2831:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	i1l2833
	line	48
	
i1l710:	
	line	45
	
i1l2833:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u251_21
	goto	u251_20
u251_21:
	goto	i1l2829
u251_20:
	goto	i1l713
	
i1l712:	
	line	49
	
i1l713:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	i1_cmd
psect	text338,local,class=CODE,delta=2
global __ptext338
__ptext338:

;; *************** function i1_cmd *****************
;; Defined at:
;;		line 24 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
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
;;		_tmr0
;; This function uses a non-reentrant model
;;
psect	text338
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
	line	24
	global	__size_ofi1_cmd
	__size_ofi1_cmd	equ	__end_ofi1_cmd-i1_cmd
	
i1_cmd:	
	opt	stack 4
; Regs used in i1_cmd: [wreg+status,2+btemp+1]
;i1cmd@a stored from wreg
	movwf	(i1cmd@a)
	line	25
	
i1l2885:	
;lcd.h: 25: PORTD=a;
	movf	(i1cmd@a),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	26
	
i1l2887:	
;lcd.h: 26: RC0=0;
	bcf	(56/8),(56)&7
	line	27
	
i1l2889:	
;lcd.h: 27: RC1=0;
	bcf	(57/8),(57)&7
	line	28
	
i1l2891:	
;lcd.h: 28: RC2=1;
	bsf	(58/8),(58)&7
	line	29
	
i1l2893:	
;lcd.h: 29: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
i1l2895:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u264_25
	movlw	low(03E8h)
	subwf	(_i),w
u264_25:

	skipc
	goto	u264_21
	goto	u264_20
u264_21:
	goto	i1l2899
u264_20:
	goto	i1l701
	
i1l2897:	
	goto	i1l701
	
i1l700:	
	
i1l2899:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
i1l2901:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u265_25
	movlw	low(03E8h)
	subwf	(_i),w
u265_25:

	skipc
	goto	u265_21
	goto	u265_20
u265_21:
	goto	i1l2899
u265_20:
	
i1l701:	
	line	30
;lcd.h: 30: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	31
	
i1l702:	
	return
	opt stack 0
GLOBAL	__end_ofi1_cmd
	__end_ofi1_cmd:
;; =============== function i1_cmd ends ============

	signat	i1_cmd,88
	global	_dat
psect	text339,local,class=CODE,delta=2
global __ptext339
__ptext339:

;; *************** function _dat *****************
;; Defined at:
;;		line 34 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
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
;; This function uses a non-reentrant model
;;
psect	text339
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Timer\lcd.h"
	line	34
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 3
; Regs used in _dat: [wreg+status,2+btemp+1]
;dat@b stored from wreg
	movwf	(dat@b)
	line	35
	
i1l2809:	
;lcd.h: 35: PORTD=b;
	movf	(dat@b),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	36
	
i1l2811:	
;lcd.h: 36: RC0=1;
	bsf	(56/8),(56)&7
	line	37
	
i1l2813:	
;lcd.h: 37: RC1=0;
	bcf	(57/8),(57)&7
	line	38
	
i1l2815:	
;lcd.h: 38: RC2=1;
	bsf	(58/8),(58)&7
	line	39
	
i1l2817:	
;lcd.h: 39: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
i1l2819:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u249_25
	movlw	low(03E8h)
	subwf	(_i),w
u249_25:

	skipc
	goto	u249_21
	goto	u249_20
u249_21:
	goto	i1l2823
u249_20:
	goto	i1l706
	
i1l2821:	
	goto	i1l706
	
i1l705:	
	
i1l2823:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
i1l2825:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u250_25
	movlw	low(03E8h)
	subwf	(_i),w
u250_25:

	skipc
	goto	u250_21
	goto	u250_20
u250_21:
	goto	i1l2823
u250_20:
	
i1l706:	
	line	40
;lcd.h: 40: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	41
	
i1l707:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
psect	text340,local,class=CODE,delta=2
global __ptext340
__ptext340:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
