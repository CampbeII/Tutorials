# Storing strings on the stack

We will take the string `hello world` and save it so we can view it in x64dbg

## 1. Converting the string
For quick mental math figure out how many times 16 will fit into the number evenly. Then subtract the 2 numbers
The value `68h` broken down:
```asm
104 / 16    ; 6.5, round down to 6
16 * 6      ; 96
104 - 96    ; 8 
```


| Char | ASCII (decimal) | Hex |
| ---- | --------------- | --- |
| h | 104 | 68h |
| e | 101 | 65h |
| l | 108 | 6Ch | 
| o | 111 | 6Fh |
| ''| 32  | 20h |
| w | 119 | 77h |
| r | 114 | 72h |
| d | 100 | 64h |

## 2. Little-Endian Ordering
The above bytes in logical order are:
`68h` `65h` `6ch` `6ch` `6fh` `20h` `77h` `6fh` `72h` `6ch` `64h` `00h`

In little-endian a multi-byte value like a 64 bit qword is stored in memory like:
- least significant byte (the little end of the number) is stored at the lowest address
- the most significant byte is stored at the highest memory address in that 8-byte chuck

Take the 12 bytes in 8 byte chunks (qwords)
- hello world is 11 bytes + null terminator
- `hello wo` is the first 8 bytes
- `rld` is the last 4 (3 + 1 null bytes)

When loading this to memory it will need to be reversed:
hello wo:
`6f 77 20 6f 6c 6c 65 68h`

If we are careful with memory we don't need to included padding.
rld null:
`72 6c 64 00h`

```asm
mov rax, 6f77206f6c6c6568h      ; ow olleh (hello wo)
mov rbx, 00646c72h              ; null dlr
```


Functions are responsible for maintaining their own stack frames
- 32 byte shadow space for register args, local variables, etc 
- stack must be 16 byte aligned before a call instruction

```asm
.code
main proc
    sub rsp, 16         ; We only need 12

    mov rax, 6f77206f6c6c6568h
    mov rbx, 00646c72h

    mov [rsp], rax
    mov [rsp + 8], rbx

    add rsp, 16
    ret
main endP
end
```
