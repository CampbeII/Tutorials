# Compiling MASM

# x64
You can either download MASM independently, or include it as part of the Visual Studio environment. I chose to use the include VS versions.

1. Write your `.asm` file
2. Open up the 'x64 Native Tools' developer prompt. This will have all the correct paths set so we do not need to worry about them.
3. Compile using:
```asm
ml64 test.asm /link /subsystem:console /entry:main
```

Alternatively, you can also add the path to your user environment variables:
```
C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64
```
