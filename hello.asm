;hellocc
 ;using assembly language for turning LED on
.include "/data/data/com.termux/files/home/m328Pdef.inc"
.include "m328Pdef.inc"  ; Include definitions for ATmega328P microcontroller

; ---- Define Constants ----
.equ LED_PIN = PORTB1   ; PB1 is connected to the LED (output pin)
.equ DELAY_MS = 1000    ; Delay duration in milliseconds

; ---- Initialization ----
.cseg
.org 0x0000              ; Start of the program memory
rjmp RESET               ; Reset vector

RESET:
    ldi r16, (1 << LED_PIN) ; Load 0b00000010 (Set PB1 as output)
    out DDRB, r16          ; Set DDRB direction register (PB1 as output)

; ---- Main Program Loop ----
MAIN_LOOP:
    ; Turn LED on
    ldi r16, (1 << LED_PIN) ; Load 0b00000010 to turn PB1 HIGH
    out PORTB, r16          ; Write to PORTB to turn LED on
    rcall DELAY             ; Call delay subroutine

    ; Turn LED off
    ldi r16, 0x00           ; Load 0b00000000 to turn PB1 LOW
    out PORTB, r16          ; Write to PORTB to turn LED off
    rcall DELAY             ; Call delay subroutine

    rjmp MAIN_LOOP          ; Repeat loop

; ---- Delay Subroutine ----
DELAY:
    ldi r18, HIGH(16000 * DELAY_MS / 1000) ; Load high byte of delay count
    ldi r19, LOW(16000 * DELAY_MS / 1000)  ; Load low byte of delay count
DELAY_LOOP:
    sbiw r24:r26, 1         ; Subtract 1 from the 16-bit register pair
    brne DELAY_LOOP         ; Repeat until zero
    ret                     ; Return from subroutine
