# C++ 

## Compiling 

Prerequisits:
1. Install Visual Studio
You can choose to install visual studio or the smaller visual studio code. This step is recommended because VS will handle all the dependencies and help you debug in the future.

2. Edit PATH
Edit your environment variables to include the location of MSBuild. This likely differs for each version.
`C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin`. This will allow you to run it from the command line.

3. Create Source Files
Project
- main.cpp
- main.h
- myproject.vcxproj

4. Use MSBuild
The following command will generate `myproject.exe`
```sh
msbuild Project/myproject.vcxpro /p:configuration=debug
```
