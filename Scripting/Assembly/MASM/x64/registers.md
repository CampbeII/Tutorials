# Key Registers in 64bit MASM
| 64 Bit | Lower 32 bits | Lower 16 bits | Lower 8 bits |
| ------ | ------------- | ------------- | ------------ |
| rax | eax | ax | al |
| rbx | ebx | bx | bl |
| rcx | ecx | cx | cl |
| rdx | edx | dx | dl |
| rsi | esi | si | sil |
| rdi | edi | di | dil |
| rdp | edp | bp | bpl |
| rsp | esp | sp | spl | 
| r8  | r8d | r8w| r8b |
| r9 | r9d | r9w | r9b | 
| r10 | r10d | r10w | r10b |
| r11 | r11d | r11w | r11b |
| r12 | r12d | r12w | r12b |
| r13 | r13d | r13w | r13b |
| r14 | r14d | r14w | r14b |
| r15 | r15d | r15w | r15b |

## General Purpose Registers
Volatile - Values destroyed after function call, must be saved if needed later
NonVolatile - Called function is responsible for saving the orginal value, and restoring them to stack.

| Register | Purpose | Volitile? | 
| -------- | ------- | --------- |
| `RAX` | Accumaltor | Return value from functions |
| `RBX` | Base | Calee saved register, must be preserved across function calls | 
| `RCX` | Counter | Loop counter |
| `RDX` | Data / Destination | scratch register | 
| `RSI` | Source Index | source pointer in string operations |
| `RDI` | Destination pointer in string operations |
| `RBP` | Frame pointer for the current stack frame |
| `RSP` | Stack pointer for top of stack |
| `R8-R15` | General purpose registers |
| `R10,11` | Scratch registers |
| `R12-R15` | Callee-saved, preserved across function calls |

## OpCodes

### Data Movement
| Code | Purpose |
| ---- | ------- |
| `mov` | Move |
| `cmov` | Conditional Move |
| `movs`,`movz` | Sign or zero extension |
| `push`, `pop` | Stack |


### Arithmetic & Logic
| Code | Purpose |
| ---- | ------- |
| `add` | Addition |
| `sub` | Subtraction |
| `mul`,`imul` | Multiplication (imul is signed integer multiplication)|
| `div`,`idiv` | Division |
| `lea` | 
| `sal` | 
| `sar` |
| `shl` |
| `shr` |
| `rol` |
| `ror` |
| `inc` |
| `dec` |
| `neg` |

### Binary Logic
| Code | Purpose |
| ---- | ------- |
| `and` | 
| `or` |
| `xor` | 
| `not` |

### Boolean Logic
| Code | Purpose |
| ---- | ------- |
| `test` | 
| `cmp` |

### Control
| Code | Purpose |
| ---- | ------- |
| `jmp` | Unconditional jump |
| `j<condition>` | Conditional jump |
| `call`, `ret` | Subroutines |

## Data Types
| C | Size (bytes) | Assembly Suffix | Type |
| - | ---- ------- | -------- ------ | ---- |
| `char` | 1 | b | Byte |
| `short` | 2 | w | Word |
| `int` | 4 | l or d | DWord |
| `unsigned int` | 4 | l or d | DWord |
| `long` | 8 | q | QWord |
| `unsigned long` | 8 | q | QWord |
| `char *` | 8 | q | QWord |
| `float` | 4 | s | single precision |
| `double` | 8 | d | Double precision |
| `long double` | 16 | t | Extended precision |

## Condition Codes
| Code | Description | Flag |
| ---- | ----------- | ---- |
| a | if above | CF = 0 and ZF = 0 |
| ae | if above or equal | CF = 0 |
| C | on carry | CF = 1 |
| e | if equal | ZF = 1 |
| ge | if greater or equal | SF = OF |
| ne | if not equal | ZF = 0 |
| o | on overflow | OF = 1 |
| z | if zero | ZF = 1 |

## Instructions
```asm
; This is a comment
xor rax, rax    ; clear register
mov rax, rbx    ; Load a pointer
mov rax, [rbx]  ; Load the value
push rax        ; Push contents to stack
pop rax         ; Pop last stack items back into the register
shr rax, 1      ; Bit shift right (divides register by 2)
shl rax, 1      ; Bit shift left (multiply register by 2)
jmp labelname   ; Jump to label name
```
