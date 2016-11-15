; avra blinky.asm && avrdude -p attiny85 -c usbasp -b 19200 -U flash:w:blinky.hex

.nolist
.include "tn2313def.inc"
.list

.cseg

.org 0x0000
    rjmp init

init:
    ldi r16, RAMEND         ; Init Stack
    out spl, r16

    ldi r16, (1 << DDD6)    ; Init Ports
    out DDRD, r16

loop:                       ; Main Loop
    sbi PORTD, PORTD6
    rcall wait
    cbi PORTD, PORTD6
    rcall wait
    rcall wait
    rjmp loop

wait:                       ; Simple Delay
    ldi r22, 200
_wait_loop:
    dec r21
    brne _wait_loop
    dec r22
    brne _wait_loop
    ret

