; avra blinky.asm && avrdude -p attiny85 -c usbasp -b 19200 -U flash:w:blinky.hex

.nolist
.include "tn85def.inc"
.list

.cseg

.org 0x0000
    rjmp init
.org PCI0addr
    rjmp button
.org OC0Aaddr
    rjmp timer

init:
    ; Init Stack
    ldi r16, low(RAMEND)
    out spl, r16
    ldi r16, high(RAMEND)
    out sph, r16

    ; Init Ports
    ldi r16, (1 << DDB0) | (1 << DDB1)
    out DDRB, r16

    ; Init Button IRQ
    ldi r16, (1 << PCIE)
    out GIMSK, r16
    ldi r16, (1 << PCINT2)
    out PCMSK, r16

    ; Init Timer/PWM
    ldi r16, (1 << COM0A1) | (1 << COM0B1) | (1 << WGM01) | (1 << WGM00)
    out TCCR0A, r16
    ldi r16, (1 << CS00)
    out TCCR0B, r16
    ldi r16, (1 << TOIE0)
    out TIMSK, r16
    clr r16
    out TCNT0, r16
    out TCNT1, r16

    sei

    ; Main Loop
loop:
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

    ; Button IRQ
button:
    push r16
    push xl
    push xh

    ldi xl, low(_button_data)
    ldi xh, high(_button_data)

    ld r16, x
    com r16
    out OCR0B, r16
    st x, r16

    pop xh
    pop xl
    pop r16
    reti

    ; Timer IRQ
timer:
    push r16
    push r17
    push xl
    push xh

    ldi xl, low(_timer_data)
    ldi xh, high(_timer_data)
    ld r16, x+
    dec r16
    breq _timer_go
    rjmp _timer_end
_timer_go:
    ld r17, x
    inc r17
    andi r17, 0b11111
    out OCR0A, r17
    st x, r17
_timer_end:
    st -x, r16

    pop xh
    pop xl
    pop r17
    pop r16
    reti

.dseg
_timer_data:
    ; cnt, val
    .byte 0, 0
_button_data:
    .byte 0
