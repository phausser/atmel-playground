 .nolist
.include "../inc/m328pdef.inc"
.list

.equ CLOCK      = 16000000
.equ I2CMPU6050 = 0x68

.macro STORE
    .if @0 < 0x63
        out @0, @1
    .else 
        sts @0, @1
    .endif
.endmacro

.macro LOAD
    .if @1 < 0x63
        in @0, @1
    .else 
        lds @0, @1
    .endif
.endmacro

.cseg
.org 0x0000
    rjmp main

.include "../inc/sermega.inc"
.include "../inc/delay.inc"
.include "../inc/convert.inc"

main:
    ; Init Stack
    ldi r16, low(RAMEND)
    STORE spl, r16
    ldi r16, high(RAMEND)
    STORE sph, r16

    ; Init Ports
    ldi r16, 0xff
    STORE DDRD, r16

    rcall twi_init
    rcall twi_setup

    ; Init Ser
    SER_INIT CLOCK, 9600

    ; Main Loop
loop:
    ldi r16, I2CMPU6050
    rcall twi_recv

    ldi zl, low(string)
    ldi zh, high(string)
    rcall b2asc

    ldd r16, z+1
    rcall ser_write
    ld r16, z
    rcall ser_write
    ldi r16, ' '
    rcall ser_write

    DELAY 5
    
    rjmp loop

;
; Init TWI
;
twi_init:
    push r16

    ldi r16, 24
    STORE TWBR, r16
    ldi r16, 0
    STORE TWSR, r16

    pop r16
    ret

;
; Receive TWI Data
; r16 = addr
; -> r16 = data
;
.macro TWI_TRANS
    ldi r17, @0
    STORE TWCR, r17

_loop:
    LOAD r17, TWCR
    sbrs r17, TWINT
    rjmp _loop
.endmacro

; START
; MPU6050 I2C ADDR + RW 
; REGISTER NUMBER 
; START 
; MPU6050 I2C ADDR + RW 
; REGISTER DATA 
; STOP
twi_recv:
    push r17

    ; Send START
    TWI_TRANS (1<<TWINT) | (1<<TWEN) | (1<<TWSTA)

    ; Set ADDR
    mov r17, r16
    lsl r17
    ori r17, 1
    STORE TWDR, r17
    TWI_TRANS (1<<TWINT) | (1<<TWEN)

    ; Set Register
    ldi r17, 0x3b
    STORE TWDR, r17
    TWI_TRANS (1<<TWINT) | (1<<TWEN)

    ; Send START
    TWI_TRANS (1<<TWINT) | (1<<TWEN) | (1<<TWSTA)

    ; Set ADDR
    mov r17, r16
    lsl r17
    ori r17, 1
    STORE TWDR, r17
    TWI_TRANS (1<<TWINT) | (1<<TWEN)

    ; Get DAT
    TWI_TRANS (1<<TWINT) | (1<<TWEN)
    LOAD r16, TWDR

    ; Send ACK
    TWI_TRANS (1<<TWINT) | (1<<TWEN) | (1<<TWEA)
    
    ; Send STOP
    ldi r17, (1<<TWINT) | (1<<TWEN) | (1<<TWSTO)
    STORE TWCR, r17

    pop r17
    ret

twi_setup:
    push r17

    ; Send START
    TWI_TRANS (1<<TWINT) | (1<<TWEN) | (1<<TWSTA)

    ; Set ADDR
    mov r17, r16
    lsl r17
    STORE TWDR, r17
    TWI_TRANS (1<<TWINT) | (1<<TWEN)

    ; Set Register
    ldi r17, 0x6b
    STORE TWDR, r17
    TWI_TRANS (1<<TWINT) | (1<<TWEN)

    ; Set Register
    ldi r17, 0
    STORE TWDR, r17
    TWI_TRANS (1<<TWINT) | (1<<TWEN)
    
    ; Send STOP
    ldi r17, (1<<TWINT) | (1<<TWEN) | (1<<TWSTO)
    STORE TWCR, r17

    pop r17
    ret
    
.dseg
string:
    .byte 4
