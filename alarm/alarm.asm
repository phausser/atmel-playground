; avra alarm.asm && avrdude -p attiny85 -c usbasp -B 5 -U flash:w:alarm.hex

; 1) Power Down Modus
; 2) Button = Blinken. 5 min oder bis Button gedrückt

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
    ldi r16, (1 << PCINT4)
    out PCMSK, r16

    ldi r16, (1 << PCIE)
    out GIMSK, r16

    sei

    ; Main Loop
loop:
    ldi
    
    ldi r16, (1 << SE) | (1 << SM1)
    out MCUCR, r16

    sleep

    sbi PORTB, PORTB3
    rcall delay
    cbi PORTB, PORTB3
    rjmp loop

pin:
    ;sbi PORTB, PORTB3
    reti

    ; Simple Delay
delay:
    ldi r22, 200
_delay_loop:
    dec r21
    brne _delay_loop
    dec r22
    brne _delay_loop
    ret

.dseg
count:
        .byte 0
