.nolist
.include "../tn2313def.inc"
.list

.def a = r16
.def x = r17
.def y = r18

.equ CLOCK = 16000000
.equ BAUD = 9600

.cseg
.org 0x0000
        rjmp main

.include "ser.inc"

main:
        ldi a, low(RAMEND)             ; Init Stack Pointer
        out spl, a

        SER_INIT CLOCK, BAUD

loop:
        ldi a, '1'
        rcall ser_write
        ldi a, '0'
        rcall ser_write
        rcall delay
        rcall delay
        nop
        rjmp loop

delay:
        push x
        push y

        ldi x, 255
        clr y
_delay_loop:
        dec y
        brne _delay_loop
        dec x
        brne _delay_loop

        pop y
        pop x
        ret

