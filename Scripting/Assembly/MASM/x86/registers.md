# Key Registers in MASM

## General Purpose Registers

| Register | Purpose |
| -------- | ------- |
| EAX (Accumulator) | Arithmetic, I/O, returning function values |
| EBX (Base) | Point to data in data segment and indexed addresses |
| ECX (Count) | Loop counts |
| EDX (Data) | I/O operations, large value multiply and divide operations |
| ESI (Source Index) | Point to a source in stream (string) operations | 
| EDI (Destination Index) | Pointer to a destination stream |
| ESP (Stack Pointer) | Points to top of stack. Function calls variables |
| EBP (Base Pointer) | Current base of stack frame. Function params and local vars |

## Segment Registers
| Register | Purpose |
| -------- | ------- |
| CS (Code Segment) | address of program instructions |
| DS (Data Segment) | address of data, constants and work areas |
| SS (Stack Segment) | Starting address of stack. Data and return address of sub routines |
| ES, FS, GS | Additional data segments |

## Function Prologue
When disassembling, you will notice the instructions responsible for opening sequence of a proceduce 
```asm
push ebp            ; saves caller stack frame, allows program to return later
mov ebp, esp        ; local variables and arguments are relative to this new ebp
add esp, FFFFFFFF0  ; subtracts 16 bytes from the stack pointer to clear space
```

## Two's compliment representation
standard method for encoding signed integers in computer hardware. (A + (-B))

`0xFFFFFFFF0` is a 32 bit hex number. Anynumber with it's most significantbit (leftmost bit) set to 1 is interpreted as a negative number

In this case, F (binary 1111) indicates a negative value
