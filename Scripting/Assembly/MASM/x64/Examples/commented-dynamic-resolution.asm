LoadLibraryAConst equ 74776072h
GetProcAddressConst equ 0E553E06Fh
ExitProcessConst equ 0C3F39F16h

.data
    user32dll db "user32.dll", 0          
    msgboxName db "MessageBoxA", 0       
    helloMsg db "Hello World!", 0       
    successMsg db "Success", 0         

.code
align 16

GetAPIs proc
    ; Input: rsi = DLL imagebase 
    ; Input: rdi = pointer to array stores resolved API addresses
    ; Output: Fills array with [LoadLibrary, GetProcAddress, ExitProcess]
    
    ; Callee-saved registers must be preserved
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov rbx, rsi                        ; rbx = DLL base address

    ; Navigate PE structure to find export table
    mov eax, dword ptr [rbx + 3Ch]      ; Get e_lfanew offset (points to PE header)
    lea rsi, [rbx + rax]                ; rsi = PE header address

    ; Get export directory RVA from PE optional header
    mov eax, dword ptr [rsi + 88h]      ; Offset 0x88 = DataDirectory[0].VirtualAddress (Export Table)
    lea rsi, [rbx + rax]                ; rsi = export directory absolute address

    ; Get the three important export table arrays
    mov eax, dword ptr [rsi + 1Ch]      ; Get AddressOfFunctions RVA
    lea r13, [rbx + rax]                ; r13 = AddressOfFunctions (array of function RVAs)

    mov eax, dword ptr [rsi + 24h]      ; Get AddressOfNameOrdinals RVA
    lea r14, [rbx + rax]                ; r14 = AddressOfNameOrdinals (maps name index to ordinal)

    mov eax, dword ptr [rsi + 20h]      ; Get AddressOfNames RVA
    lea r15, [rbx + rax]                ; r15 = AddressOfNames (array of name string RVAs)

    mov eax, dword ptr [rsi + 18h]      ; Get NumberOfNames
    mov r12, rax                        ; r12 = total number of exported names

    xor ecx, ecx                        ; rcx = loop counter (current index)
    xor r10d, r10d                      ; r10d = hash accumulator

SearchLoop:
    cmp rcx, r12                        ; Check if we've processed all names
    jge Done                            ; If counter >= NumberOfNames, we're done

    ; Get the RVA of current function name string
    mov eax, dword ptr [r15 + rcx * 4]  ; Get name RVA from AddressOfNames[index]
    test eax, eax                       ; Check if RVA is valid
    jz NextAPI                          ; Skip if null

    ; Calculate ROR13 hash of the function name
    lea rax, [rbx + rax]                ; Convert RVA to absolute address
    mov rsi, rax                        ; rsi = pointer to name string

HashLoop:
    lodsb                               ; Load byte from [rsi] into al, increment rsi
    test al, al                         ; Check if we hit null terminator
    jz CompareHash                      ; If null, hash is complete

    movzx eax, al                       ; Zero-extend byte to 32-bit
    add r10d, eax                       ; Add character value to hash
    ror r10d, 13                        ; Rotate hash right by 13 bits
    jmp HashLoop                        ; Continue hashing next character

CompareHash:
    ; Check if calculated hash matches any of our target APIs
    cmp r10d, LoadLibraryAConst         ; Is this LoadLibraryA?
    je StoreAPI                         ; Yes, go store it

    cmp r10d, GetProcAddressConst       ; Is this GetProcAddress?
    je StoreAPI                         ; Yes, go store it

    cmp r10d, ExitProcessConst          ; Is this ExitProcess?
    je StoreAPI                         ; Yes, go store it

NextAPI:
    inc rcx                             ; Move to next name in export table
    xor r10d, r10d                      ; Reset hash accumulator for next name
    jmp SearchLoop                      ; Continue searching

StoreAPI:
    ; Get the actual function address from the ordinal
    xor r11, r11                        ; Clear r11
    mov r11w, word ptr [r14 + rcx * 2]  ; Get ordinal from AddressOfNameOrdinals[index]
    mov eax, dword ptr [r13 + r11 * 4]  ; Get function RVA using ordinal as index
    lea rax, [rbx + rax]                ; Convert RVA to absolute address

    ; Store in the correct array slot based on which API it is
    cmp r10d, LoadLibraryAConst         ; Is it LoadLibraryA?
    je StoreSlot0                       ; Store in slot 0
    cmp r10d, GetProcAddressConst       ; Is it GetProcAddress?
    je StoreSlot1                       ; Store in slot 1
    mov qword ptr [rdi + 10h], rax      ; Must be ExitProcess, store in slot 2
    jmp NextAPI                         ; Continue searching for remaining APIs

StoreSlot0:
    mov qword ptr [rdi], rax            ; Store LoadLibraryA at offset 0
    jmp NextAPI                         ; Continue searching

StoreSlot1:
    mov qword ptr [rdi + 8h], rax       ; Store GetProcAddress at offset 8
    jmp NextAPI                         ; Continue searching

Done:
    ; Restore saved registers in reverse order
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

GetAPIs endp

main proc
    sub rsp, 58h                        ; Allocate stack space (shadow space + locals)

    ; Walk the PEB to find kernelbase.dll base address
    mov rax, qword ptr gs:[60h]         ; Get PEB (Process Environment Block) address
    mov rax, qword ptr [rax + 18h]      ; Get PEB->Ldr (loader data)
    mov rax, qword ptr [rax + 20h]      ; Get InMemoryOrderModuleList.Flink (1st module)
    mov rax, qword ptr [rax]            ; Follow Flink to 2nd module
    mov rax, qword ptr [rax]            ; Follow Flink to 3rd module (kernelbase)
    mov rsi, qword ptr [rax + 20h]      ; Get DllBase from LDR_DATA_TABLE_ENTRY

    ; Resolve APIs from kernelbase
    lea rdi, [rsp + 30h]                ; rdi = pointer to stack space for API array
    call GetAPIs                        ; Populate array with kernel APIs

    ; Load resolved API pointers into registers for easy access
    mov r12, qword ptr [rsp + 30h]      ; r12 = LoadLibraryA address
    mov r13, qword ptr [rsp + 38h]      ; r13 = GetProcAddress address
    mov r14, qword ptr [rsp + 40h]      ; r14 = ExitProcess address

    ; Load user32.dll to get access to MessageBoxA
    lea rcx, user32dll                  ; rcx = "user32.dll" (1st parameter)
    sub rsp, 20h                        ; Allocate shadow space (required by x64 calling convention)
    call r12                            ; Call LoadLibraryA("user32.dll")
    add rsp, 20h                        ; Clean up shadow space
    test rax, rax                       ; Check if LoadLibrary succeeded
    jz Exit                             ; If failed (returned NULL), exit
    mov r15, rax                        ; r15 = user32.dll handle

    ; Get MessageBoxA function address from user32.dll
    mov rcx, r15                        ; rcx = user32 handle (1st parameter)
    lea rdx, msgboxName                 ; rdx = "MessageBoxA" (2nd parameter)
    sub rsp, 20h                        ; Allocate shadow space
    call r13                            ; Call GetProcAddress(user32, "MessageBoxA")
    add rsp, 20h                        ; Clean up shadow space
    test rax, rax                       ; Check if GetProcAddress succeeded
    jz Exit                             ; If failed, exit

    ; Call MessageBoxA to display our message
    ; MessageBoxA(HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, UINT uType)
    xor ecx, ecx                        ; rcx = NULL (no parent window)
    lea rdx, helloMsg                   ; rdx = "Hello World!" (message text)
    lea r8, successMsg                  ; r8 = "Success" (title bar text)
    xor r9d, r9d                        ; r9 = 0 (MB_OK button style)
    sub rsp, 20h                        ; Allocate shadow space
    call rax                            ; Call MessageBoxA
    add rsp, 20h                        ; Clean up shadow space

Exit:
    xor ecx, ecx                        ; rcx = 0 (exit code)
    call r14                            ; Call ExitProcess(0)

main endp

end
