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
# 7 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	psect config,class=CONFIG,delta=2 ;#
# 7 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	dw 0xFFFE & 0xFFFB & 0xFFFF & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_lcd_int
	FNCALL	_main,_show
	FNCALL	_main,_cmd
	FNCALL	_main,_adc
	FNCALL	_adc,___lwdiv
	FNCALL	_adc,_dat
	FNCALL	_adc,___lwmod
	FNCALL	_show,_dat
	FNCALL	_lcd_int,_cmd
	FNROOT	_main
	global	_i
	global	_ADCON0
psect	text194,local,class=CODE,delta=2
global __ptext194
__ptext194:
_ADCON0	set	31
	global	_ADRESH
_ADRESH	set	30
	global	_PORTB
_PORTB	set	6
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_GO_nDONE
_GO_nDONE	set	250
	global	_RC0
_RC0	set	56
	global	_RC1
_RC1	set	57
	global	_RC2
_RC2	set	58
	global	_ADCON1
_ADCON1	set	159
	global	_ADRESL
_ADRESL	set	158
	global	_TRISB
_TRISB	set	134
	global	_TRISC
_TRISC	set	135
	global	_TRISA0
_TRISA0	set	1064
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
	retlw	65	;'A'
	retlw	68	;'D'
	retlw	67	;'C'
	retlw	32	;' '
	retlw	86	;'V'
	retlw	97	;'a'
	retlw	108	;'l'
	retlw	117	;'u'
	retlw	101	;'e'
	retlw	32	;' '
	retlw	58	;':'
	retlw	0
psect	strings
	file	"project.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_i:
       ds      2

; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_lcd_int
?_lcd_int:	; 0 bytes @ 0x0
	global	?_show
?_show:	; 0 bytes @ 0x0
	global	?_cmd
?_cmd:	; 0 bytes @ 0x0
	global	??_cmd
??_cmd:	; 0 bytes @ 0x0
	global	?_adc
?_adc:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_dat
?_dat:	; 0 bytes @ 0x0
	global	??_dat
??_dat:	; 0 bytes @ 0x0
	global	?___lwdiv
?___lwdiv:	; 2 bytes @ 0x0
	global	cmd@a
cmd@a:	; 1 bytes @ 0x0
	global	dat@b
dat@b:	; 1 bytes @ 0x0
	global	___lwdiv@divisor
___lwdiv@divisor:	; 2 bytes @ 0x0
	ds	1
	global	??_lcd_int
??_lcd_int:	; 0 bytes @ 0x1
	global	??_show
??_show:	; 0 bytes @ 0x1
	ds	1
	global	show@s
show@s:	; 1 bytes @ 0x2
	global	___lwdiv@dividend
___lwdiv@dividend:	; 2 bytes @ 0x2
	ds	2
	global	??___lwdiv
??___lwdiv:	; 0 bytes @ 0x4
	ds	1
	global	___lwdiv@quotient
___lwdiv@quotient:	; 2 bytes @ 0x5
	ds	2
	global	___lwdiv@counter
___lwdiv@counter:	; 1 bytes @ 0x7
	ds	1
	global	?___lwmod
?___lwmod:	; 2 bytes @ 0x8
	global	___lwmod@divisor
___lwmod@divisor:	; 2 bytes @ 0x8
	ds	2
	global	___lwmod@dividend
___lwmod@dividend:	; 2 bytes @ 0xA
	ds	2
	global	??___lwmod
??___lwmod:	; 0 bytes @ 0xC
	ds	1
	global	___lwmod@counter
___lwmod@counter:	; 1 bytes @ 0xD
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0xE
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_adc
??_adc:	; 0 bytes @ 0x0
	ds	4
	global	adc@adcval
adc@adcval:	; 2 bytes @ 0x4
	ds	2
;;Data sizes: Strings 12, constant 0, data 0, bss 2, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14     14      14
;; BANK0           80      6       8
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; ?___lwmod	unsigned int  size(1) Largest target is 0
;;
;; ?___lwdiv	unsigned int  size(1) Largest target is 0
;;
;; show@s	PTR unsigned char  size(1) Largest target is 12
;;		 -> STR_1(CODE[12]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _adc->___lwmod
;;   _show->_dat
;;   _lcd_int->_cmd
;;   ___lwmod->___lwdiv
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_adc
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
;; (0) _main                                                 0     0      0     566
;;                            _lcd_int
;;                               _show
;;                                _cmd
;;                                _adc
;; ---------------------------------------------------------------------------------
;; (1) _adc                                                  6     6      0     455
;;                                              0 BANK0      6     6      0
;;                            ___lwdiv
;;                                _dat
;;                            ___lwmod
;; ---------------------------------------------------------------------------------
;; (1) _show                                                 2     2      0      67
;;                                              1 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _lcd_int                                              0     0      0      22
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (2) ___lwmod                                              6     2      4     159
;;                                              8 COMMON     6     2      4
;;                            ___lwdiv (ARG)
;; ---------------------------------------------------------------------------------
;; (2) ___lwdiv                                              8     4      4     162
;;                                              0 COMMON     8     4      4
;; ---------------------------------------------------------------------------------
;; (2) _dat                                                  1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_int
;;     _cmd
;;   _show
;;     _dat
;;   _cmd
;;   _adc
;;     ___lwdiv
;;     _dat
;;     ___lwmod
;;       ___lwdiv (ARG)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      E       E       1      100.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       2       2        0.0%
;;ABS                  0      0      16       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      6       8       5       10.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0      18      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 19 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
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
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_lcd_int
;;		_show
;;		_cmd
;;		_adc
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	line	19
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 6
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	20
	
l2928:	
;CODE.c: 20: TRISB=TRISC=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(135)^080h	;volatile
	clrf	(134)^080h	;volatile
	line	21
	
l2930:	
;CODE.c: 21: TRISA0=1;
	bsf	(1064/8)^080h,(1064)&7
	line	22
	
l2932:	
;CODE.c: 22: lcd_int();
	fcall	_lcd_int
	line	23
	
l2934:	
;CODE.c: 23: show("ADC Value :");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	goto	l2936
	line	24
;CODE.c: 24: while(1) {
	
l695:	
	line	25
	
l2936:	
;CODE.c: 25: cmd(0x8C);
	movlw	(08Ch)
	fcall	_cmd
	line	26
	
l2938:	
;CODE.c: 26: adc();
	fcall	_adc
	goto	l2936
	line	27
	
l696:	
	line	24
	goto	l2936
	
l697:	
	line	28
	
l698:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_adc
psect	text195,local,class=CODE,delta=2
global __ptext195
__ptext195:

;; *************** function _adc *****************
;; Defined at:
;;		line 66 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  adcval          2    4[BANK0 ] unsigned int 
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
;;      Locals:         0       2       0       0       0
;;      Temps:          0       4       0       0       0
;;      Totals:         0       6       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		___lwdiv
;;		_dat
;;		___lwmod
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text195
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	line	66
	global	__size_of_adc
	__size_of_adc	equ	__end_of_adc-_adc
	
_adc:	
	opt	stack 6
; Regs used in _adc: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	69
	
l2914:	
;CODE.c: 67: unsigned int adcval;
;CODE.c: 69: ADCON1=0xc0;
	movlw	(0C0h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(159)^080h	;volatile
	line	70
;CODE.c: 70: ADCON0=0x85;
	movlw	(085h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(31)	;volatile
	line	71
;CODE.c: 71: while(GO_nDONE);
	goto	l720
	
l721:	
	
l720:	
	btfsc	(250/8),(250)&7
	goto	u2461
	goto	u2460
u2461:
	goto	l720
u2460:
	goto	l2916
	
l722:	
	line	72
	
l2916:	
;CODE.c: 72: adcval=((ADRESH<<8)|(ADRESL));
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movf	(158)^080h,w	;volatile
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_adc+0)+0
	clrf	(??_adc+0)+0+1
	movf	(30),w	;volatile
	movwf	(??_adc+2)+0
	clrf	(??_adc+2)+0+1
	movf	(??_adc+2)+0,w
	movwf	(??_adc+2)+1
	clrf	(??_adc+2)+0
	movf	0+(??_adc+0)+0,w
	iorwf	0+(??_adc+2)+0,w
	movwf	(adc@adcval)
	movf	1+(??_adc+0)+0,w
	iorwf	1+(??_adc+2)+0,w
	movwf	1+(adc@adcval)
	line	73
	
l2918:	
;CODE.c: 73: adcval=(adcval/3)-1;
	movlw	low(03h)
	movwf	(?___lwdiv)
	movlw	high(03h)
	movwf	((?___lwdiv))+1
	movf	(adc@adcval+1),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(adc@adcval),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	movf	(0+(?___lwdiv)),w
	addlw	low(0FFFFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(adc@adcval)
	movf	(1+(?___lwdiv)),w
	skipnc
	addlw	1
	addlw	high(0FFFFh)
	movwf	1+(adc@adcval)
	line	74
	
l2920:	
;CODE.c: 74: dat((adcval/1000)+48);
	movlw	low(03E8h)
	movwf	(?___lwdiv)
	movlw	high(03E8h)
	movwf	((?___lwdiv))+1
	movf	(adc@adcval+1),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(adc@adcval),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	movf	(0+(?___lwdiv)),w
	addlw	030h
	fcall	_dat
	line	75
	
l2922:	
;CODE.c: 75: dat(((adcval/100)%10)+48);
	movlw	low(0Ah)
	movwf	(?___lwmod)
	movlw	high(0Ah)
	movwf	((?___lwmod))+1
	movlw	low(064h)
	movwf	(?___lwdiv)
	movlw	high(064h)
	movwf	((?___lwdiv))+1
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(adc@adcval+1),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(adc@adcval),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	movf	(1+(?___lwdiv)),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(0+(?___lwdiv)),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	fcall	___lwmod
	movf	(0+(?___lwmod)),w
	addlw	030h
	fcall	_dat
	line	76
	
l2924:	
;CODE.c: 76: dat(((adcval/10)%10)+48);
	movlw	low(0Ah)
	movwf	(?___lwmod)
	movlw	high(0Ah)
	movwf	((?___lwmod))+1
	movlw	low(0Ah)
	movwf	(?___lwdiv)
	movlw	high(0Ah)
	movwf	((?___lwdiv))+1
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(adc@adcval+1),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(adc@adcval),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	movf	(1+(?___lwdiv)),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(0+(?___lwdiv)),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	fcall	___lwmod
	movf	(0+(?___lwmod)),w
	addlw	030h
	fcall	_dat
	line	77
	
l2926:	
;CODE.c: 77: dat((adcval%10)+48);
	movlw	low(0Ah)
	movwf	(?___lwmod)
	movlw	high(0Ah)
	movwf	((?___lwmod))+1
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(adc@adcval+1),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(adc@adcval),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	fcall	___lwmod
	movf	(0+(?___lwmod)),w
	addlw	030h
	fcall	_dat
	line	79
	
l723:	
	return
	opt stack 0
GLOBAL	__end_of_adc
	__end_of_adc:
;; =============== function _adc ends ============

	signat	_adc,88
	global	_show
psect	text196,local,class=CODE,delta=2
global __ptext196
__ptext196:

;; *************** function _show *****************
;; Defined at:
;;		line 59 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_1(12), 
;; Auto vars:     Size  Location     Type
;;  s               1    2[COMMON] PTR unsigned char 
;;		 -> STR_1(12), 
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
;;		_main
;; This function uses a non-reentrant model
;;
psect	text196
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	line	59
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 6
; Regs used in _show: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	60
	
l2906:	
;CODE.c: 60: while(*s) {
	goto	l2912
	
l715:	
	line	61
	
l2908:	
;CODE.c: 61: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
l2910:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	l2912
	line	62
	
l714:	
	line	60
	
l2912:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2451
	goto	u2450
u2451:
	goto	l2908
u2450:
	goto	l717
	
l716:	
	line	63
	
l717:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	_lcd_int
psect	text197,local,class=CODE,delta=2
global __ptext197
__ptext197:

;; *************** function _lcd_int *****************
;; Defined at:
;;		line 31 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
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
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_cmd
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text197
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	line	31
	global	__size_of_lcd_int
	__size_of_lcd_int	equ	__end_of_lcd_int-_lcd_int
	
_lcd_int:	
	opt	stack 6
; Regs used in _lcd_int: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	32
	
l2904:	
;CODE.c: 32: cmd(0x38);
	movlw	(038h)
	fcall	_cmd
	line	33
;CODE.c: 33: cmd(0x0c);
	movlw	(0Ch)
	fcall	_cmd
	line	34
;CODE.c: 34: cmd(0x06);
	movlw	(06h)
	fcall	_cmd
	line	35
;CODE.c: 35: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	36
	
l701:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_int
	__end_of_lcd_int:
;; =============== function _lcd_int ends ============

	signat	_lcd_int,88
	global	___lwmod
psect	text198,local,class=CODE,delta=2
global __ptext198
__ptext198:

;; *************** function ___lwmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lwmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    8[COMMON] unsigned int 
;;  dividend        2   10[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  counter         1   13[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    8[COMMON] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         6       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_adc
;; This function uses a non-reentrant model
;;
psect	text198
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lwmod.c"
	line	5
	global	__size_of___lwmod
	__size_of___lwmod	equ	__end_of___lwmod-___lwmod
	
___lwmod:	
	opt	stack 6
; Regs used in ___lwmod: [wreg+status,2+status,0]
	line	8
	
l2882:	
	movf	(___lwmod@divisor+1),w
	iorwf	(___lwmod@divisor),w
	skipnz
	goto	u2391
	goto	u2390
u2391:
	goto	l2900
u2390:
	line	9
	
l2884:	
	clrf	(___lwmod@counter)
	bsf	status,0
	rlf	(___lwmod@counter),f
	line	10
	goto	l2890
	
l1424:	
	line	11
	
l2886:	
	movlw	01h
	
u2405:
	clrc
	rlf	(___lwmod@divisor),f
	rlf	(___lwmod@divisor+1),f
	addlw	-1
	skipz
	goto	u2405
	line	12
	
l2888:	
	movlw	(01h)
	movwf	(??___lwmod+0)+0
	movf	(??___lwmod+0)+0,w
	addwf	(___lwmod@counter),f
	goto	l2890
	line	13
	
l1423:	
	line	10
	
l2890:	
	btfss	(___lwmod@divisor+1),(15)&7
	goto	u2411
	goto	u2410
u2411:
	goto	l2886
u2410:
	goto	l2892
	
l1425:	
	goto	l2892
	line	14
	
l1426:	
	line	15
	
l2892:	
	movf	(___lwmod@divisor+1),w
	subwf	(___lwmod@dividend+1),w
	skipz
	goto	u2425
	movf	(___lwmod@divisor),w
	subwf	(___lwmod@dividend),w
u2425:
	skipc
	goto	u2421
	goto	u2420
u2421:
	goto	l2896
u2420:
	line	16
	
l2894:	
	movf	(___lwmod@divisor),w
	subwf	(___lwmod@dividend),f
	movf	(___lwmod@divisor+1),w
	skipc
	decf	(___lwmod@dividend+1),f
	subwf	(___lwmod@dividend+1),f
	goto	l2896
	
l1427:	
	line	17
	
l2896:	
	movlw	01h
	
u2435:
	clrc
	rrf	(___lwmod@divisor+1),f
	rrf	(___lwmod@divisor),f
	addlw	-1
	skipz
	goto	u2435
	line	18
	
l2898:	
	movlw	low(01h)
	subwf	(___lwmod@counter),f
	btfss	status,2
	goto	u2441
	goto	u2440
u2441:
	goto	l2892
u2440:
	goto	l2900
	
l1428:	
	goto	l2900
	line	19
	
l1422:	
	line	20
	
l2900:	
	movf	(___lwmod@dividend+1),w
	clrf	(?___lwmod+1)
	addwf	(?___lwmod+1)
	movf	(___lwmod@dividend),w
	clrf	(?___lwmod)
	addwf	(?___lwmod)

	goto	l1429
	
l2902:	
	line	21
	
l1429:	
	return
	opt stack 0
GLOBAL	__end_of___lwmod
	__end_of___lwmod:
;; =============== function ___lwmod ends ============

	signat	___lwmod,8314
	global	___lwdiv
psect	text199,local,class=CODE,delta=2
global __ptext199
__ptext199:

;; *************** function ___lwdiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lwdiv.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    0[COMMON] unsigned int 
;;  dividend        2    2[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  quotient        2    5[COMMON] unsigned int 
;;  counter         1    7[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    0[COMMON] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         8       0       0       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_adc
;; This function uses a non-reentrant model
;;
psect	text199
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\lwdiv.c"
	line	5
	global	__size_of___lwdiv
	__size_of___lwdiv	equ	__end_of___lwdiv-___lwdiv
	
___lwdiv:	
	opt	stack 6
; Regs used in ___lwdiv: [wreg+status,2+status,0]
	line	9
	
l2856:	
	clrf	(___lwdiv@quotient)
	clrf	(___lwdiv@quotient+1)
	line	10
	
l2858:	
	movf	(___lwdiv@divisor+1),w
	iorwf	(___lwdiv@divisor),w
	skipnz
	goto	u2321
	goto	u2320
u2321:
	goto	l2878
u2320:
	line	11
	
l2860:	
	clrf	(___lwdiv@counter)
	bsf	status,0
	rlf	(___lwdiv@counter),f
	line	12
	goto	l2866
	
l1414:	
	line	13
	
l2862:	
	movlw	01h
	
u2335:
	clrc
	rlf	(___lwdiv@divisor),f
	rlf	(___lwdiv@divisor+1),f
	addlw	-1
	skipz
	goto	u2335
	line	14
	
l2864:	
	movlw	(01h)
	movwf	(??___lwdiv+0)+0
	movf	(??___lwdiv+0)+0,w
	addwf	(___lwdiv@counter),f
	goto	l2866
	line	15
	
l1413:	
	line	12
	
l2866:	
	btfss	(___lwdiv@divisor+1),(15)&7
	goto	u2341
	goto	u2340
u2341:
	goto	l2862
u2340:
	goto	l2868
	
l1415:	
	goto	l2868
	line	16
	
l1416:	
	line	17
	
l2868:	
	movlw	01h
	
u2355:
	clrc
	rlf	(___lwdiv@quotient),f
	rlf	(___lwdiv@quotient+1),f
	addlw	-1
	skipz
	goto	u2355
	line	18
	movf	(___lwdiv@divisor+1),w
	subwf	(___lwdiv@dividend+1),w
	skipz
	goto	u2365
	movf	(___lwdiv@divisor),w
	subwf	(___lwdiv@dividend),w
u2365:
	skipc
	goto	u2361
	goto	u2360
u2361:
	goto	l2874
u2360:
	line	19
	
l2870:	
	movf	(___lwdiv@divisor),w
	subwf	(___lwdiv@dividend),f
	movf	(___lwdiv@divisor+1),w
	skipc
	decf	(___lwdiv@dividend+1),f
	subwf	(___lwdiv@dividend+1),f
	line	20
	
l2872:	
	bsf	(___lwdiv@quotient)+(0/8),(0)&7
	goto	l2874
	line	21
	
l1417:	
	line	22
	
l2874:	
	movlw	01h
	
u2375:
	clrc
	rrf	(___lwdiv@divisor+1),f
	rrf	(___lwdiv@divisor),f
	addlw	-1
	skipz
	goto	u2375
	line	23
	
l2876:	
	movlw	low(01h)
	subwf	(___lwdiv@counter),f
	btfss	status,2
	goto	u2381
	goto	u2380
u2381:
	goto	l2868
u2380:
	goto	l2878
	
l1418:	
	goto	l2878
	line	24
	
l1412:	
	line	25
	
l2878:	
	movf	(___lwdiv@quotient+1),w
	clrf	(?___lwdiv+1)
	addwf	(?___lwdiv+1)
	movf	(___lwdiv@quotient),w
	clrf	(?___lwdiv)
	addwf	(?___lwdiv)

	goto	l1419
	
l2880:	
	line	26
	
l1419:	
	return
	opt stack 0
GLOBAL	__end_of___lwdiv
	__end_of___lwdiv:
;; =============== function ___lwdiv ends ============

	signat	___lwdiv,8314
	global	_dat
psect	text200,local,class=CODE,delta=2
global __ptext200
__ptext200:

;; *************** function _dat *****************
;; Defined at:
;;		line 49 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
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
;;		_adc
;; This function uses a non-reentrant model
;;
psect	text200
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	line	49
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 6
; Regs used in _dat: [wreg+status,2+btemp+1]
;dat@b stored from wreg
	movwf	(dat@b)
	line	50
	
l2838:	
;CODE.c: 50: PORTB=b;
	movf	(dat@b),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(6)	;volatile
	line	51
	
l2840:	
;CODE.c: 51: RC0=1;
	bsf	(56/8),(56)&7
	line	52
	
l2842:	
;CODE.c: 52: RC1=0;
	bcf	(57/8),(57)&7
	line	53
	
l2844:	
;CODE.c: 53: RC2=1;
	bsf	(58/8),(58)&7
	line	54
	
l2846:	
;CODE.c: 54: for(i=0;i<=1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l2848:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E9h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2305
	movlw	low(03E9h)
	subwf	(_i),w
u2305:

	skipc
	goto	u2301
	goto	u2300
u2301:
	goto	l2852
u2300:
	goto	l710
	
l2850:	
	goto	l710
	
l709:	
	
l2852:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l2854:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E9h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2315
	movlw	low(03E9h)
	subwf	(_i),w
u2315:

	skipc
	goto	u2311
	goto	u2310
u2311:
	goto	l2852
u2310:
	
l710:	
	line	55
;CODE.c: 55: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	56
	
l711:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
	global	_cmd
psect	text201,local,class=CODE,delta=2
global __ptext201
__ptext201:

;; *************** function _cmd *****************
;; Defined at:
;;		line 39 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
;; Parameters:    Size  Location     Type
;;  a               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  a               1    0[COMMON] unsigned char 
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
;;		_main
;;		_lcd_int
;; This function uses a non-reentrant model
;;
psect	text201
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\ADC\ADC LCD\CODE.c"
	line	39
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 7
; Regs used in _cmd: [wreg+status,2+btemp+1]
;cmd@a stored from wreg
	movwf	(cmd@a)
	line	40
	
l2820:	
;CODE.c: 40: PORTB=a;
	movf	(cmd@a),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(6)	;volatile
	line	41
	
l2822:	
;CODE.c: 41: RC0=0;
	bcf	(56/8),(56)&7
	line	42
	
l2824:	
;CODE.c: 42: RC1=0;
	bcf	(57/8),(57)&7
	line	43
	
l2826:	
;CODE.c: 43: RC2=1;
	bsf	(58/8),(58)&7
	line	44
	
l2828:	
;CODE.c: 44: for(i=0;i<=1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l2830:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E9h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2285
	movlw	low(03E9h)
	subwf	(_i),w
u2285:

	skipc
	goto	u2281
	goto	u2280
u2281:
	goto	l2834
u2280:
	goto	l705
	
l2832:	
	goto	l705
	
l704:	
	
l2834:	
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l2836:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E9h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2295
	movlw	low(03E9h)
	subwf	(_i),w
u2295:

	skipc
	goto	u2291
	goto	u2290
u2291:
	goto	l2834
u2290:
	
l705:	
	line	45
;CODE.c: 45: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	46
	
l706:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
psect	text202,local,class=CODE,delta=2
global __ptext202
__ptext202:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
