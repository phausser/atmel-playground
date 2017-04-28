.nolist
.include "../inc/m328pdef.inc"
.list

.def a = r16
.def x = r17
.def y = r18

.equ CLOCK = 16000000
.equ BAUD = 9600
     
.cseg
.org 0x0000
        rjmp start

.include "../inc/sermega.inc"

start:
        ldi a, low(RAMEND)              ; Init Stack Pointer
        out spl, a
    .ifdef sph
        ldi a, high(RAMEND)             ; Init Stack Pointer
        out sph, a
    .endif

        sbi DDRB, DDB0
        sbi PORTB, PORTB

        SER_INIT CLOCK, BAUD

loop:
        ldi a, '='
        rcall ser_write
        rcall delay
        
        ldi a, ')'
        rcall ser_write
        rcall delay

        nop
        rjmp loop

delay: 
        push x
        push y

        ldi x, 200
        clr y
_delay_loop:
        dec y
        brne _delay_loop
        dec x
        brne _delay_loop

        pop y
        pop x
        ret

