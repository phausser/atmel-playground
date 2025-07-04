; avra hello.asm && avrdude -p attiny85 -c usbasp -B 5 -U flash:w:hello.hex

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
    rcall delay
    cbi PORTB, PORTB3
    rcall delay
    rjmp loop

    ; Simple Delay
delay:
    ldi r22, 50
_delay_loop:
    dec r21
    brne _delay_loop
    dec r22
    brne _delay_loop
    ret
