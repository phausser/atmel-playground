;
; Init TWI
;
twi_init:
	push r16

	ldi r16, 44
	out TWBR, r16 
	ldi r16, 1
	out TWSR, r16 

	pop r16
	ret

;
