; avra quad.asm && avrdude -p attiny2313 -c usbasp -b 19200 -U flash:w:quad.hex

.nolist
.include "../inc/m328pdef.inc"
.list

.cseg

.org 0x0000
    rjmp main

main:
    ; Init Stack
    ldi r16, low(RAMEND)
    out spl, r16
    ldi r16, high(RAMEND)
    out sph, r16

    ; Init pwm Ports
    ldi r16, (1 << DDB3)
    out DDRB, r16
    ldi r16, (1 << DDD5) | (1 << DDD6) | (1 << DDD3)
    out DDRD, r16

    ldi r16, (1 << COM0A1) | (1 << COM0B1) | (1 << WGM00) | (1 << WGM01)
    out TCCR0A, r16
    ldi r16, (1 << CS02) | (1 << CS00)
    out TCCR0B, r16

    ldi r16, (1 << COM2A1) | (1 << COM2B1) | (1 << WGM20) | (1 << WGM21)
    sts TCCR2A, r16
    ldi r16, (1 << CS22) | (1 << CS20)
    sts TCCR2B, r16

    clr r16

    ; Main Loop
loop:
    out OCR0A, r16
    out OCR0B, r16
    sts OCR2A, r16
    sts OCR2B, r16
    inc r16
    andi r16, 0b00001111
    rcall wait
    rjmp loop

    ; Simple Delay
wait:
    ldi r23, 5
_wait_loop:
    dec r21
    brne _wait_loop
    dec r22
    brne _wait_loop
    dec r23
    brne _wait_loop
    ret

