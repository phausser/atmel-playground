.nolist
.include "../inc/tn2313def.inc"
.list

.cseg
.org 0x0000
        rjmp main

.include "../inc/ser.inc"
.include "../inc/convert.inc"

main:
        ldi r16, low(RAMEND)             ; Init Stack Pointer
        out spl, r16

		ldi r16, $AD
		ldi r17, $D3
		ldi zl, low(string)
		ldi zh, high(string)
		rcall b2asc

		SER_INIT 16000000, 9600

		sbi DDRD, DDD6
		sbi PORTD, PORTD6

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
