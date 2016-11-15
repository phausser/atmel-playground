; avra shift.asm && avrdude -p attiny85 -c arduino -b 19200 -P /dev/ttyACM0 -U flash:w:shift.hex

.nolist
.include "tn85def.inc"
.list

.equ DATA = 0
.equ CLOCK = 1
.equ LATCH = 2
.equ LED = 4

.org 0x0000
.cseg

    rjmp init

init:
    ldi r16, 0b10111
    out DDRB, r16
    
    ldi r16, 0
    ldi r17, 1

loop:
    rcall shift
    add r16, r17
    rcall wait
    
    rjmp loop

shift:
    cbi PORTB, LATCH
    ldi r23, 8

_shift_loop:
    cbi PORTB, DATA
    sbrc r16, 0
    sbi PORTB, DATA
    cbi PORTB, CLOCK
    sbi PORTB, CLOCK
    ror r16
    dec r23
    brne _shift_loop
    
    sbi PORTB, LATCH
    ror r16
    ret

wait:
    clr r21
    ldi r22, 127
    
_wait_loop:
    dec r21
    brne _wait_loop
    dec r22
    brne _wait_loop
    ret
