# Component Object Model (COM)
Spec for creating re-usable software components.

- Graphics
- Text
- Windows Shell
- Ribbon Control
- UI Animations

Key points:
- Calling code never sees the type of the derived class. You would never declare a variable of type `Shape`.
- All operations would be performed using pointers.
- Defining new COM interfaces are done in an `idl` file (Interface Definition Language)

## COM Interfaces
Interfacess define sets of methods that an object can support without dictating anything about the implementation.

A hypothetical interface:
- Starts with "I"
- Defines a single operation Draw();
```cpp
interface IDrawable
{
    void Draw();
}
```

The `Shape` and `Bitmap` classes define 2 distinct types of drawable object.
- Each class inherits from `IDrawable`
```cpp
class Shape: public IDrawable
{
    public: 
        virtual void Draw();
};

class Bitmap: public IDrawable 
{
    public: 
        virtual void Draw();
};
```

Programs using this library would manipulate objects through pointers.
```cpp
IDrawable *pDrawable = CreateTriangleShap();
if (pDrawable) {
    pDrawable->Draw();
}
```

Multiple Interfaces
```cpp
class ISerializable {
    public: 
        virtual void Load(PCWSTR filename) = 0; // Load from file
        virtual void Save(PCWSTR filename) = 0; // Load from file
};

class Shape: public IDrawable {
};

class Bitmap: public IDrawable, public ISerializable {
};
```

## 1. Initialize the COM library:
[Initializing COM Librarys](https://learn.microsoft.com/en-us/windows/win32/learnwin32/initializing-the-com-library)
- Generally if a thread creates a window, you should use `COINIT_APARTMENTTHREADED`
- Some components require a specific model
- It's possible to share interfaces between threads using `marshalling`
- Setting the `COINIT_DISABLE_OLE1DDE` avoids overhead with object linking and embedding (obsolete tech)

```cpp
HRESULT hr = CoInitializeEx(
    NULL,  // Resevered and must be NULL
    COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE // Threading
);
```

## 2. Error Reporting
- returns a value of type `HRESULT`
- 32 bit int
- high order bit signals success or fail
- Zero = success, 1 = fail
- Success codes: 0x0 - 0x7FFFFFFF
- Failure codes: 0x80000000-0xFFFFFFFF

```cpp
HRESULT hr = CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);

if (SUCCEEDED(hr)) {
}

if (FAILED(hr)) {
    
}
```

2. Modify COM Security settings:

Uninitialize the COM library:
```cpp
CoUninitialize();
```
