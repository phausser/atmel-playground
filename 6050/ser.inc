;
; Init serial
;
.macro SER_INIT
        push a

        ldi a, @0 / (16 * @1)
        out UBRR, a
        ldi a, (1<<RXEN) | (1<<TXEN)
        out UCR, a

        in a, UDR

        pop a
.endmacro

;
; Write to serial
; a = char
;
ser_write:
        sbis USR, UDRE
        rjmp ser_write
        out UDR, a

        ret
