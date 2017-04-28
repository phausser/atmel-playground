.macro DELAY
    push r21
    push r22
    push r23

    ldi r23, @0
_delay_loop:
    dec r21
    brne _delay_loop
    dec r22
    brne _delay_loop
    dec r23
    brne _delay_loop

    pop r23
    pop r22
    pop r21
    ret
.endmacro
