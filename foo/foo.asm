; avra blinky.asm && avrdude -p attiny85 -c usbasp -b 19200 -U flash:w:blinky.hex

.nolist
.include "../inc/m328pdef.inc"
.list

.cseg

.org 0x0000
    rjmp init

init:
    ldi r16, RAMEND         ; Init Stack
    out spl, r16

    ldi r16, (1 << DDB0)    ; Init Ports
    out DDRB, r16

loop:                       ; Main Loop
    sbi PORTB, PORTB0
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait    
    cbi PORTB, PORTB0
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
    rcall wait
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

