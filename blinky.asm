; avra blinky.asm && avrdude -p attiny85 -c arduino -b 19200 -P /dev/ttyACM0 -U flash:w:blinky.hex

.nolist
.include "tn85def.inc"
.list

.org 0x0000
.cseg

	rjmp init

init:
	ldi r16, 0b11
    out DDRB, r16
    ;sbi DDRB, 0
    ;sbi DDRB, 1

loop:
	ldi r16, 0b01
	out PORTB, r16
  	;sbi PORTB, 0
	rcall wait
	ldi r16, 0b10
	out PORTB, r16
  	;cbi PORTB, 0
   	rcall wait
  	rjmp loop

wait:
	inc r21
  	brne wait
  	inc r22
  	brne wait
  	ret
