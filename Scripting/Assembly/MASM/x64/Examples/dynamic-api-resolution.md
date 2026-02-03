# Dynamic API Resolution
The goal of this document is to dynamically resolve the windows apis and display "hello world" using MessageBoxA.

## 1.  Determine ROR13 Hashes for each api
Helpful script: [./Get-ROR13Hash.ps1](./Get-ROR13Hash.ps1)
```asm
LoadLibraryAConst equ 74776072h
GetProcAddressConst equ 0E553E06Fh
ExitProcessConst equ 0C3F39F16h
```

## 2. Set Data Section
```asm
.data
    user32dll db "user32.dll", 0          ; String for loading user32
    msgboxName db "MessageBoxA", 0        ; String for GetProcAddress lookup
    helloMsg db "Hello World!", 0         ; Message box text
    successMsg db "Success", 0            ; Message box title
```

## 3. Align 16
This will delare how memory will be aligned.
```asm
.code
align 16
```

## 4. GetAPIs Procedure
This function will be called by main
```asm
GetAPIs proc
    ; Input: rsi = DLL imagebase (base address in memory)
    ; Input: rdi = pointer to array for storing resolved API addresses
    ; Output: Fills array with [LoadLibrary, GetProcAddress, ExitProcess]
    
    ; Preserve our registers
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov rbx, rsi                        ; rbx = DLL base address
```

### 4.1 Navigate PE Structure
Walk the PE structure to retrieve the offset to the export table

```asm
    mov eax, dword ptr [rbx + 3Ch]      ; Get e_lfanew offset (points to PE header)
    lea rsi, [rbx + rax]                ; rsi = PE header address
```

### 4.2 Get export directory RVA 
Retrive the relative virtual address of the export table:
```asm
    mov eax, dword ptr [rsi + 88h]      ; Offset 0x88 = DataDirectory[0].VirtualAddress (Export Table)
    lea rsi, [rbx + rax]                ; rsi = export directory absolute address
```

### 4.3 Get export table arrays
The three important arrays are: 
    1. AddressOfFunctions 
    2. AddressOfNameOrdinals
    3. AddressOfNames

Note: You can inspect the exported functions using the following command:
```asm
dumpbin /exports YourLibrary.dll
```
```asm
    mov eax, dword ptr [rsi + 1Ch]      ; Get AddressOfFunctions RVA
    lea r13, [rbx + rax]                ; r13 = AddressOfFunctions (array of function RVAs)

    mov eax, dword ptr [rsi + 24h]      ; Get AddressOfNameOrdinals RVA
    lea r14, [rbx + rax]                ; r14 = AddressOfNameOrdinals (maps name index to ordinal)

    mov eax, dword ptr [rsi + 20h]      ; Get AddressOfNames RVA
    lea r15, [rbx + rax]                ; r15 = AddressOfNames (array of name string RVAs)
```

### 4.4 Start SearchLoop
NumberOfNames is used alongside the loop counters
```asm
    mov eax, dword ptr [rsi + 18h]      ; Get NumberOfNames
    mov r12, rax                        ; r12 = total number of exported names

    xor ecx, ecx                        ; rcx = loop counter (current index)
    xor r10d, r10d                      ; r10d = hash accumulator

SearchLoop:
    cmp rcx, r12                        ; Compare i with NumberOfNames (r12)
    jge Done                            ; If counter >= NumberOfNames jmp Done
```
### 4.5 Get RVA of function name string
This would point to an API function name like `LoadLibraryA`

```asm
    mov eax, dword ptr [r15 + rcx * 4]  ; Get name RVA from AddressOfNames[index]
    test eax, eax                       ; Check if RVA is valid
    jz NextAPI                          ; Skip if null
```

### 4.6 Calculate ROR13 Hash
This is a hash of the function name. This will prevent strings from being show during dissassembly.
```asm
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
```

### 4.7 Compare Hash
After the hash is calculated it is compared:
```asm
CompareHash:
    cmp r10d, LoadLibraryAConst         
    je StoreAPI                        

    cmp r10d, GetProcAddressConst     
    je StoreAPI                      

    cmp r10d, ExitProcessConst      
    je StoreAPI                    
```

### 4.8 Next API
This will increment `rcx` for our loop, reset hash accumulator and jmp back to SearchLoop

```asm
NextAPI:
    inc rcx                             ; Increment loop counter
    xor r10d, r10d                      ; Reset Hash accumulator for next name
    jmp SearchLoop                      ; Back to SearchLoop
```

### 4.9 StoreAPI
When a name is matched we will store the function address.

```asm
StoreAPI:
    xor r11, r11                        ; Clear r11
    mov r11w, word ptr [r14 + rcx * 2]  ; Get ordinal from AddressOfNameOrdinals[index]
    mov eax, dword ptr [r13 + r11 * 4]  ; Get function RVA using ordinal as index
    lea rax, [rbx + rax]                ; Convert RVA to absolute address

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
```

## 6. Main Procedure
Allocate stack space equivalent to at least the shadow space (32bits) + the locals
```asm
main proc
    sub rsp, 58h                        ; Allocate stack space (shadow space + locals)
```

### 6.1 Walk the PEB for DLLBase
The goal is to find `kernelbase.dll`. You may need to use a debugger to ensure you have the right module. If not, you just need to move one `flink` further down the double linked list.
```asm
    mov rax, qword ptr gs:[60h]         ; Get PEB (Process Environment Block) address
    mov rax, qword ptr [rax + 18h]      ; Get PEB->Ldr (loader data)
    mov rax, qword ptr [rax + 20h]      ; Get InMemoryOrderModuleList.Flink (1st module)
    mov rax, qword ptr [rax]            ; Follow Flink to 2nd module
    mov rax, qword ptr [rax]            ; Follow Flink to 3rd module (kernelbase)
    mov rsi, qword ptr [rax + 20h]      ; Get DllBase from LDR_DATA_TABLE_ENTRY
```

### 6.2 Call GetAPIs Procedure
Load the stack space into rdi, and call the procedure.
```asm
    ; Resolve APIs from kernelbase
    lea rdi, [rsp + 30h]                ; rdi = pointer to stack space for API array
    call GetAPIs                        ; Populate array with kernel APIs
```

### 6.3 Load into Registers
Load the resolved API ponters into registers, for easy access later.
```asm
    mov r12, qword ptr [rsp + 30h]      ; r12 = LoadLibraryA address
    mov r13, qword ptr [rsp + 38h]      ; r13 = GetProcAddress address
    mov r14, qword ptr [rsp + 40h]      ; r14 = ExitProcess address
```

## 7. MessageBoxA
MessageBoxA is located in `user32.dll` 

- Consider this like calling a function
- `lea` does not load, it stores the address in a register
- `rcx` is used as a parameter. 
- `sub rsp, 20h` reserves 32 bits of shadow space
- Shadow space is required as a calling convention

```asm
    lea rcx, user32dll                  ; rcx = "user32.dll" (1st parameter)
    sub rsp, 20h                        ; Allocate shadow space (required by x64 calling convention)
    call r12                            ; Call LoadLibraryA("user32.dll")
    add rsp, 20h                        ; Clean up shadow space
    test rax, rax                       ; Check if LoadLibrary succeeded
    jz Exit                             ; If failed (returned NULL), exit
    mov r15, rax                        ; r15 = user32.dll handle
```

### 7.1 Get MessageBoxA function address 
In order to call `MessageBoxA` we need to first call `GetProcAddress`. 

```cpp
FARPROC GetProcAddress(
  [in] HMODULE hModule,
  [in] LPCSTR  lpProcName
    );
```

- Parameter 1 is the `user32.dll` handle `r15`
- Parameter 2 is the string "MessageBoxA". (Defined in `.data` section)

```asm
    mov rcx, r15                        ; rcx = user32 handle (1st parameter)
    lea rdx, msgboxName                 ; rdx = "MessageBoxA" (2nd parameter)
    sub rsp, 20h                        ; Allocate shadow space
    call r13                            ; Call GetProcAddress(user32, "MessageBoxA")
    add rsp, 20h                        ; Clean up shadow space
    test rax, rax                       ; Check if GetProcAddress succeeded
    jz Exit                             ; If failed, exit
```

### 7.2 Call MessageBoxA
Similar to the previous step we will refer to the documentation to get the structure for MessageBoxA
```cpp
int MessageBoxA(
    [in, optional] HWND   hWnd,
    [in, optional] LPCSTR lpText,
    [in, optional] LPCSTR lpCaption,
    [in]           UINT   uType
);
```
- Parameter 1 can be null as we have no parent window
- Parameter 2 is our text defined in `.data`
- Parameter 3 is our caption defined in `.data`
- Parameter 4 is 0 or `MB_OK` (refer to documentation for more)
```asm
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
