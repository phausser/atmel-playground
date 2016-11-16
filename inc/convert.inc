;
; Byte to ASCII
; r16 = low(byte)
; r17 = high(byte)
; z = 4 Bytes result  
b2asc:
		push r16
		push r17
		push r18
		push r19
		push r20
		push zl
		push zh

		ldi r20, 4
_b2asc_loop:
		mov r18, r16
		andi r18, 0xf
		cpi r18, 10
		brlt _b2asc_9
		ldi r19, 'A' - 10
		rjmp _b2asc_a
_b2asc_9:
		ldi r19, '0'
_b2asc_a:
		add r18, r19
		st z+, r18

		dec r20
		breq _b2asc_out

		cpi r20, 2
		brne _b2asc_no17
		mov r16, r17
		rjmp _b2asc_loop
_b2asc_no17:		

		lsr	r16
		lsr	r16
		lsr	r16
		lsr	r16
		rjmp _b2asc_loop

_b2asc_out:
		pop zh
		pop zl
		pop r20
		pop r19
		pop r18
		pop r17
		pop r16
		ret
