; avra blinky.asm && avrdude -p attiny85 -c usbasp -b 19200 -U flash:w:blinky.hex

.nolist
.include "../inc/tn85def.inc"
.list

.cseg

.org 0x0000
    rjmp init

init:
    ; Init Stack
    ldi r16, low(RAMEND)
    out spl, r16
    ldi r16, high(RAMEND)
    out sph, r16

    ; Init Ports
    ldi r16, (1 << DDB3)
    out DDRB, r16

    ; Main Loop
loop:
    sbi PORTB, PORTB3
    rcall wait
    cbi PORTB, PORTB3
    rcall wait
    rjmp loop

    ; Simple Delay
wait:
    ldi r22, 20
_wait_loop:
    dec r21
    brne _wait_loop
    dec r22
    brne _wait_loop
    ret
