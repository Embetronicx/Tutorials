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
# 4 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	psect config,class=CONFIG,delta=2 ;#
# 4 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	dw 0xFFFE & 0xFFFB & 0xFFFF & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_lcd_init
	FNCALL	_main,_show
	FNCALL	_main,_cmd
	FNCALL	_main,_rtc_int
	FNCALL	_main,_rtc_read_byte
	FNCALL	_main,_convup
	FNCALL	_main,_dat
	FNCALL	_main,_convd
	FNCALL	_rtc_read_byte,_rtc_res
	FNCALL	_rtc_read_byte,_waitmssp
	FNCALL	_rtc_read_byte,_rtc_send
	FNCALL	_rtc_read_byte,_rtc_read
	FNCALL	_rtc_read_byte,_rtc_nak
	FNCALL	_rtc_read_byte,_rtc_stop
	FNCALL	_rtc_nak,_waitmssp
	FNCALL	_rtc_res,_waitmssp
	FNCALL	_rtc_read,_waitmssp
	FNCALL	_rtc_stop,_waitmssp
	FNCALL	_rtc_send,_waitmssp
	FNCALL	_show,_dat
	FNCALL	_lcd_init,_cmd
	FNROOT	_main
	global	_i
	global	_date
	global	_day
	global	_hour
	global	_min
	global	_month
	global	_sec
	global	_year
	global	_PORTD
psect	text213,local,class=CODE,delta=2
global __ptext213
__ptext213:
_PORTD	set	8
	global	_SSPBUF
_SSPBUF	set	19
	global	_SSPCON
_SSPCON	set	20
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
	global	_SSPIF
_SSPIF	set	99
	global	_SSPADD
_SSPADD	set	147
	global	_TRISB
_TRISB	set	134
	global	_TRISD
_TRISD	set	136
	global	_ACKDT
_ACKDT	set	1165
	global	_ACKEN
_ACKEN	set	1164
	global	_ACKSTAT
_ACKSTAT	set	1166
	global	_PEN
_PEN	set	1162
	global	_RCEN
_RCEN	set	1163
	global	_RSEN
_RSEN	set	1161
	global	_SEN
_SEN	set	1160
	global	_TRISC3
_TRISC3	set	1083
	global	_TRISC4
_TRISC4	set	1084
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
	retlw	58	;':'
	retlw	0
psect	strings
	
STR_2:	
	retlw	68	;'D'
	retlw	97	;'a'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	58	;':'
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

_date:
       ds      1

_day:
       ds      1

_hour:
       ds      1

_min:
       ds      1

_month:
       ds      1

_sec:
       ds      1

_year:
       ds      1

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
	clrf	((__pbssCOMMON)+4)&07Fh
	clrf	((__pbssCOMMON)+5)&07Fh
	clrf	((__pbssCOMMON)+6)&07Fh
	clrf	((__pbssCOMMON)+7)&07Fh
	clrf	((__pbssCOMMON)+8)&07Fh
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
	global	??_cmd
??_cmd:	; 0 bytes @ 0x0
	global	?_rtc_int
?_rtc_int:	; 0 bytes @ 0x0
	global	??_rtc_int
??_rtc_int:	; 0 bytes @ 0x0
	global	??_convup
??_convup:	; 0 bytes @ 0x0
	global	??_convd
??_convd:	; 0 bytes @ 0x0
	global	?_rtc_stop
?_rtc_stop:	; 0 bytes @ 0x0
	global	??_rtc_stop
??_rtc_stop:	; 0 bytes @ 0x0
	global	?_rtc_res
?_rtc_res:	; 0 bytes @ 0x0
	global	??_rtc_res
??_rtc_res:	; 0 bytes @ 0x0
	global	?_rtc_nak
?_rtc_nak:	; 0 bytes @ 0x0
	global	??_rtc_nak
??_rtc_nak:	; 0 bytes @ 0x0
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
	global	?_waitmssp
?_waitmssp:	; 0 bytes @ 0x0
	global	??_waitmssp
??_waitmssp:	; 0 bytes @ 0x0
	global	?_rtc_send
?_rtc_send:	; 0 bytes @ 0x0
	global	??_rtc_send
??_rtc_send:	; 0 bytes @ 0x0
	global	??_rtc_read
??_rtc_read:	; 0 bytes @ 0x0
	global	?_rtc_read_byte
?_rtc_read_byte:	; 1 bytes @ 0x0
	global	?_convup
?_convup:	; 1 bytes @ 0x0
	global	?_convd
?_convd:	; 1 bytes @ 0x0
	global	?_rtc_read
?_rtc_read:	; 1 bytes @ 0x0
	global	cmd@a
cmd@a:	; 1 bytes @ 0x0
	global	dat@b
dat@b:	; 1 bytes @ 0x0
	global	rtc_send@a
rtc_send@a:	; 1 bytes @ 0x0
	global	convd@bcd
convd@bcd:	; 1 bytes @ 0x0
	ds	1
	global	??_rtc_read_byte
??_rtc_read_byte:	; 0 bytes @ 0x1
	global	??_lcd_init
??_lcd_init:	; 0 bytes @ 0x1
	global	??_show
??_show:	; 0 bytes @ 0x1
	global	convup@bcd
convup@bcd:	; 1 bytes @ 0x1
	ds	1
	global	show@s
show@s:	; 1 bytes @ 0x2
	global	rtc_read_byte@addr
rtc_read_byte@addr:	; 1 bytes @ 0x2
	ds	1
	global	rtc_read_byte@rec
rtc_read_byte@rec:	; 1 bytes @ 0x3
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x4
	ds	1
;;Data sizes: Strings 12, constant 0, data 0, bss 9, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      5      14
;; BANK0           80      0       0
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; show@s	PTR unsigned char  size(1) Largest target is 6
;;		 -> STR_2(CODE[6]), STR_1(CODE[6]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_rtc_read_byte
;;   _rtc_read_byte->_rtc_send
;;   _show->_dat
;;   _lcd_init->_cmd
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
;; (0) _main                                                 1     1      0     165
;;                                              4 COMMON     1     1      0
;;                           _lcd_init
;;                               _show
;;                                _cmd
;;                            _rtc_int
;;                      _rtc_read_byte
;;                             _convup
;;                                _dat
;;                              _convd
;; ---------------------------------------------------------------------------------
;; (1) _rtc_read_byte                                        3     3      0      45
;;                                              1 COMMON     3     3      0
;;                            _rtc_res
;;                           _waitmssp
;;                           _rtc_send
;;                           _rtc_read
;;                            _rtc_nak
;;                           _rtc_stop
;; ---------------------------------------------------------------------------------
;; (2) _rtc_nak                                              0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _rtc_res                                              0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _rtc_read                                             0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _rtc_stop                                             0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _rtc_send                                             1     1      0      15
;;                                              0 COMMON     1     1      0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (1) _show                                                 2     2      0      45
;;                                              1 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             0     0      0      15
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (3) _waitmssp                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _convd                                                1     1      0      15
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (1) _convup                                               2     2      0      15
;;                                              0 COMMON     2     2      0
;; ---------------------------------------------------------------------------------
;; (1) _rtc_int                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _dat                                                  1     1      0      15
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  1     1      0      15
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 3
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _lcd_init
;;     _cmd
;;   _show
;;     _dat
;;   _cmd
;;   _rtc_int
;;   _rtc_read_byte
;;     _rtc_res
;;       _waitmssp
;;     _waitmssp
;;     _rtc_send
;;       _waitmssp
;;     _rtc_read
;;       _waitmssp
;;     _rtc_nak
;;       _waitmssp
;;     _rtc_stop
;;       _waitmssp
;;   _convup
;;   _dat
;;   _convd
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      5       E       1      100.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       3       2        0.0%
;;ABS                  0      0       E       3        0.0%
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
;;DATA                 0      0      11      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 25 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
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
;;      Temps:          1       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_lcd_init
;;		_show
;;		_cmd
;;		_rtc_int
;;		_rtc_read_byte
;;		_convup
;;		_dat
;;		_convd
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	25
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 5
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	26
	
l2817:	
;code.c: 26: lcd_init();
	fcall	_lcd_init
	line	28
	
l2819:	
;code.c: 28: show("Time:");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	line	29
	
l2821:	
;code.c: 29: cmd(0xc0);
	movlw	(0C0h)
	fcall	_cmd
	line	30
;code.c: 30: show("Date:");
	movlw	((STR_2-__stringbase))&0ffh
	fcall	_show
	line	31
	
l2823:	
;code.c: 31: rtc_int();
	fcall	_rtc_int
	goto	l2825
	line	32
;code.c: 32: while(1) {
	
l738:	
	line	33
	
l2825:	
;code.c: 33: sec =rtc_read_byte(0x00);
	movlw	(0)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_sec)
	line	34
	
l2827:	
;code.c: 34: min =rtc_read_byte(0x01);
	movlw	(01h)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_min)
	line	35
	
l2829:	
;code.c: 35: hour =rtc_read_byte(0x02);
	movlw	(02h)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_hour)
	line	36
	
l2831:	
;code.c: 36: day =rtc_read_byte(0x03);
	movlw	(03h)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_day)
	line	37
	
l2833:	
;code.c: 37: date =rtc_read_byte(0x04);
	movlw	(04h)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_date)
	line	38
	
l2835:	
;code.c: 38: month=rtc_read_byte(0x05);
	movlw	(05h)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_month)
	line	39
	
l2837:	
;code.c: 39: year =rtc_read_byte(0x06);
	movlw	(06h)
	fcall	_rtc_read_byte
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_year)
	line	41
	
l2839:	
;code.c: 41: cmd(0x85);
	movlw	(085h)
	fcall	_cmd
	line	42
	
l2841:	
;code.c: 42: dat(convup(hour));
	movf	(_hour),w
	fcall	_convup
	fcall	_dat
	line	43
	
l2843:	
;code.c: 43: dat(convd(hour));
	movf	(_hour),w
	fcall	_convd
	fcall	_dat
	line	44
	
l2845:	
;code.c: 44: dat(':');
	movlw	(03Ah)
	fcall	_dat
	line	45
	
l2847:	
;code.c: 45: dat(convup(min));
	movf	(_min),w
	fcall	_convup
	fcall	_dat
	line	46
	
l2849:	
;code.c: 46: dat(convd(min));
	movf	(_min),w
	fcall	_convd
	fcall	_dat
	line	47
	
l2851:	
;code.c: 47: dat(':');
	movlw	(03Ah)
	fcall	_dat
	line	48
	
l2853:	
;code.c: 48: dat(convup(sec));
	movf	(_sec),w
	fcall	_convup
	fcall	_dat
	line	49
	
l2855:	
;code.c: 49: dat(convd(sec));
	movf	(_sec),w
	fcall	_convd
	fcall	_dat
	line	51
	
l2857:	
;code.c: 51: cmd(0xc5);
	movlw	(0C5h)
	fcall	_cmd
	line	52
	
l2859:	
;code.c: 52: dat(convup(date));
	movf	(_date),w
	fcall	_convup
	fcall	_dat
	line	53
	
l2861:	
;code.c: 53: dat(convd(date));
	movf	(_date),w
	fcall	_convd
	fcall	_dat
	line	54
	
l2863:	
;code.c: 54: dat(':');
	movlw	(03Ah)
	fcall	_dat
	line	55
	
l2865:	
;code.c: 55: dat(convup(month));
	movf	(_month),w
	fcall	_convup
	fcall	_dat
	line	56
	
l2867:	
;code.c: 56: dat(convd(month));
	movf	(_month),w
	fcall	_convd
	fcall	_dat
	line	57
	
l2869:	
;code.c: 57: dat(':');
	movlw	(03Ah)
	fcall	_dat
	line	58
	
l2871:	
;code.c: 58: dat(convup(year));
	movf	(_year),w
	fcall	_convup
	fcall	_dat
	line	59
	
l2873:	
;code.c: 59: dat(convd(year));
	movf	(_year),w
	fcall	_convd
	fcall	_dat
	line	60
	
l2875:	
;code.c: 60: dat('/');
	movlw	(02Fh)
	fcall	_dat
	line	61
	
l2877:	
;code.c: 61: dat(convup(day));
	movf	(_day),w
	fcall	_convup
	fcall	_dat
	line	62
	
l2879:	
;code.c: 62: dat(convd(day));
	movf	(_day),w
	fcall	_convd
	fcall	_dat
	goto	l2825
	line	64
	
l739:	
	line	32
	goto	l2825
	
l740:	
	line	65
	
l741:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_rtc_read_byte
psect	text214,local,class=CODE,delta=2
global __ptext214
__ptext214:

;; *************** function _rtc_read_byte *****************
;; Defined at:
;;		line 106 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;  addr            1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  addr            1    2[COMMON] unsigned char 
;;  rec             1    3[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_rtc_res
;;		_waitmssp
;;		_rtc_send
;;		_rtc_read
;;		_rtc_nak
;;		_rtc_stop
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text214
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	106
	global	__size_of_rtc_read_byte
	__size_of_rtc_read_byte	equ	__end_of_rtc_read_byte-_rtc_read_byte
	
_rtc_read_byte:	
	opt	stack 5
; Regs used in _rtc_read_byte: [wreg+status,2+status,0+pclath+cstack]
;rtc_read_byte@addr stored from wreg
	movwf	(rtc_read_byte@addr)
	line	108
;code.c: 107: unsigned char rec;
;code.c: 108: L: rtc_res();
	
l765:	
	
l2797:	
	fcall	_rtc_res
	line	109
	
l2799:	
;code.c: 109: SSPBUF=0xD0;
	movlw	(0D0h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(19)	;volatile
	line	110
	
l2801:	
;code.c: 110: waitmssp();
	fcall	_waitmssp
	line	111
;code.c: 111: while(ACKSTAT){goto L;}
	goto	l766
	
l767:	
	goto	l765
	
l766:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u2321
	goto	u2320
u2321:
	goto	l765
u2320:
	goto	l2803
	
l768:	
	line	113
	
l2803:	
;code.c: 113: rtc_send(addr);
	movf	(rtc_read_byte@addr),w
	fcall	_rtc_send
	line	114
	
l2805:	
;code.c: 114: rtc_res();
	fcall	_rtc_res
	line	115
	
l2807:	
;code.c: 115: rtc_send(0xD1);
	movlw	(0D1h)
	fcall	_rtc_send
	line	116
	
l2809:	
;code.c: 116: rec=rtc_read();
	fcall	_rtc_read
	movwf	(??_rtc_read_byte+0)+0
	movf	(??_rtc_read_byte+0)+0,w
	movwf	(rtc_read_byte@rec)
	line	117
	
l2811:	
;code.c: 117: rtc_nak();
	fcall	_rtc_nak
	line	118
	
l2813:	
;code.c: 118: rtc_stop();
	fcall	_rtc_stop
	line	119
;code.c: 119: return rec;
	movf	(rtc_read_byte@rec),w
	goto	l769
	
l2815:	
	line	120
	
l769:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_read_byte
	__end_of_rtc_read_byte:
;; =============== function _rtc_read_byte ends ============

	signat	_rtc_read_byte,4217
	global	_rtc_nak
psect	text215,local,class=CODE,delta=2
global __ptext215
__ptext215:

;; *************** function _rtc_nak *****************
;; Defined at:
;;		line 149 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		status,2, status,0, pclath, cstack
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
;;		_waitmssp
;; This function is called by:
;;		_rtc_read_byte
;; This function uses a non-reentrant model
;;
psect	text215
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	149
	global	__size_of_rtc_nak
	__size_of_rtc_nak	equ	__end_of_rtc_nak-_rtc_nak
	
_rtc_nak:	
	opt	stack 5
; Regs used in _rtc_nak: [status,2+status,0+pclath+cstack]
	line	150
	
l2793:	
;code.c: 150: ACKDT=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1165/8)^080h,(1165)&7
	line	151
;code.c: 151: ACKEN=1;
	bsf	(1164/8)^080h,(1164)&7
	line	152
	
l2795:	
;code.c: 152: waitmssp();
	fcall	_waitmssp
	line	153
	
l784:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_nak
	__end_of_rtc_nak:
;; =============== function _rtc_nak ends ============

	signat	_rtc_nak,88
	global	_rtc_res
psect	text216,local,class=CODE,delta=2
global __ptext216
__ptext216:

;; *************** function _rtc_res *****************
;; Defined at:
;;		line 136 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		status,2, status,0, pclath, cstack
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
;;		_waitmssp
;; This function is called by:
;;		_rtc_read_byte
;; This function uses a non-reentrant model
;;
psect	text216
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	136
	global	__size_of_rtc_res
	__size_of_rtc_res	equ	__end_of_rtc_res-_rtc_res
	
_rtc_res:	
	opt	stack 5
; Regs used in _rtc_res: [status,2+status,0+pclath+cstack]
	line	137
	
l2789:	
;code.c: 137: RSEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1161/8)^080h,(1161)&7
	line	138
	
l2791:	
;code.c: 138: waitmssp();
	fcall	_waitmssp
	line	139
	
l778:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_res
	__end_of_rtc_res:
;; =============== function _rtc_res ends ============

	signat	_rtc_res,88
	global	_rtc_read
psect	text217,local,class=CODE,delta=2
global __ptext217
__ptext217:

;; *************** function _rtc_read *****************
;; Defined at:
;;		line 99 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
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
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_waitmssp
;; This function is called by:
;;		_rtc_read_byte
;; This function uses a non-reentrant model
;;
psect	text217
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	99
	global	__size_of_rtc_read
	__size_of_rtc_read	equ	__end_of_rtc_read-_rtc_read
	
_rtc_read:	
	opt	stack 5
; Regs used in _rtc_read: [wreg+status,2+status,0+pclath+cstack]
	line	100
	
l2781:	
;code.c: 100: RCEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1163/8)^080h,(1163)&7
	line	101
	
l2783:	
;code.c: 101: waitmssp();
	fcall	_waitmssp
	line	102
	
l2785:	
;code.c: 102: return SSPBUF;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(19),w	;volatile
	goto	l762
	
l2787:	
	line	103
	
l762:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_read
	__end_of_rtc_read:
;; =============== function _rtc_read ends ============

	signat	_rtc_read,89
	global	_rtc_stop
psect	text218,local,class=CODE,delta=2
global __ptext218
__ptext218:

;; *************** function _rtc_stop *****************
;; Defined at:
;;		line 130 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		status,2, status,0, pclath, cstack
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
;;		_waitmssp
;; This function is called by:
;;		_rtc_read_byte
;;		_rtc_send_byte
;; This function uses a non-reentrant model
;;
psect	text218
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	130
	global	__size_of_rtc_stop
	__size_of_rtc_stop	equ	__end_of_rtc_stop-_rtc_stop
	
_rtc_stop:	
	opt	stack 5
; Regs used in _rtc_stop: [status,2+status,0+pclath+cstack]
	line	131
	
l2777:	
;code.c: 131: PEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1162/8)^080h,(1162)&7
	line	132
	
l2779:	
;code.c: 132: waitmssp();
	fcall	_waitmssp
	line	133
	
l775:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_stop
	__end_of_rtc_stop:
;; =============== function _rtc_stop ends ============

	signat	_rtc_stop,88
	global	_rtc_send
psect	text219,local,class=CODE,delta=2
global __ptext219
__ptext219:

;; *************** function _rtc_send *****************
;; Defined at:
;;		line 82 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;  a               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  a               1    0[COMMON] unsigned char 
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
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_waitmssp
;; This function is called by:
;;		_rtc_read_byte
;;		_rtc_send_byte
;; This function uses a non-reentrant model
;;
psect	text219
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	82
	global	__size_of_rtc_send
	__size_of_rtc_send	equ	__end_of_rtc_send-_rtc_send
	
_rtc_send:	
	opt	stack 5
; Regs used in _rtc_send: [wreg+status,2+status,0+pclath+cstack]
;rtc_send@a stored from wreg
	movwf	(rtc_send@a)
	line	83
	
l2773:	
;code.c: 83: SSPBUF=a;
	movf	(rtc_send@a),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(19)	;volatile
	line	84
	
l2775:	
;code.c: 84: waitmssp();
	fcall	_waitmssp
	line	85
;code.c: 85: while(ACKSTAT);
	goto	l753
	
l754:	
	
l753:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u2311
	goto	u2310
u2311:
	goto	l753
u2310:
	goto	l756
	
l755:	
	line	86
	
l756:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_send
	__end_of_rtc_send:
;; =============== function _rtc_send ends ============

	signat	_rtc_send,4216
	global	_show
psect	text220,local,class=CODE,delta=2
global __ptext220
__ptext220:

;; *************** function _show *****************
;; Defined at:
;;		line 43 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_2(6), STR_1(6), 
;; Auto vars:     Size  Location     Type
;;  s               1    2[COMMON] PTR unsigned char 
;;		 -> STR_2(6), STR_1(6), 
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
psect	text220
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
	line	43
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 6
; Regs used in _show: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	44
	
l2765:	
;lcd.h: 44: while(*s) {
	goto	l2771
	
l733:	
	line	45
	
l2767:	
;lcd.h: 45: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
l2769:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	l2771
	line	46
	
l732:	
	line	44
	
l2771:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2301
	goto	u2300
u2301:
	goto	l2767
u2300:
	goto	l735
	
l734:	
	line	47
	
l735:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	_lcd_init
psect	text221,local,class=CODE,delta=2
global __ptext221
__ptext221:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 14 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
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
psect	text221
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
	line	14
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 6
; Regs used in _lcd_init: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	15
	
l2755:	
;lcd.h: 15: TRISD=TRISB=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(134)^080h	;volatile
	clrf	(136)^080h	;volatile
	line	16
	
l2757:	
;lcd.h: 16: cmd(0x38);
	movlw	(038h)
	fcall	_cmd
	line	17
	
l2759:	
;lcd.h: 17: cmd(0x0c);
	movlw	(0Ch)
	fcall	_cmd
	line	18
	
l2761:	
;lcd.h: 18: cmd(0x06);
	movlw	(06h)
	fcall	_cmd
	line	19
	
l2763:	
;lcd.h: 19: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	20
	
l719:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_waitmssp
psect	text222,local,class=CODE,delta=2
global __ptext222
__ptext222:

;; *************** function _waitmssp *****************
;; Defined at:
;;		line 76 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
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
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_rtc_send
;;		_rtc_read
;;		_rtc_read_byte
;;		_rtc_stop
;;		_rtc_res
;;		_rtc_nak
;;		_rtc_start
;;		_rtc_ack
;; This function uses a non-reentrant model
;;
psect	text222
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	76
	global	__size_of_waitmssp
	__size_of_waitmssp	equ	__end_of_waitmssp-_waitmssp
	
_waitmssp:	
	opt	stack 5
; Regs used in _waitmssp: []
	line	77
	
l1885:	
;code.c: 77: while(!SSPIF);
	goto	l747
	
l748:	
	
l747:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(99/8),(99)&7
	goto	u81
	goto	u80
u81:
	goto	l747
u80:
	
l749:	
	line	78
;code.c: 78: SSPIF=0;
	bcf	(99/8),(99)&7
	line	79
	
l750:	
	return
	opt stack 0
GLOBAL	__end_of_waitmssp
	__end_of_waitmssp:
;; =============== function _waitmssp ends ============

	signat	_waitmssp,88
	global	_convd
psect	text223,local,class=CODE,delta=2
global __ptext223
__ptext223:

;; *************** function _convd *****************
;; Defined at:
;;		line 161 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;  bcd             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  bcd             1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0
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
;; This function uses a non-reentrant model
;;
psect	text223
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	161
	global	__size_of_convd
	__size_of_convd	equ	__end_of_convd-_convd
	
_convd:	
	opt	stack 7
; Regs used in _convd: [wreg+status,2+status,0]
;convd@bcd stored from wreg
	movwf	(convd@bcd)
	line	162
	
l1881:	
;code.c: 162: return ((bcd&0x0F)+48);
	movf	(convd@bcd),w
	andlw	0Fh
	addlw	030h
	goto	l790
	
l1883:	
	line	163
	
l790:	
	return
	opt stack 0
GLOBAL	__end_of_convd
	__end_of_convd:
;; =============== function _convd ends ============

	signat	_convd,4217
	global	_convup
psect	text224,local,class=CODE,delta=2
global __ptext224
__ptext224:

;; *************** function _convup *****************
;; Defined at:
;;		line 156 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
;; Parameters:    Size  Location     Type
;;  bcd             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  bcd             1    1[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0
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
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text224
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	156
	global	__size_of_convup
	__size_of_convup	equ	__end_of_convup-_convup
	
_convup:	
	opt	stack 7
; Regs used in _convup: [wreg+status,2+status,0]
;convup@bcd stored from wreg
	movwf	(convup@bcd)
	line	157
	
l1877:	
;code.c: 157: return ((bcd>>4)+48);
	movf	(convup@bcd),w
	movwf	(??_convup+0)+0
	movlw	04h
u75:
	clrc
	rrf	(??_convup+0)+0,f
	addlw	-1
	skipz
	goto	u75
	movf	0+(??_convup+0)+0,w
	addlw	030h
	goto	l787
	
l1879:	
	line	158
	
l787:	
	return
	opt stack 0
GLOBAL	__end_of_convup
	__end_of_convup:
;; =============== function _convup ends ============

	signat	_convup,4217
	global	_rtc_int
psect	text225,local,class=CODE,delta=2
global __ptext225
__ptext225:

;; *************** function _rtc_int *****************
;; Defined at:
;;		line 69 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
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
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text225
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\code.c"
	line	69
	global	__size_of_rtc_int
	__size_of_rtc_int	equ	__end_of_rtc_int-_rtc_int
	
_rtc_int:	
	opt	stack 7
; Regs used in _rtc_int: [wreg]
	line	70
	
l1873:	
;code.c: 70: TRISC3=TRISC4=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1084/8)^080h,(1084)&7
	btfsc	(1084/8)^080h,(1084)&7
	goto	u51
	goto	u50
	
u51:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1083/8)^080h,(1083)&7
	goto	u64
u50:
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1083/8)^080h,(1083)&7
u64:
	line	71
	
l1875:	
;code.c: 71: SSPCON=0x28;
	movlw	(028h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(20)	;volatile
	line	72
;code.c: 72: SSPADD= (((11059200/4)/100)-1);
	movlw	(0FFh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(147)^080h	;volatile
	line	73
	
l744:	
	return
	opt stack 0
GLOBAL	__end_of_rtc_int
	__end_of_rtc_int:
;; =============== function _rtc_int ends ============

	signat	_rtc_int,88
	global	_dat
psect	text226,local,class=CODE,delta=2
global __ptext226
__ptext226:

;; *************** function _dat *****************
;; Defined at:
;;		line 33 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
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
;;		_main
;; This function uses a non-reentrant model
;;
psect	text226
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
	line	33
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 7
; Regs used in _dat: [wreg+status,2+btemp+1]
;dat@b stored from wreg
	movwf	(dat@b)
	line	34
	
l1855:	
;lcd.h: 34: PORTD=b;
	movf	(dat@b),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	35
	
l1857:	
;lcd.h: 35: RB0=1;
	bsf	(48/8),(48)&7
	line	36
	
l1859:	
;lcd.h: 36: RB1=0;
	bcf	(49/8),(49)&7
	line	37
	
l1861:	
;lcd.h: 37: RB2=1;
	bsf	(50/8),(50)&7
	line	38
	
l1863:	
;lcd.h: 38: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l1865:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u35
	movlw	low(03E8h)
	subwf	(_i),w
u35:

	skipc
	goto	u31
	goto	u30
u31:
	goto	l1869
u30:
	goto	l728
	
l1867:	
	goto	l728
	
l727:	
	
l1869:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l1871:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u45
	movlw	low(03E8h)
	subwf	(_i),w
u45:

	skipc
	goto	u41
	goto	u40
u41:
	goto	l1869
u40:
	
l728:	
	line	39
;lcd.h: 39: RB2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(50/8),(50)&7
	line	40
	
l729:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
	global	_cmd
psect	text227,local,class=CODE,delta=2
global __ptext227
__ptext227:

;; *************** function _cmd *****************
;; Defined at:
;;		line 23 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
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
;;		_lcd_init
;;		_main
;; This function uses a non-reentrant model
;;
psect	text227
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\RTC\lcd.h"
	line	23
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 7
; Regs used in _cmd: [wreg+status,2+btemp+1]
;cmd@a stored from wreg
	movwf	(cmd@a)
	line	24
	
l1837:	
;lcd.h: 24: PORTD=a;
	movf	(cmd@a),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	25
	
l1839:	
;lcd.h: 25: RB0=0;
	bcf	(48/8),(48)&7
	line	26
	
l1841:	
;lcd.h: 26: RB1=0;
	bcf	(49/8),(49)&7
	line	27
	
l1843:	
;lcd.h: 27: RB2=1;
	bsf	(50/8),(50)&7
	line	28
	
l1845:	
;lcd.h: 28: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l1847:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u15
	movlw	low(03E8h)
	subwf	(_i),w
u15:

	skipc
	goto	u11
	goto	u10
u11:
	goto	l1851
u10:
	goto	l723
	
l1849:	
	goto	l723
	
l722:	
	
l1851:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l1853:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03E8h))^80h
	subwf	btemp+1,w
	skipz
	goto	u25
	movlw	low(03E8h)
	subwf	(_i),w
u25:

	skipc
	goto	u21
	goto	u20
u21:
	goto	l1851
u20:
	
l723:	
	line	29
;lcd.h: 29: RB2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(50/8),(50)&7
	line	30
	
l724:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
psect	text228,local,class=CODE,delta=2
global __ptext228
__ptext228:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
