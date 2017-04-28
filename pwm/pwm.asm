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
        rjmp main

main:
		sbi		DDRD,5

		ldi 	R20, (1<<COM0B1 | 1<<WGM01 | 1<<WGM00)	//(0<<COM0A1) | (0<<COM0A0) | (1<<COM0B1) | (0<<COM0B0) | (1<<WGM01) | (1<<WGM00);
		out		TCCR0A, R20

		ldi 	R20, (1<<WGM02 | 1<<CS00) 				//(1<<WGM02) | (0<<CS02) | (0<<CS01) | (1<<CS00);
		out		TCCR0B, R20

		clr		R20
		out		TCNT0, R20
		
		ldi 	R20, 0x7F
		out		OCR0A, R20

		ldi 	R20, 0x12
		out		OCR0B, R20

here:
	rjmp	here