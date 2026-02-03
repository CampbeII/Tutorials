# Reading Structs
When viewing the documentation, you will often see structs. These will contain the relevant fields and their sizes.

## Determining the offset
To determine the offset you will need to be familiar with the types of fields and their size.

| Type | Bytes | Bits |
| ---- | ----- | ---- |
| WORD  | 2    | 16   |
| DWORD | 4    | 32   |
| QWORD | 8    | 64   |

```asm
typdef struct _IMAGE_NT_HEADERS64
    DWORD Signature,
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER64 OptionalHeader;

```
