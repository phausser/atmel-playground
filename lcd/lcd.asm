.nolist
.include "../tn2313def.inc"
.list

.equ E = PORTD4
.equ RS = PORTD5

.def a = r16
.def x = r17
.def y = r18

.cseg
.org 0x0000
        rjmp main

.include "hd44780.inc"

main:
        ; Init Stack
        ldi a, low(RAMEND)
        out spl, a

        rcall hd44780_init

        ldi a, 'P'
        rcall hd44780_write
        ldi a, 'U'
        rcall hd44780_write
        ldi a, 'K'
        rcall hd44780_write

loop:
        nop
        rjmp loop

; VSS = +5
; VDD = GND
; A   = +5 (Poti)
; K   = GND
; V0  = GND
; RS  = PORTD4
; E   = PORTD5
; D0 - D7 = PORTB0 - PORTB7
  