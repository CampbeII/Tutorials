# Using Assembly to interact with Arduino
This project will contain 2 similar named files:
1. blink.ino - C code
2. blink.S - Assembly

## Setup & Importing libraries
At the top of the `blink.S` assembly file we will define an offset:

```asm
#define __SFR_OFFSET 0x00
```

This is a preprocessor directive and it tells the compiler to use the direct I/O port address.

AVR have 2 ways to address I/O registers:
1. I/O Address space:
- 0x00 to 0x3F  
- IN and OUT assembly functions

2. Data memory address space (SRAM) 
- I/O registers are mapped to 0x20
- Accesed using LD and ST instructions
- Takes more cycles

This line includes the core avr library [avr-libc](https://www.nongnu.org/avr-libc/user-manual/modules.html)
```asm
#include "avr/io.h"
```


## Mapping Pins
The following was taken from the [arduino core documentation](https://github.com/arduino/ArduinoCore-avr/blob/1.6.23/variants/standard/pins_arduino.h).

To use arduino `D12` pin we would reference `PB4`

```
// ATMEL ATMEGA8 & 168 / ARDUINO
//
//                  +-\/-+
//            PC6  1|    |28  PC5 (AI 5)
//      (D 0) PD0  2|    |27  PC4 (AI 4)
//      (D 1) PD1  3|    |26  PC3 (AI 3)
//      (D 2) PD2  4|    |25  PC2 (AI 2)
// PWM+ (D 3) PD3  5|    |24  PC1 (AI 1)
//      (D 4) PD4  6|    |23  PC0 (AI 0)
//            VCC  7|    |22  GND
//            GND  8|    |21  AREF
//            PB6  9|    |20  AVCC
//            PB7 10|    |19  PB5 (D 13)
// PWM+ (D 5) PD5 11|    |18  PB4 (D 12)
// PWM+ (D 6) PD6 12|    |17  PB3 (D 11) PWM
//      (D 7) PD7 13|    |16  PB2 (D 10) PWM
//      (D 8) PB0 14|    |15  PB1 (D 9) PWM
//                  +----+
//
```
Looking at the chip diagram:
- ATMega328 pin 18
- DDRB port B, bit 4
- Maps to D12 arduino core

## Setting I/O pins
SBI - Set Bit I/O
DDRB - Direct Data Register (Port B)
RET - Return

To create a function, and to set D12 as I/O pin:
```asm
startx:
    SBI DDRB,4 
    RET
```

## Handle LED
The `led` function will take the value stored in `R24` and compare it to zero. 
If It equals zero we will jump to the `ledOff` function.
Otherwise, set the pin to high

The CPI function is a subtraction, where the result is discarded, but the `SREG` status register flags are updated based on the result.
This will allow us to use the subsequent `BREQ`  "Branch is equal to"

CPI - Compare with Immediate
R24 - A general purpose register betwenn R16 - R31
0x00 - A constant immediate value (0-255)
```asm
led:
    CPI R24,0x00
    BREQ ledOff
    SBI PORTB,4
    RET
```

## TurnOff LED
This will clear the bit and turn off the LED
CBI - Clear Bit I/O
```ledOff:
    CBI PORTB,4
    RET
```
LDI - Load Immediate
loads an 8-bit constant directly to register

## Adding A Delay
.equ - Defines a constant, no memory alloc
10000 - The value to use for the delay. Ideally we would calculate this based on an internal timer.
```asm
.equ delayVal, 10000
```

Load Immediate
This will load the value 100 to the R20 register
```asm
myDelay:
    LDI R20,100
```

The outer loop 
To understand the values here, we will need to convert `delayVal` to hexadecimal.

To convert a decimal to hexadecimal you simply need to figure out how many times 16 fits into a number and record the remainder: [Powershell example
](hex-converter.ps1)

Example:
Take 10000 and convert to hex `0x2710`
Write 2 values to registers:
    - low bit of `delayVal` (0x10)
    - high bit of `delayVal`  (0x27) 

```asm
outerLoop:
    LDI R30, lo8(delayVal)
    LDI R31, hi8(delayVal)
```

The inner Loop
SBIW - Subtract Immediate from Word
Subtracts an immediate value (0-63) from a register pair and places the result in the register pair.

```asm
innerLoop:
    SBIW R30,1 ;subtract 1 from R30 (low bit)
    BRNE innerLoop
    SUBI R20,1
    BRNE outerLoop
```

## Troubleshooting
### I Could not find proper pinout using ATMega328P documentation.
- I downloaded a copy of the proper one to this repository.

### Could not map arduino pins to the register pins
The arduino core git hub has the proper pinout. I also included it in this file.

### Undefined R30
This was caused because I had used `SBI` instead of `SBIW`.  SBI can only be used with specific I/O registers. SBIW is a 16bit register. 

