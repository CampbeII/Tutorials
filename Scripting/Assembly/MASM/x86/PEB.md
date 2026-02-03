# Walking the PEB

The address of the PEB is located at `fs:[30]`
```asm
typedef struct TEB {
        dword EnvironmentPointer;                 // FS:[1C]
        dword ProcessId;                         // FS:[20]
        dword threadId;                         // FS:[24]
        dword ActiveRpcInfo;                     // FS:[28]
        dword ThreadLocalStoragePointer;             // FS:[2C]
        PEB* Peb;                             // FS:[30]
        dword LastErrorValue;                     // FS:[34]
};
```

Access `LDR_DATA` at `mov eax, [eax + 0Ch]`
```asm
typedef struct _PEB {
        BOOLEAN InheritedAddressSpace;     //+00
        BOOLEAN ReadImageFileExecOptions;     //+01
        BOOLEAN BeingDebugged;             //+02
        BOOLEAN Spare;                 //+03
        HANDLE Mutant;                 //+04
        PVOID ImageBaseAddress;         //+08
        PPEB_LDR_DATA LoaderData;         //+0C
        PRTL_USER_PROCESS_PARAMETERS ProcessParameters; //+10
        PVOID SubSystemData;             //+14
        PVOID ProcessHeap;             //+18
        PVOID FastPebLock;             //+1C
        PPEBLOCKROUTINE FastPebLockRoutine; //+20
        PPEBLOCKROUTINE FastPebUnlockRoutine; //+24
        ULONG EnvironmentUpdateCount;     //+28
        PPVOID KernelCallbackTable;         //+2C
        PVOID EventLogSection;             //+30
        PVOID EventLog;                 //+34
        PPEB_FREE_BLOCK FreeList;         //+38
        ULONG TlsExpansionCounter;         //+3C
        PVOID TlsBitmap;                 //+40
        ULONG TlsBitmapBits[0x2];         //+44
        PVOID ReadOnlySharedMemoryBase;     //+4C
        PVOID ReadOnlySharedMemoryHeap;     //+50
        PPVOID ReadOnlyStaticServerData;     //+54
        PVOID AnsiCodePageData;         //+58
        PVOID OemCodePageData;             //+5C
        PVOID UnicodeCaseTableData;         //+60
        ULONG NumberOfProcessors;         //+64
        ULONG NtGlobalFlag;             //+68
        BYTE Spare2[0x4];             //+6C
        LARGE_INTEGER CriticalSectionTimeout; //+74
        ULONG HeapSegmentReserve;         //+78
        ULONG HeapSegmentCommit;         //+7C
        ULONG HeapDeCommitTotalFreeThreshold;//+80
        ULONG HeapDeCommitFreeBlockThreshold;//+84
        ULONG NumberOfHeaps;             //+88
        ULONG MaximumNumberOfHeaps;         //+8C
        PPVOID *ProcessHeaps;             //+90
        PVOID GdiSharedHandleTable;
        PVOID ProcessStarterHelper;
        PVOID GdiDCAttributeList;
        PVOID LoaderLock;
        ULONG OSMajorVersion;
        ULONG OSMinorVersion;
        ULONG OSBuildNumber;
        ULONG OSPlatformId;
        ULONG ImageSubSystem;
        ULONG ImageSubSystemMajorVersion;
        ULONG ImageSubSystemMinorVersion;
        ULONG GdiHandleBuffer[0x22];
        ULONG PostProcessInitRoutine;
        ULONG TlsExpansionBitmap;
        BYTE TlsExpansionBitmapBits[0x80];
        ULONG SessionId;
} PEB, *PPEB;
```

PEB_LDR_DATA
| Offset | Value |
| ------ | ----- |
| `0x0C` | InLoadOrderModuleList|
| `0x14` | InMemoryOrderModuleList |
| `0x1C` | InInitializationOrderModuleList |

LDR_DATA_TABLE_ENTRY
| `0x00` | InLoadOrderLinks |
| `0x08` | InMemoryOrderLinks |
| `0x10` | InInitializationOrderLinks |
| `0x18` | DllBase |
| `0x1C` | EntryPoint |
| `0x20` | SizeOfImage |
| `0x24` | FullDllName |
| `0x2C` | BaseDllName |

```asm
typedef struct TIB
{
PEXCEPTION_REGISTRATION_RECORD* ExceptionList;     //FS:[0x00]
        dword StackBase;                          //FS:[0x04]
        dword StackLimit;                     //FS:[0x08]
        dword SubSystemTib;                     //FS:[0x0C]
        dword FiberData;                         //FS:[0x10]
        dword ArbitraryUserPointer;                 //FS:[0x14]
        dword TIB;                             //FS:[0x18]
};
```

