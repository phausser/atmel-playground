.nolist
.include "../inc/m328pdef.inc"
.list

.def a = r16
.def x = r17
.def y = r18

.cseg
.org 0x0000
        rjmp main

.include "../inc/sermega.inc"
.include "../inc/convert.inc"

main:
        ldi a, low(RAMEND)            ; Init Stack Pointer
        out spl, a
    .ifdef sph
        ldi a, high(RAMEND)             ; Init Stack Pointer
        out sph, a
    .endif

        ldi r16, $AD
        ldi r17, $D3
        ldi zl, low(string)
        ldi zh, high(string)
        rcall b2asc

        SER_INIT 16000000, 9600

        sbi DDRB, DDD0
        sbi PORTB, PORTB0

loop:
        ldd r16, z+3
        rcall ser_write
        ldd r16, z+2
        rcall ser_write
        ldd r16, z+1
        rcall ser_write
        ld r16, z
        rcall ser_write
        ldi r16, ' '
        rcall ser_write

        nop
        rjmp loop

delay:
        push r20
        push r21

        ldi r20, 20
        clr r21
_1:
        dec r21
        brne _1
        dec r20
        brne _1

        pop r21
        pop r20
        ret

.dseg
string:
        .byte 4
