 ; avra alarm.asm && avrdude -p attiny85 -c usbasp -B 5 -U flash:w:alarm.hex

; 1) Power Down Modus
; 2) Button = Blinken. 5 min oder bis Button gedrückt

.nolist
.include "../inc/tn85def.inc"
.list

.def acc = r16
.def counter = r17
.def turn_on_pressed = r18

.cseg
.org 0x0000
    rjmp init
.org PCI0addr
    rjmp pci0

init:
    ; Init Stack
    ldi acc, low(RAMEND)
    out spl, acc
    ldi acc, high(RAMEND)
    out sph, acc

    ; Init Ports
    ldi acc, (1 << DDB0) | (1 << DDB3)
    out DDRB, acc

    ; Enable pin change IRQ #4
    ldi acc, (1 << PCINT4)
    out PCMSK, acc

    ; Enable pin change IRQs
    ldi acc, (1 << PCIE)
    out GIMSK, acc

    ; Enable sleep as power down mode
    ldi acc, (1 << SE) | (1 << SM1)
    out MCUCR, acc

    ldi counter, 3*2
    clr turn_on_pressed

    sei


    ; Main Loop
main:
    tst counter
    brne _main_no_sleep

    ; Good night
    sbi PORTB, PORTB0
    cbi PORTB, PORTB3
    sleep
    cbi PORTB, PORTB0

_main_no_sleep:
    dec counter

    sbic PORTB, PORTB3
    rjmp _main_pin_on

    sbi PORTB, PORTB3
    rjmp _main_pin_off

_main_pin_on:
    cbi PORTB, PORTB3
_main_pin_off:

    rcall delay
    rjmp main


pci0:
    ; Is button down?
    sbic PINB, PINB4
    rjmp _pci0_button_is_up

    ; Init counter and button flag
    tst counter
    brne _pci0_exit

    ldi turn_on_pressed, 1
    ldi counter, 100*2
    reti

_pci0_button_is_up:
    tst turn_on_pressed
    brne _pci0_exit

    clr counter

_pci0_exit:
    clr turn_on_pressed
    reti


    ; Simple Delay
delay:
    ldi r23, 4
_delay_loop:
    dec r21
    brne _delay_loop
    dec r22
    brne _delay_loop
    dec r23
    brne _delay_loop
    ret
