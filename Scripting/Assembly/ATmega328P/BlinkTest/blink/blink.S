#define __SFR_OFFSET 0x00
#include "avr/io.h"

.global startx
.global led

.equ delayVal, 10000

startx:
    SBI DDRB,4
    RET
led:
    CPI R24,0x00
    BREQ ledOff
    SBI PORTB,4
    RCALL myDelay
    RET
ledOff:
    CBI PORTB,4
    RCALL myDelay
    RET
myDelay:
    LDI R20, 100
outerLoop:
    LDI R30,lo8(delayVal)
    LDI R31,hi8(delayVal)
innerLoop:
    SBIW R30,1
    BRNE innerLoop
    SUBI R20,1
    BRNE outerLoop

; Send pulse of 30 microseconds
sendHigh:
    SBI DDRB,4; Set Pin
    SBIPORTB,4; Turn High
    LDI R17,160; Counter for 400 cycles
deloyLoop:
    NOP             ; 1 cycle
    DEC R17         ; 1 cycle
    BRNE delayLoop  ; Call delay
    CBI PORTB,4     ; Turn pin low

