# PE Format

## TEB
Some common offsets contained in the TEB structure:

| Hex | Description |
| --- | ----------- |
| 0x00 | Pointer to start of TEB |
| 0x08 | Top of stack |
| 0x10 | Start of stack |
| 0x30 | Address of TEB |
| 0x60 | Pointer to PEB |

Retrieve the PEB:
```asm
mov rax, qword ptr gs:[60h]
```

## PEB
| Hex | Name |
| --- | ---- |
| 0x02 | BeingDebugged | 1 byte value |
| 0x18 | PPEB_LDR_DATA | Pointer to PEB_LDR_DATA |
| 0x20 | ProcessParamaters | Pointer to RTL_USER_PROCESS_PARAMETERS (cli and env vars) |
| 0x30 | ProcessHeap | Base address of process heap |
| 0x1D4 | SessionId | Terminal services session id |

Retrieve pointer to PEB_LDR_DATA
```asm
mov rax, qword ptr gs:[60h]
mov rax, qword ptr [rax + 18h]
```

## PEB_LDR_DATA
| Hex | Name |
| --- | ---- |
| 0x00 | Reserved1 |
| 0x08 | Reserved2 |
| 0x10 | InLoadOrderModuleList |
| 0x20 | InMemoryOrderModuleList |
| 0x30 | InInitializationOrderModuleList |

```asm
mov rax, qword ptr gs:[60h]     ; PEB
mov rax, qword ptr [rax + 18h]  ; PEB + PEB_LDR_DATA
mov rax, qword ptr [rax + 20h]  ; PEB_LDR_DATA + InMemoryOrderModuleList
```

## InInitializationOrderModuleList
Is a `LIST_ENTRY` structure:
```asm
LIST_ENTRY struct
    Flink   DQ ?    ; Pointer to next entry
    Blink   DQ ?    ; Pointer to previous entry
LIST_ENTRY ENDS
```

### Flink / Blink
You traverse the doubly-linked list by referencing the `Flink` (forwards) or `Blink` (backwards). 
```asm
mov rax, [rax]          ; Flink
mov rax, [rax + 8h]     ; Blink
```
- `rax` contains the memory address of the current `LIST_ENTRY` node
- `[rax]` is a dereference and tells CPU to look at the memory at that address.
- The first member `0x00` is the `Flink` and is an 8 byte address for the next node.
- The second member `0x08` is the `Blink` and is an 8 byte address for the previous node.
- This result address is then loaded into `rax` replacing the old.


The result will be a `LDR_DATA_TABLE_ENTRY` structure:

## LDR_DATA_TABLE_ENTRY
Pointers are 8 bytes (QWORD)

| Hex | Name | Description |
| --- | ---- | ----------- |
| 0x00 | InLoadOrderLinks | Contains Flink and Blink pointers |
| 0x10 | InMemoryOrderLinks | Modules loaded in memory |
| 0x20 | InInitializationOrderLinks | Modules initilaized |
| 0x30 | DllBase | Modules base address |
| 0x38 | EntryPoint | Module entry point |
| 0x40 | SizeOfImage | Total size in memory |
| 0x48 | FullDllName | Full path to dll |
| 0x58 | BaseDllName | Filename of dll |

```asm
mov rax, qword ptr gs:[60h]     ; PEB Pointer
mov rax, qword ptr [rax + 18h]  ; PEB_LDR_DATA
mov rax, qword ptr [rax + 20h]  ; InMemoryOrderModuleList

mov rax, qword ptr [rax]        ; Flink  currently offset 0x10
mov rsi, qword ptr [rax + 20h]  ; Flink 0x10 + 0x20 = 0x30 DllBase
```

## IMAGE_DOS_HEADER
| Hex | Name | Description |
| --- | ---- | ----------- |
| 0x00 | e_magic | Magic Number MZ |
| 0x02 | e_cblp | Bytes on last page of file |
| 0x04 | e_cp | Pages in file |
| 0x06 | e_crlc | Relocations |
| 0x08 | e_cparhdr | Size of header in paragraphs |
| 0x0A | e_minalloc | Minimum extra paragraphs |
| 0x0C | e_maxalloc | Maximum extra paragraphs |
| 0x0E | e_ss | Initial (relative) SS value |
| 0x10 | e_sp | Initial SP value |
| 0x12 | e_csum | Checksum |
| 0x14 | e_ip | Initial IP value |
| 0x16 | e_cs | Initial CS value |
| 0x18 | e_lfarlc | File address of relocation table |
| 0x1A | e_ovno | Overlay number |
| 0x1C | e_res | Reseverved words | 
| 0x24 | e_oemid | OEM identifier |
| 0x26 | e_oeminfo | OEM information | 
| 0x28 | e_res2 | Reserved words |
| 0x3C | e_lfanew | File address of new PE header |

The e_lfanew field points to IMAGE_NT_HEADERS64. 
- It is a dword so the ecx register is used (the lower 32 bits)
- rcx will contain the full 64 bit address
- Adding it to rsi will give the absolute address
```asm
; rsi kernel32 image base
mov ecx, dword ptr [rsi + 3Ch]
mov rax, rcx
add rax, rsi ; Should contain 'PE' in ASCII
```

## IMAGE_NT_HEADER64
| Hex | Name | Description |
| --- | ---- | ----------- |
| 0x00 | Signature | 4 Byte signature (PE\0\0) |
| 0x04 | FileHeader | COFF header info about file layout |
| 0x18 | OptionalHeader | 64 bit optional header |

To retrieve the OptionalHeader:
```asm
mov rax, qword ptr [rax + 18h]
```

## IMAGE_OPTIONAL_HEADER64
| Hex | Name |
| --- | ---- |
| 0x00 | Magic |
| 0x02 | MajorLiknerVersion |
| 0x03 | MinorLinkerVersion |
| 0x04 | SizeOfCode |
| 0x08 | SizeOfInitializedData |
| 0x0C | SizeOfUnInitializedData |
| 0x10 | AddressOfEntryPoint |
| 0x14 | BaseOfCode |
| 0x18 | ImageBase |
| 0x20 | SectionAlignment |
| 0x24 | FileAlignment |
| 0x28 | MajorOperatingSystemVersion |
| 0x2A | MinorOperatingSystemVersion |
| 0x2C | MajorImageVersion |
| 0x2E | MinorImageVersion |
| 0x30 | MajorSubsystemVersion |
| 0x32 | MinorSubsystemVersion |
| 0x34 | Win32VersionValue |
| 0x38 | SizeOfImage |
| 0x3C | SizeOfHeaders |
| 0x40 | CheckSum |
| 0x44 | Subsystem |
| 0x46 | DllCharacteristics |
| 0x48 | SizeOfStackReserve |
| 0x50 | SizeOfStackCommit |
| 0x58 | SizeOfHeapReserve |
| 0x60 | SizeOfHeapCommit |
| 0x68 | LoaderFlags |
| 0x6C | NumberOfRvaAndSizes |
| 0x70 | DataDirectory |

To get the DataDirectory[0]:
```asm
mov rax, qword ptr [rax + 18h]      ; IMAGE_OPTIONAL_HEADERS64
mov rax, qword ptr [rax + 0x70]     ; IMAGE_DATA_DIRECTORY[0] -> RVA of the first entry
```

## IMAGE_DATA_DIRECTORY
The above code will land at 0x00 which will be the Relative Virtual Address (RVA):
| Hex | Name |
| --- | ---- |
| 0x00 | VirtualAddress |
| 0x04 | Size |
```asm
mov rax, qword ptr [rax + 18h]      ; IMAGE_OPTIONAL_HEADERS64
mov rax, qword ptr [rax + 0x70]     ; IMAGE_DATA_DIRECTORY[0] -> RVA of the first entry
```

## IMAGE_EXPORT_DIRECTORY
| Hex | Name |
| --- | ---- |
| 0x00 | Characteristics | DWORD | Reserved typically 0 |
| 0x04 | TimeDateStamp | DWORD | When export data was created |
| 0x08 | MajorVersion | WORD | Major Version |
| 0x0A | MinorVersion | WORD | Minor Version |
| 0x0C | Name | DWORD | RVA pointing to ASCII string that is name of DLL |
| 0x10 | Base | DWORD | Starting ordinal number for all functions in the export address table |
| 0x14 | NumberOfFunctions | DWORD | Total number of functions exported |
| 0x18 | NumberOfNames | DWORD | Number of exported functions that have names |
| 0x1C | AddressOfFunctions | DWORD | RVA pointing to export address table |
| 0x20 | AddressOfNames | DWORD | RVA pointing to export name pointer tables |
| 0x24 | AddressOfNameOrdinals | DWORD | RVA pointing to export ordinal table. Serves as index for AddressOfFunctions |

To find your API you must:
- Search for name in `AddressOfNames`, get index
- Reference index in `AddressOfNameOrdinals`, get index
- Reference index in `AddressOfFunctions` to get RVA
- Add RVA to imagebase for absolute address

```asm
mov edx, dwordptr [rcx + 18h]   ; IMAGE_EXPORT_DIRECTORY.AddressOfNames
mov edx, dwordptr [rcx + 1Ch]   ; IMAGE_EXPORT_DIRECTORY.AddressOfFunctions
mov edx, dwordptr [rcx + 20h]   ; IMAGE_EXPORT_DIRECTORY.NumberOfNames
mov edx, dwordptr [rcx + 24h]   ; IMAGE_EXPORT_DIRECTORY.AddressOfName Ordinals
```

### AddressOfNameOrdinals
Using the RVA will point to an array in memory where each element is a 16 bit word (2 bytes).

```asm
movzx ecx, word ptr [eax + ecx * 2]
```
- Go to address stored in eax (base of ordinals array)
- Calculate an offset using current index in `ecx` * 2 (because each entry is 2 bytes)
- `word ptr []` indicates that we will only read 2 bytes


