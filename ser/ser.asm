.nolist
.include "../inc/tn2313def.inc"
.list

.def a = r16
.def x = r17
.def y = r18

.equ CLOCK = 16000000
.equ BAUD = 9600
     
.cseg
.org 0x0000
        rjmp start

.include "../inc/ser.inc"

start:
        ldi a, low(RAMEND)             ; Init Stack Pointer
        out spl, a

        ldi a, (1<<DDD6)
        out DDRD, a
        ldi a, (1<<PORTD6)
        out PORTD, a

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

