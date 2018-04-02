; avra alarm.asm && avrdude -p attiny85 -c usbasp -B 5 -U flash:w:alarm.hex

.nolist
.include "../inc/tn85def.inc"
.list

.cseg

.org 0x0000
    rjmp init
.org PCI0addr
    rjmp pin

init:
    ; Init Stack
    ldi r16, low(RAMEND)
    out spl, r16
    ldi r16, high(RAMEND)
    out sph, r16

    ; Init Ports
    ldi r16, (1 << DDB3)
    out DDRB, r16

    ; Init IRQ
    ldi r16, (1 << PCINT0)
    out PCMSK, r16

    ldi r16, (1 << PCIE)
    out GIMSK, r16

    sei

    ; Main Loop
loop:
    ;sbi PORTB, PORTB3
    rcall delay
    ;cbi PORTB, PORTB3
    rcall delay
    rjmp loop

pin:
    sbi PORTB, PORTB3
    reti

    ; Simple Delay
delay:
    ldi r22, 100
_delay_loop:
    dec r21
    brne _delay_loop
    dec r22
    brne _delay_loop
    ret
