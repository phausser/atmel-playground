;
; Init HD44780 LCD
;
hd44780_init:
        push a

        ldi a, 0b00110000
        out DDRD, a
        ldi a, 0b11111111
        out DDRB, a

        ldi a, 0b00111000           ;8-bit, 2-lines, 5x8 dots
        rcall _hd44780_cmd

        ldi a, 0b00001111           ;Display on, show Cursor, blink
        rcall _hd44780_cmd

        ldi a, 0b00000110           ;cursor increament, No display shift
        rcall _hd44780_cmd

        ldi   a, 0x01               ;Return Home
        rcall _hd44780_cmd

        pop a
        ret

;
; Send command to LCD
; a = cmd
;
_hd44780_cmd:
        sbi PORTD, E
        cbi PORTD, RS
        out PORTB, a
        cbi PORTD, E

        rcall _hd44780_delay

        ret

;
; Write to LCD
; a = cmd
;
hd44780_write:
        sbi PORTD, E
        sbi PORTD, RS
        out PORTB, a
        cbi PORTD, E

        rcall _hd44780_delay
        ret

_hd44780_delay:
        push x
        push y

        ldi x, 40
        clr y
_hd44780_delay_loop:
        dec y
        brne _hd44780_delay_loop
        dec x
        brne _hd44780_delay_loop

        pop y
        pop x
        ret
