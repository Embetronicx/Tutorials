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
	FNROOT	_main
	FNCALL	intlevel1,_ISR
	global	intlevel1
	FNROOT	intlevel1
	global	_INTCON
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:
_INTCON	set	11
	global	_PORTD
_PORTD	set	8
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_INTF
_INTF	set	89
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_TRISD
_TRISD	set	136
	global	_TRISB0
_TRISB0	set	1072
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
	global	?_ISR
?_ISR:	; 0 bytes @ 0x0
	global	??_ISR
??_ISR:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	ds	4
	global	ISR@i
ISR@i:	; 2 bytes @ 0x4
	ds	2
	global	ISR@j
ISR@j:	; 2 bytes @ 0x6
	ds	2
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_main
??_main:	; 0 bytes @ 0x0
	ds	1
;;Data sizes: Strings 0, constant 0, data 0, bss 0, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      8       8
;; BANK0           80      1       1
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:



;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _ISR in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _ISR in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _ISR in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _ISR in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _ISR in BANK2
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
;; (0) _main                                                 1     1      0       0
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 0
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (1) _ISR                                                  8     8      0      60
;;                                              0 COMMON     8     8      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 1
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;
;; _ISR (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      8       8       1       57.1%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       0       2        0.0%
;;ABS                  0      0       0       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      1       1       5        1.3%
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
psect	maintext

;; *************** function _main *****************
;; Defined at:
;;		line 16 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Ext\code new.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
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
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Ext\code new.c"
	line	16
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 7
; Regs used in _main: [wreg+status,2+status,0]
	line	17
	
l2626:	
;code new.c: 17: PORTD=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(8)	;volatile
	line	18
	
l2628:	
;code new.c: 18: TRISB0=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1072/8)^080h,(1072)&7
	line	19
;code new.c: 19: TRISD=0;
	clrf	(136)^080h	;volatile
	line	20
;code new.c: 20: OPTION_REG=0X00;
	clrf	(129)^080h	;volatile
	line	21
	
l2630:	
;code new.c: 21: INTCON|=0Xd0;
	movlw	(0D0h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	iorwf	(11),f	;volatile
	goto	l2632
	line	22
;code new.c: 22: while(1) {
	
l692:	
	line	23
	
l2632:	
;code new.c: 23: PORTD=0x00;
	clrf	(8)	;volatile
	goto	l2632
	line	24
	
l693:	
	line	22
	goto	l2632
	
l694:	
	line	25
	
l695:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_ISR
psect	text88,local,class=CODE,delta=2
global __ptext88
__ptext88:

;; *************** function _ISR *****************
;; Defined at:
;;		line 6 in file "D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Ext\code new.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  j               2    6[COMMON] unsigned int 
;;  i               2    4[COMMON] unsigned int 
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
;;      Temps:          4       0       0       0       0
;;      Totals:         8       0       0       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text88
	file	"D:\SLR\Interlogicx\codes\Practise\PIC\MP lab\Interrupts\Ext\code new.c"
	line	6
	global	__size_of_ISR
	__size_of_ISR	equ	__end_of_ISR-_ISR
	
_ISR:	
	opt	stack 7
; Regs used in _ISR: [wreg+status,2]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_ISR+0)
	movf	fsr0,w
	movwf	(??_ISR+1)
	movf	pclath,w
	movwf	(??_ISR+2)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_ISR+3)
	ljmp	_ISR
psect	text88
	line	8
	
i1l1742:	
;code new.c: 7: unsigned int i,j;
;code new.c: 8: PORTD=0X55;
	movlw	(055h)
	movwf	(8)	;volatile
	line	9
	
i1l1744:	
;code new.c: 9: for(i=0;i<600;i++)
	clrf	(ISR@i)
	clrf	(ISR@i+1)
	
i1l1746:	
	movlw	high(0258h)
	subwf	(ISR@i+1),w
	movlw	low(0258h)
	skipnz
	subwf	(ISR@i),w
	skipc
	goto	u1_21
	goto	u1_20
u1_21:
	goto	i1l1750
u1_20:
	goto	i1l686
	
i1l1748:	
	goto	i1l686
	line	10
	
i1l685:	
	
i1l1750:	
;code new.c: 10: for(j=0;j<200;j++);
	clrf	(ISR@j)
	clrf	(ISR@j+1)
	
i1l1752:	
	movlw	high(0C8h)
	subwf	(ISR@j+1),w
	movlw	low(0C8h)
	skipnz
	subwf	(ISR@j),w
	skipc
	goto	u2_21
	goto	u2_20
u2_21:
	goto	i1l1756
u2_20:
	goto	i1l1758
	
i1l1754:	
	goto	i1l1758
	
i1l687:	
	
i1l1756:	
	movlw	low(01h)
	addwf	(ISR@j),f
	skipnc
	incf	(ISR@j+1),f
	movlw	high(01h)
	addwf	(ISR@j+1),f
	movlw	high(0C8h)
	subwf	(ISR@j+1),w
	movlw	low(0C8h)
	skipnz
	subwf	(ISR@j),w
	skipc
	goto	u3_21
	goto	u3_20
u3_21:
	goto	i1l1756
u3_20:
	goto	i1l1758
	
i1l688:	
	line	9
	
i1l1758:	
	movlw	low(01h)
	addwf	(ISR@i),f
	skipnc
	incf	(ISR@i+1),f
	movlw	high(01h)
	addwf	(ISR@i+1),f
	movlw	high(0258h)
	subwf	(ISR@i+1),w
	movlw	low(0258h)
	skipnz
	subwf	(ISR@i),w
	skipc
	goto	u4_21
	goto	u4_20
u4_21:
	goto	i1l1750
u4_20:
	
i1l686:	
	line	11
;code new.c: 11: INTF=0;
	bcf	(89/8),(89)&7
	line	12
	
i1l689:	
	movf	(??_ISR+3),w
	movwf	btemp+1
	movf	(??_ISR+2),w
	movwf	pclath
	movf	(??_ISR+1),w
	movwf	fsr0
	swapf	(??_ISR+0)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_ISR
	__end_of_ISR:
;; =============== function _ISR ends ============

	signat	_ISR,88
psect	text89,local,class=CODE,delta=2
global __ptext89
__ptext89:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
