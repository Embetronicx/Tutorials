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
# 5 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\code.c"
	psect config,class=CONFIG,delta=2 ;#
# 5 "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\code.c"
	dw 0xFFFE & 0xFFFB & 0xFFFF & 0xFFFF & 0xFFFF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_lcd_init
	FNCALL	_main,_i2c_init
	FNCALL	_main,_show
	FNCALL	_main,_cmd
	FNCALL	_main,_i2c_send_byte
	FNCALL	_main,_delay1
	FNCALL	_main,_i2c_read_byte
	FNCALL	_main,_dat
	FNCALL	_i2c_read_byte,_i2c_restart
	FNCALL	_i2c_read_byte,_waitmssp
	FNCALL	_i2c_read_byte,_i2c_send
	FNCALL	_i2c_read_byte,_i2c_read
	FNCALL	_i2c_read_byte,_i2c_nak
	FNCALL	_i2c_read_byte,_i2c_stop
	FNCALL	_i2c_send_byte,_i2c_start
	FNCALL	_i2c_send_byte,_i2c_send
	FNCALL	_i2c_send_byte,_i2c_stop
	FNCALL	_i2c_read,_waitmssp
	FNCALL	_i2c_send,_waitmssp
	FNCALL	_i2c_nak,_waitmssp
	FNCALL	_i2c_restart,_waitmssp
	FNCALL	_i2c_stop,_waitmssp
	FNCALL	_i2c_start,_waitmssp
	FNCALL	_show,_dat
	FNCALL	_lcd_init,_cmd
	FNROOT	_main
	global	_i
	global	_PORTB
psect	text222,local,class=CODE,delta=2
global __ptext222
__ptext222:
_PORTB	set	6
	global	_SSPBUF
_SSPBUF	set	19
	global	_SSPCON
_SSPCON	set	20
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
	global	_SSPIF
_SSPIF	set	99
	global	_SSPADD
_SSPADD	set	147
	global	_TRISB
_TRISB	set	134
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
	global	_TRISC0
_TRISC0	set	1080
	global	_TRISC1
_TRISC1	set	1081
	global	_TRISC2
_TRISC2	set	1082
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
	retlw	32	;' '
	retlw	32	;' '
	retlw	73	;'I'
	retlw	50	;'2'
	retlw	67	;'C'
	retlw	32	;' '
	retlw	84	;'T'
	retlw	117	;'u'
	retlw	84	;'T'
	retlw	111	;'o'
	retlw	114	;'r'
	retlw	105	;'i'
	retlw	97	;'a'
	retlw	108	;'l'
	retlw	32	;' '
	retlw	32	;' '
	retlw	0
psect	strings
	
STR_3:	
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
	retlw	0
psect	strings
	
STR_4:	
	retlw	82	;'R'
	retlw	101	;'e'
	retlw	97	;'a'
	retlw	100	;'d'
	retlw	105	;'i'
	retlw	110	;'n'
	retlw	103	;'g'
	retlw	46	;'.'
	retlw	46	;'.'
	retlw	46	;'.'
	retlw	0
psect	strings
	
STR_2:	
	retlw	87	;'W'
	retlw	114	;'r'
	retlw	105	;'i'
	retlw	116	;'t'
	retlw	105	;'i'
	retlw	110	;'n'
	retlw	103	;'g'
	retlw	46	;'.'
	retlw	46	;'.'
	retlw	46	;'.'
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

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
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
	global	?_waitmssp
?_waitmssp:	; 0 bytes @ 0x0
	global	??_waitmssp
??_waitmssp:	; 0 bytes @ 0x0
	global	?_delay1
?_delay1:	; 0 bytes @ 0x0
	global	??_delay1
??_delay1:	; 0 bytes @ 0x0
	global	?_lcd_init
?_lcd_init:	; 0 bytes @ 0x0
	global	?_dat
?_dat:	; 0 bytes @ 0x0
	global	??_dat
??_dat:	; 0 bytes @ 0x0
	global	?_show
?_show:	; 0 bytes @ 0x0
	global	?_i2c_init
?_i2c_init:	; 0 bytes @ 0x0
	global	??_i2c_init
??_i2c_init:	; 0 bytes @ 0x0
	global	?_i2c_start
?_i2c_start:	; 0 bytes @ 0x0
	global	??_i2c_start
??_i2c_start:	; 0 bytes @ 0x0
	global	?_i2c_stop
?_i2c_stop:	; 0 bytes @ 0x0
	global	??_i2c_stop
??_i2c_stop:	; 0 bytes @ 0x0
	global	?_i2c_restart
?_i2c_restart:	; 0 bytes @ 0x0
	global	??_i2c_restart
??_i2c_restart:	; 0 bytes @ 0x0
	global	?_i2c_nak
?_i2c_nak:	; 0 bytes @ 0x0
	global	??_i2c_nak
??_i2c_nak:	; 0 bytes @ 0x0
	global	?_i2c_send
?_i2c_send:	; 0 bytes @ 0x0
	global	??_i2c_send
??_i2c_send:	; 0 bytes @ 0x0
	global	??_i2c_read
??_i2c_read:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_i2c_read
?_i2c_read:	; 1 bytes @ 0x0
	global	?_i2c_read_byte
?_i2c_read_byte:	; 1 bytes @ 0x0
	global	cmd@a
cmd@a:	; 1 bytes @ 0x0
	global	dat@b
dat@b:	; 1 bytes @ 0x0
	global	i2c_send@dat
i2c_send@dat:	; 1 bytes @ 0x0
	global	delay1@j
delay1@j:	; 2 bytes @ 0x0
	ds	1
	global	??_lcd_init
??_lcd_init:	; 0 bytes @ 0x1
	global	??_show
??_show:	; 0 bytes @ 0x1
	global	?_i2c_send_byte
?_i2c_send_byte:	; 0 bytes @ 0x1
	global	??_i2c_read_byte
??_i2c_read_byte:	; 0 bytes @ 0x1
	global	i2c_send_byte@count
i2c_send_byte@count:	; 1 bytes @ 0x1
	ds	1
	global	??_i2c_send_byte
??_i2c_send_byte:	; 0 bytes @ 0x2
	global	show@s
show@s:	; 1 bytes @ 0x2
	global	i2c_read_byte@addr
i2c_read_byte@addr:	; 1 bytes @ 0x2
	global	delay1@k
delay1@k:	; 2 bytes @ 0x2
	ds	1
	global	i2c_send_byte@addr
i2c_send_byte@addr:	; 1 bytes @ 0x3
	global	i2c_read_byte@rec
i2c_read_byte@rec:	; 1 bytes @ 0x3
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x4
	ds	1
;;Data sizes: Strings 51, constant 0, data 0, bss 2, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      5       7
;; BANK0           80      0       0
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; i2c_send_byte@count	PTR unsigned char  size(1) Largest target is 12
;;		 -> STR_3(CODE[12]), 
;;
;; show@s	PTR unsigned char  size(1) Largest target is 17
;;		 -> STR_4(CODE[11]), STR_2(CODE[11]), STR_1(CODE[17]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_i2c_send_byte
;;   _main->_delay1
;;   _main->_i2c_read_byte
;;   _i2c_read_byte->_i2c_send
;;   _i2c_send_byte->_i2c_send
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
;; (0) _main                                                 1     1      0     255
;;                                              4 COMMON     1     1      0
;;                           _lcd_init
;;                           _i2c_init
;;                               _show
;;                                _cmd
;;                      _i2c_send_byte
;;                             _delay1
;;                      _i2c_read_byte
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _i2c_read_byte                                        3     3      0      45
;;                                              1 COMMON     3     3      0
;;                        _i2c_restart
;;                           _waitmssp
;;                           _i2c_send
;;                           _i2c_read
;;                            _i2c_nak
;;                           _i2c_stop
;; ---------------------------------------------------------------------------------
;; (1) _i2c_send_byte                                        3     2      1      60
;;                                              1 COMMON     3     2      1
;;                          _i2c_start
;;                           _i2c_send
;;                           _i2c_stop
;; ---------------------------------------------------------------------------------
;; (2) _i2c_read                                             0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _i2c_send                                             1     1      0      15
;;                                              0 COMMON     1     1      0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _i2c_nak                                              0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _i2c_restart                                          0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _i2c_stop                                             0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (2) _i2c_start                                            0     0      0       0
;;                           _waitmssp
;; ---------------------------------------------------------------------------------
;; (1) _show                                                 2     2      0      45
;;                                              1 COMMON     2     2      0
;;                                _dat
;; ---------------------------------------------------------------------------------
;; (1) _lcd_init                                             0     0      0      15
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _delay1                                               4     4      0      60
;;                                              0 COMMON     4     4      0
;; ---------------------------------------------------------------------------------
;; (3) _waitmssp                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _i2c_init                                             0     0      0       0
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
;;   _i2c_init
;;   _show
;;     _dat
;;   _cmd
;;   _i2c_send_byte
;;     _i2c_start
;;       _waitmssp
;;     _i2c_send
;;       _waitmssp
;;     _i2c_stop
;;       _waitmssp
;;   _delay1
;;   _i2c_read_byte
;;     _i2c_restart
;;       _waitmssp
;;     _waitmssp
;;     _i2c_send
;;       _waitmssp
;;     _i2c_read
;;       _waitmssp
;;     _i2c_nak
;;       _waitmssp
;;     _i2c_stop
;;       _waitmssp
;;   _dat
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      5       7       1       50.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       3       2        0.0%
;;ABS                  0      0       7       3        0.0%
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
;;DATA                 0      0       A      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 10 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\code.c"
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
;;		_i2c_init
;;		_show
;;		_cmd
;;		_i2c_send_byte
;;		_delay1
;;		_i2c_read_byte
;;		_dat
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\code.c"
	line	10
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 5
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	11
	
l2818:	
;code.c: 11: lcd_init();
	fcall	_lcd_init
	line	12
	
l2820:	
;code.c: 12: i2c_init();
	fcall	_i2c_init
	line	13
	
l2822:	
;code.c: 13: show("  I2C TuTorial  ");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_show
	line	14
	
l2824:	
;code.c: 14: cmd(0xc2);
	movlw	(0C2h)
	fcall	_cmd
	line	15
	
l2826:	
;code.c: 15: show("Writing...");
	movlw	((STR_2-__stringbase))&0ffh
	fcall	_show
	line	16
	
l2828:	
;code.c: 16: i2c_send_byte(0x0000,"EmbeTronicX");
	movlw	((STR_3-__stringbase))&0ffh
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(?_i2c_send_byte)
	movlw	(0)
	fcall	_i2c_send_byte
	line	17
	
l2830:	
;code.c: 17: delay1();
	fcall	_delay1
	line	18
	
l2832:	
;code.c: 18: cmd(0xc2);
	movlw	(0C2h)
	fcall	_cmd
	line	19
	
l2834:	
;code.c: 19: show("Reading...");
	movlw	((STR_4-__stringbase))&0ffh
	fcall	_show
	line	20
;code.c: 20: delay1();
	fcall	_delay1
	line	21
	
l2836:	
;code.c: 21: cmd(0xc2);
	movlw	(0C2h)
	fcall	_cmd
	line	22
	
l2838:	
;code.c: 22: dat(i2c_read_byte(0x0000));
	movlw	(0)
	fcall	_i2c_read_byte
	fcall	_dat
	line	23
	
l2840:	
;code.c: 23: dat(i2c_read_byte(0x0001));
	movlw	(01h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	24
	
l2842:	
;code.c: 24: dat(i2c_read_byte(0x0002));
	movlw	(02h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	25
	
l2844:	
;code.c: 25: dat(i2c_read_byte(0x0003));
	movlw	(03h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	26
	
l2846:	
;code.c: 26: dat(i2c_read_byte(0x0004));
	movlw	(04h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	27
	
l2848:	
;code.c: 27: dat(i2c_read_byte(0x0005));
	movlw	(05h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	28
	
l2850:	
;code.c: 28: dat(i2c_read_byte(0x0006));
	movlw	(06h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	29
	
l2852:	
;code.c: 29: dat(i2c_read_byte(0x0007));
	movlw	(07h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	30
	
l2854:	
;code.c: 30: dat(i2c_read_byte(0x0008));
	movlw	(08h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	31
	
l2856:	
;code.c: 31: dat(i2c_read_byte(0x0009));
	movlw	(09h)
	fcall	_i2c_read_byte
	fcall	_dat
	line	32
	
l2858:	
;code.c: 32: dat(i2c_read_byte(0x000a));
	movlw	(0Ah)
	fcall	_i2c_read_byte
	fcall	_dat
	goto	l760
	line	34
;code.c: 34: while(1);
	
l759:	
	
l760:	
	goto	l760
	
l761:	
	line	35
	
l762:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_i2c_read_byte
psect	text223,local,class=CODE,delta=2
global __ptext223
__ptext223:

;; *************** function _i2c_read_byte *****************
;; Defined at:
;;		line 88 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_restart
;;		_waitmssp
;;		_i2c_send
;;		_i2c_read
;;		_i2c_nak
;;		_i2c_stop
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text223
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	88
	global	__size_of_i2c_read_byte
	__size_of_i2c_read_byte	equ	__end_of_i2c_read_byte-_i2c_read_byte
	
_i2c_read_byte:	
	opt	stack 5
; Regs used in _i2c_read_byte: [wreg+status,2+status,0+pclath+cstack]
;i2c_read_byte@addr stored from wreg
	movwf	(i2c_read_byte@addr)
	line	90
;i2c.h: 89: unsigned char rec;
;i2c.h: 90: L: i2c_restart();
	
l752:	
	
l2798:	
	fcall	_i2c_restart
	line	91
	
l2800:	
;i2c.h: 91: SSPBUF=0xA0;
	movlw	(0A0h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(19)	;volatile
	line	92
	
l2802:	
;i2c.h: 92: waitmssp();
	fcall	_waitmssp
	line	93
;i2c.h: 93: while(ACKSTAT){goto L;}
	goto	l753
	
l754:	
	goto	l752
	
l753:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u2361
	goto	u2360
u2361:
	goto	l752
u2360:
	goto	l2804
	
l755:	
	line	94
	
l2804:	
;i2c.h: 94: i2c_send(addr>>8);
	movlw	(0)
	fcall	_i2c_send
	line	95
;i2c.h: 95: i2c_send(addr);
	movf	(i2c_read_byte@addr),w
	fcall	_i2c_send
	line	96
	
l2806:	
;i2c.h: 96: i2c_restart();
	fcall	_i2c_restart
	line	97
	
l2808:	
;i2c.h: 97: i2c_send(0xA1);
	movlw	(0A1h)
	fcall	_i2c_send
	line	98
	
l2810:	
;i2c.h: 98: rec=i2c_read();
	fcall	_i2c_read
	movwf	(??_i2c_read_byte+0)+0
	movf	(??_i2c_read_byte+0)+0,w
	movwf	(i2c_read_byte@rec)
	line	99
	
l2812:	
;i2c.h: 99: i2c_nak();
	fcall	_i2c_nak
	line	100
	
l2814:	
;i2c.h: 100: i2c_stop();
	fcall	_i2c_stop
	line	101
;i2c.h: 101: return rec;
	movf	(i2c_read_byte@rec),w
	goto	l756
	
l2816:	
	line	102
	
l756:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_read_byte
	__end_of_i2c_read_byte:
;; =============== function _i2c_read_byte ends ============

	signat	_i2c_read_byte,4217
	global	_i2c_send_byte
psect	text224,local,class=CODE,delta=2
global __ptext224
__ptext224:

;; *************** function _i2c_send_byte *****************
;; Defined at:
;;		line 69 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
;; Parameters:    Size  Location     Type
;;  addr            1    wreg     unsigned char 
;;  count           1    1[COMMON] PTR unsigned char 
;;		 -> STR_3(12), 
;; Auto vars:     Size  Location     Type
;;  addr            1    3[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         1       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_i2c_start
;;		_i2c_send
;;		_i2c_stop
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text224
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	69
	global	__size_of_i2c_send_byte
	__size_of_i2c_send_byte	equ	__end_of_i2c_send_byte-_i2c_send_byte
	
_i2c_send_byte:	
	opt	stack 5
; Regs used in _i2c_send_byte: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;i2c_send_byte@addr stored from wreg
	movwf	(i2c_send_byte@addr)
	line	70
	
l2782:	
;i2c.h: 70: i2c_start();
	fcall	_i2c_start
	line	71
	
l2784:	
;i2c.h: 71: i2c_send(0xA0);
	movlw	(0A0h)
	fcall	_i2c_send
	line	72
	
l2786:	
;i2c.h: 72: i2c_send(addr>>8);
	movlw	(0)
	fcall	_i2c_send
	line	73
	
l2788:	
;i2c.h: 73: i2c_send(addr);
	movf	(i2c_send_byte@addr),w
	fcall	_i2c_send
	line	74
;i2c.h: 74: while(*count) {
	goto	l2794
	
l744:	
	line	75
	
l2790:	
;i2c.h: 75: i2c_send(*count++);
	movf	(i2c_send_byte@count),w
	movwf	fsr0
	fcall	stringdir
	fcall	_i2c_send
	
l2792:	
	movlw	(01h)
	movwf	(??_i2c_send_byte+0)+0
	movf	(??_i2c_send_byte+0)+0,w
	addwf	(i2c_send_byte@count),f
	goto	l2794
	line	76
	
l743:	
	line	74
	
l2794:	
	movf	(i2c_send_byte@count),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2351
	goto	u2350
u2351:
	goto	l2790
u2350:
	goto	l2796
	
l745:	
	line	77
	
l2796:	
;i2c.h: 76: }
;i2c.h: 77: i2c_stop();
	fcall	_i2c_stop
	line	78
	
l746:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_send_byte
	__end_of_i2c_send_byte:
;; =============== function _i2c_send_byte ends ============

	signat	_i2c_send_byte,8312
	global	_i2c_read
psect	text225,local,class=CODE,delta=2
global __ptext225
__ptext225:

;; *************** function _i2c_read *****************
;; Defined at:
;;		line 81 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_read_byte
;; This function uses a non-reentrant model
;;
psect	text225
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	81
	global	__size_of_i2c_read
	__size_of_i2c_read	equ	__end_of_i2c_read-_i2c_read
	
_i2c_read:	
	opt	stack 5
; Regs used in _i2c_read: [wreg+status,2+status,0+pclath+cstack]
	line	82
	
l2774:	
;i2c.h: 82: RCEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1163/8)^080h,(1163)&7
	line	83
	
l2776:	
;i2c.h: 83: waitmssp();
	fcall	_waitmssp
	line	84
	
l2778:	
;i2c.h: 84: return SSPBUF;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(19),w	;volatile
	goto	l749
	
l2780:	
	line	85
	
l749:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_read
	__end_of_i2c_read:
;; =============== function _i2c_read ends ============

	signat	_i2c_read,89
	global	_i2c_send
psect	text226,local,class=CODE,delta=2
global __ptext226
__ptext226:

;; *************** function _i2c_send *****************
;; Defined at:
;;		line 62 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
;; Parameters:    Size  Location     Type
;;  dat             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  dat             1    0[COMMON] unsigned char 
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
;;		_i2c_send_byte
;;		_i2c_read_byte
;; This function uses a non-reentrant model
;;
psect	text226
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	62
	global	__size_of_i2c_send
	__size_of_i2c_send	equ	__end_of_i2c_send-_i2c_send
	
_i2c_send:	
	opt	stack 5
; Regs used in _i2c_send: [wreg+status,2+status,0+pclath+cstack]
;i2c_send@dat stored from wreg
	movwf	(i2c_send@dat)
	line	63
;i2c.h: 63: L1: SSPBUF=dat;
	
l736:	
	
l2770:	
	movf	(i2c_send@dat),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(19)	;volatile
	line	64
	
l2772:	
;i2c.h: 64: waitmssp();
	fcall	_waitmssp
	line	65
;i2c.h: 65: while(ACKSTAT){i2c_restart;goto L1;}
	goto	l737
	
l738:	
	goto	l736
	
l737:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1166/8)^080h,(1166)&7
	goto	u2341
	goto	u2340
u2341:
	goto	l736
u2340:
	goto	l740
	
l739:	
	line	66
	
l740:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_send
	__end_of_i2c_send:
;; =============== function _i2c_send ends ============

	signat	_i2c_send,4216
	global	_i2c_nak
psect	text227,local,class=CODE,delta=2
global __ptext227
__ptext227:

;; *************** function _i2c_nak *****************
;; Defined at:
;;		line 49 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_read_byte
;; This function uses a non-reentrant model
;;
psect	text227
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	49
	global	__size_of_i2c_nak
	__size_of_i2c_nak	equ	__end_of_i2c_nak-_i2c_nak
	
_i2c_nak:	
	opt	stack 5
; Regs used in _i2c_nak: [status,2+status,0+pclath+cstack]
	line	50
	
l2766:	
;i2c.h: 50: ACKDT=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1165/8)^080h,(1165)&7
	line	51
;i2c.h: 51: ACKEN=1;
	bsf	(1164/8)^080h,(1164)&7
	line	52
	
l2768:	
;i2c.h: 52: waitmssp();
	fcall	_waitmssp
	line	53
	
l727:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_nak
	__end_of_i2c_nak:
;; =============== function _i2c_nak ends ============

	signat	_i2c_nak,88
	global	_i2c_restart
psect	text228,local,class=CODE,delta=2
global __ptext228
__ptext228:

;; *************** function _i2c_restart *****************
;; Defined at:
;;		line 36 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_read_byte
;; This function uses a non-reentrant model
;;
psect	text228
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	36
	global	__size_of_i2c_restart
	__size_of_i2c_restart	equ	__end_of_i2c_restart-_i2c_restart
	
_i2c_restart:	
	opt	stack 5
; Regs used in _i2c_restart: [status,2+status,0+pclath+cstack]
	line	37
	
l2762:	
;i2c.h: 37: RSEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1161/8)^080h,(1161)&7
	line	38
	
l2764:	
;i2c.h: 38: waitmssp();
	fcall	_waitmssp
	line	39
	
l721:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_restart
	__end_of_i2c_restart:
;; =============== function _i2c_restart ends ============

	signat	_i2c_restart,88
	global	_i2c_stop
psect	text229,local,class=CODE,delta=2
global __ptext229
__ptext229:

;; *************** function _i2c_stop *****************
;; Defined at:
;;		line 30 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_send_byte
;;		_i2c_read_byte
;; This function uses a non-reentrant model
;;
psect	text229
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	30
	global	__size_of_i2c_stop
	__size_of_i2c_stop	equ	__end_of_i2c_stop-_i2c_stop
	
_i2c_stop:	
	opt	stack 5
; Regs used in _i2c_stop: [status,2+status,0+pclath+cstack]
	line	31
	
l2758:	
;i2c.h: 31: PEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1162/8)^080h,(1162)&7
	line	32
	
l2760:	
;i2c.h: 32: waitmssp();
	fcall	_waitmssp
	line	33
	
l718:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_stop
	__end_of_i2c_stop:
;; =============== function _i2c_stop ends ============

	signat	_i2c_stop,88
	global	_i2c_start
psect	text230,local,class=CODE,delta=2
global __ptext230
__ptext230:

;; *************** function _i2c_start *****************
;; Defined at:
;;		line 24 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_send_byte
;; This function uses a non-reentrant model
;;
psect	text230
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	24
	global	__size_of_i2c_start
	__size_of_i2c_start	equ	__end_of_i2c_start-_i2c_start
	
_i2c_start:	
	opt	stack 5
; Regs used in _i2c_start: [status,2+status,0+pclath+cstack]
	line	25
	
l2754:	
;i2c.h: 25: SEN=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1160/8)^080h,(1160)&7
	line	26
	
l2756:	
;i2c.h: 26: waitmssp();
	fcall	_waitmssp
	line	27
	
l715:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_start
	__end_of_i2c_start:
;; =============== function _i2c_start ends ============

	signat	_i2c_start,88
	global	_show
psect	text231,local,class=CODE,delta=2
global __ptext231
__ptext231:

;; *************** function _show *****************
;; Defined at:
;;		line 43 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR unsigned char 
;;		 -> STR_4(11), STR_2(11), STR_1(17), 
;; Auto vars:     Size  Location     Type
;;  s               1    2[COMMON] PTR unsigned char 
;;		 -> STR_4(11), STR_2(11), STR_1(17), 
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
psect	text231
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
	line	43
	global	__size_of_show
	__size_of_show	equ	__end_of_show-_show
	
_show:	
	opt	stack 6
; Regs used in _show: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;show@s stored from wreg
	movwf	(show@s)
	line	44
	
l2746:	
;lcd.h: 44: while(*s) {
	goto	l2752
	
l707:	
	line	45
	
l2748:	
;lcd.h: 45: dat(*s++);
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	fcall	_dat
	
l2750:	
	movlw	(01h)
	movwf	(??_show+0)+0
	movf	(??_show+0)+0,w
	addwf	(show@s),f
	goto	l2752
	line	46
	
l706:	
	line	44
	
l2752:	
	movf	(show@s),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u2331
	goto	u2330
u2331:
	goto	l2748
u2330:
	goto	l709
	
l708:	
	line	47
	
l709:	
	return
	opt stack 0
GLOBAL	__end_of_show
	__end_of_show:
;; =============== function _show ends ============

	signat	_show,4216
	global	_lcd_init
psect	text232,local,class=CODE,delta=2
global __ptext232
__ptext232:

;; *************** function _lcd_init *****************
;; Defined at:
;;		line 14 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
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
psect	text232
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
	line	14
	global	__size_of_lcd_init
	__size_of_lcd_init	equ	__end_of_lcd_init-_lcd_init
	
_lcd_init:	
	opt	stack 6
; Regs used in _lcd_init: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	15
	
l2736:	
;lcd.h: 15: TRISB=TRISC0=TRISC1=TRISC2=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1082/8)^080h,(1082)&7
	bcf	(1081/8)^080h,(1081)&7
	bcf	(1080/8)^080h,(1080)&7
	movlw	0
	btfsc	(1080/8)^080h,(1080)&7
	movlw	1
	movwf	(134)^080h	;volatile
	line	16
	
l2738:	
;lcd.h: 16: cmd(0x38);
	movlw	(038h)
	fcall	_cmd
	line	17
	
l2740:	
;lcd.h: 17: cmd(0x0c);
	movlw	(0Ch)
	fcall	_cmd
	line	18
	
l2742:	
;lcd.h: 18: cmd(0x06);
	movlw	(06h)
	fcall	_cmd
	line	19
	
l2744:	
;lcd.h: 19: cmd(0x80);
	movlw	(080h)
	fcall	_cmd
	line	20
	
l693:	
	return
	opt stack 0
GLOBAL	__end_of_lcd_init
	__end_of_lcd_init:
;; =============== function _lcd_init ends ============

	signat	_lcd_init,88
	global	_delay1
psect	text233,local,class=CODE,delta=2
global __ptext233
__ptext233:

;; *************** function _delay1 *****************
;; Defined at:
;;		line 38 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\code.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  k               2    2[COMMON] unsigned int 
;;  j               2    0[COMMON] unsigned int 
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
;;      Locals:         4       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         4       0       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text233
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\code.c"
	line	38
	global	__size_of_delay1
	__size_of_delay1	equ	__end_of_delay1-_delay1
	
_delay1:	
	opt	stack 7
; Regs used in _delay1: [wreg+status,2]
	line	40
	
l1862:	
;code.c: 39: unsigned int j,k;
;code.c: 40: for(j=0;j<60000;j++) {
	clrf	(delay1@j)
	clrf	(delay1@j+1)
	
l1864:	
	movlw	high(0EA60h)
	subwf	(delay1@j+1),w
	movlw	low(0EA60h)
	skipnz
	subwf	(delay1@j),w
	skipc
	goto	u81
	goto	u80
u81:
	goto	l1868
u80:
	goto	l769
	
l1866:	
	goto	l769
	
l765:	
	line	41
	
l1868:	
;code.c: 41: for(k=0;k<2;k++);
	clrf	(delay1@k)
	clrf	(delay1@k+1)
	
l1870:	
	movlw	high(02h)
	subwf	(delay1@k+1),w
	movlw	low(02h)
	skipnz
	subwf	(delay1@k),w
	skipc
	goto	u91
	goto	u90
u91:
	goto	l1874
u90:
	goto	l1876
	
l1872:	
	goto	l1876
	
l767:	
	
l1874:	
	movlw	low(01h)
	addwf	(delay1@k),f
	skipnc
	incf	(delay1@k+1),f
	movlw	high(01h)
	addwf	(delay1@k+1),f
	movlw	high(02h)
	subwf	(delay1@k+1),w
	movlw	low(02h)
	skipnz
	subwf	(delay1@k),w
	skipc
	goto	u101
	goto	u100
u101:
	goto	l1874
u100:
	goto	l1876
	
l768:	
	line	40
	
l1876:	
	movlw	low(01h)
	addwf	(delay1@j),f
	skipnc
	incf	(delay1@j+1),f
	movlw	high(01h)
	addwf	(delay1@j+1),f
	movlw	high(0EA60h)
	subwf	(delay1@j+1),w
	movlw	low(0EA60h)
	skipnz
	subwf	(delay1@j),w
	skipc
	goto	u111
	goto	u110
u111:
	goto	l1868
u110:
	goto	l769
	
l766:	
	line	43
	
l769:	
	return
	opt stack 0
GLOBAL	__end_of_delay1
	__end_of_delay1:
;; =============== function _delay1 ends ============

	signat	_delay1,88
	global	_waitmssp
psect	text234,local,class=CODE,delta=2
global __ptext234
__ptext234:

;; *************** function _waitmssp *****************
;; Defined at:
;;		line 56 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
;;		_i2c_start
;;		_i2c_stop
;;		_i2c_restart
;;		_i2c_nak
;;		_i2c_send
;;		_i2c_read
;;		_i2c_read_byte
;;		_i2c_ack
;; This function uses a non-reentrant model
;;
psect	text234
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	56
	global	__size_of_waitmssp
	__size_of_waitmssp	equ	__end_of_waitmssp-_waitmssp
	
_waitmssp:	
	opt	stack 5
; Regs used in _waitmssp: []
	line	57
	
l1856:	
;i2c.h: 57: while(!SSPIF);
	goto	l730
	
l731:	
	
l730:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(99/8),(99)&7
	goto	u71
	goto	u70
u71:
	goto	l730
u70:
	
l732:	
	line	58
;i2c.h: 58: SSPIF=0;
	bcf	(99/8),(99)&7
	line	59
	
l733:	
	return
	opt stack 0
GLOBAL	__end_of_waitmssp
	__end_of_waitmssp:
;; =============== function _waitmssp ends ============

	signat	_waitmssp,88
	global	_i2c_init
psect	text235,local,class=CODE,delta=2
global __ptext235
__ptext235:

;; *************** function _i2c_init *****************
;; Defined at:
;;		line 17 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
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
psect	text235
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\i2c.h"
	line	17
	global	__size_of_i2c_init
	__size_of_i2c_init	equ	__end_of_i2c_init-_i2c_init
	
_i2c_init:	
	opt	stack 7
; Regs used in _i2c_init: [wreg]
	line	18
	
l1852:	
;i2c.h: 18: TRISC3=TRISC4=1;
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
	line	19
	
l1854:	
;i2c.h: 19: SSPCON=0x28;
	movlw	(028h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(20)	;volatile
	line	20
;i2c.h: 20: SSPADD=((11059200/4)/100)-1;
	movlw	(0FFh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(147)^080h	;volatile
	line	21
	
l712:	
	return
	opt stack 0
GLOBAL	__end_of_i2c_init
	__end_of_i2c_init:
;; =============== function _i2c_init ends ============

	signat	_i2c_init,88
	global	_dat
psect	text236,local,class=CODE,delta=2
global __ptext236
__ptext236:

;; *************** function _dat *****************
;; Defined at:
;;		line 33 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
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
psect	text236
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
	line	33
	global	__size_of_dat
	__size_of_dat	equ	__end_of_dat-_dat
	
_dat:	
	opt	stack 7
; Regs used in _dat: [wreg+status,2+btemp+1]
;dat@b stored from wreg
	movwf	(dat@b)
	line	34
	
l1834:	
;lcd.h: 34: PORTB=b;
	movf	(dat@b),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(6)	;volatile
	line	35
	
l1836:	
;lcd.h: 35: RC0=1;
	bsf	(56/8),(56)&7
	line	36
	
l1838:	
;lcd.h: 36: RC1=0;
	bcf	(57/8),(57)&7
	line	37
	
l1840:	
;lcd.h: 37: RC2=1;
	bsf	(58/8),(58)&7
	line	38
	
l1842:	
;lcd.h: 38: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l1844:	
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
	goto	l1848
u30:
	goto	l702
	
l1846:	
	goto	l702
	
l701:	
	
l1848:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l1850:	
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
	goto	l1848
u40:
	
l702:	
	line	39
;lcd.h: 39: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	40
	
l703:	
	return
	opt stack 0
GLOBAL	__end_of_dat
	__end_of_dat:
;; =============== function _dat ends ============

	signat	_dat,4216
	global	_cmd
psect	text237,local,class=CODE,delta=2
global __ptext237
__ptext237:

;; *************** function _cmd *****************
;; Defined at:
;;		line 23 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
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
psect	text237
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\I2C\EEPROM\Page write\lcd.h"
	line	23
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 7
; Regs used in _cmd: [wreg+status,2+btemp+1]
;cmd@a stored from wreg
	movwf	(cmd@a)
	line	24
	
l1816:	
;lcd.h: 24: PORTB=a;
	movf	(cmd@a),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(6)	;volatile
	line	25
	
l1818:	
;lcd.h: 25: RC0=0;
	bcf	(56/8),(56)&7
	line	26
	
l1820:	
;lcd.h: 26: RC1=0;
	bcf	(57/8),(57)&7
	line	27
	
l1822:	
;lcd.h: 27: RC2=1;
	bsf	(58/8),(58)&7
	line	28
	
l1824:	
;lcd.h: 28: for(i=0;i<1000;i++);
	clrf	(_i)
	clrf	(_i+1)
	
l1826:	
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
	goto	l1830
u10:
	goto	l697
	
l1828:	
	goto	l697
	
l696:	
	
l1830:	
	movlw	low(01h)
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	movlw	high(01h)
	addwf	(_i+1),f
	
l1832:	
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
	goto	l1830
u20:
	
l697:	
	line	29
;lcd.h: 29: RC2=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(58/8),(58)&7
	line	30
	
l698:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
psect	text238,local,class=CODE,delta=2
global __ptext238
__ptext238:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
