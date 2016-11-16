;
; Init serial
;
.macro SER_INIT
        push r16

    .ifdef UBRRL
        ldi r16, @0 / (8 * @1) - 1
        out UBRRL, r16
        sbi UCSRA, U2X
    .ifdef URSEL
        ldi r16, (1<<URSEL) | (1<<UCSZ1) | (1<<UCSZ0)
    .else
        ldi r16, (1<<UCSZ1) | (1<<UCSZ0)
    .endif
        out UCSRC, r16
        ldi r16, (1<<RXEN) | (1<<TXEN)
        out UCSRB, r16
    .else
        ldi r16, @0 / (16 * @1) - 1
        out UBRR, r16
        ldi r16, (1<<RXEN) | (1<<TXEN)
        out UCR, r16
    .endif
    
        in r16, UDR

        pop r16
.endmacro

;
; Write to serial
; r16 = char
;
ser_write:
    .ifdef UCSRA
        sbis UCSRA, UDRE
    .else
        sbis USR, UDRE
    .endif
        rjmp ser_write
        out UDR, r16

        ret
