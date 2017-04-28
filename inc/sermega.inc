;
; Init serial
;
.macro SER_INIT
        push r16

        ldi r16, @0 / (8 * @1) - 1
        sts UBRR0L, r16
        ldi r16, (1<<U2X0)
        sts UCSR0A, r16
        ldi r16, (1<<UCSZ01) | (1<<UCSZ00)
        sts UCSR0C, r16
        ldi r16, (1<<RXEN0) | (1<<TXEN0)
        sts UCSR0B, r16
    
        lds r16, UDR0

        pop r16
.endmacro

;
; Write to serial
; r16 = char
;
ser_write:
	push r17

_ser_write_loop:
	lds r17, UCSR0A
        sbrs r17, UDRE0
        rjmp _ser_write_loop
        sts UDR0, r16

        pop r17
        ret
