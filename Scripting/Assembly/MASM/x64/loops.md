# A simple loop 

```asm
.const
.code
main proc
    mov rcx, 10h            ; Start loop counter
    loop_start:
        ; Other code here
        dec rcx
        test rcx, rcx       ; test if zero
        jnz loop_start      ; restart if not zero
main endP
end
```

The test instruction:
- bitwise logical `and` 
- discards the value
- updates condition flags
- check if value is 0
