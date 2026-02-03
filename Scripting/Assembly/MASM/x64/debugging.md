# Debugging using x64DBG

## 1. Open exe in xdbg.
Note that if you are building 32bit you will need to use the x32dbg.exe instead.

## 2. Run the program
Click the play button to start running the program. 
- Play again jump to your code or breakpoint
- You can step through instructions 

## 3. Breakpoints
Break points will stop execution so you can inspect the register values.

## 4. Follow in dump / Registers
If you need to see a register address you can do so on the right. Red means it's been recently changed.

## 5. Memory map
Once you have determined the address, you can open the memory map to see if you have the right place in memory.
To verify you are in the right place try these commands from the bar at the bottom:

This will set the `rsi` register to the actual BaseAddress of kernel32.  You can then use the above steps to compare your values.
```asm
mov rsi, mod.base("kernel32.dll")
```

