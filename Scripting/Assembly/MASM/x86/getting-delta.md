# Delta
You cannot use a hardcoded address, therefore we need the following trick to determine where we are in memory before we start.

- Jump to the next label
- Call prev which will store the result of end_getDelta in ebx
- The offset from the get_delta and the mainshellcode is calculated and stored in cx
- ax, cx are the 16bit parts of EAX and ECX
- This will move the pointer back to the exact start of our MainShellcode
```asm
.Code                                                           ; Start of the code segment
Assume Fs:Nothing                                               ; Do not assume fs register
Shellcode:

GETDELTA:
    Jmp NEXT                                                    ; Move past the PREV label
    PREV:                                                       ; Reached by call to save address
        Pop Ebx                                                 ; EBX holds value of end_GetDelta
        Jmp END_GETDELTA
    NEXT:
        Call PREV
END_GETDELTA:
    Mov Eax, Ebx                                                ; copies pop ebx into eax
    Mov Cx, (Offset END_GETDELTA - Offset MainShellcode)        ; positive number copied to cx
    Neg Cx                                                      ; make it negative
    Add Ax, Cx                                                  ; Add -cx to ax resulting in address pointing to main MainShellcode label
    Jmp Eax                                                     ; Add the low value of EAX to ECX
```

