# 🧪 Code Tester – AutoHotkey v2

 Code Tester – AutoHotkey v2

A lightweight, fast, and safe **AutoHotkey v2 script testing utility** that allows you to write, run, debug, and clean up temporary test scripts without affecting your main AHK environment.

Perfect for developers who frequently test short code snippets, GUI components, automation logic, or experimental AHK functions.

----------

## 📌 **Features**

-   Run AHK v2 code instantly in a separate temporary script.
    
-   Uses **timestamped file names** → `Test_24_20_15_42.ahk` (DD_HH_MM_SS)
    
-   Automatic cleanup of all `Test_*.ahk` instances when the main GUI exits.
    
-   Isolated execution → your main script stays untouched.
    
-   Supports:
    
    -   Clipboard-based code execution
        
    -   GUI editor integration
        
    -   Automatic temp file deletion on exit
        
    -   Error-free execution with validation
        

----------

# 📂 How It Works

The Code Tester creates a **temporary AutoHotkey file**, writes your script into it, runs it, and then automatically cleans up leftover test files.

📘 Usage Instructions

1️⃣ Write or paste AHK v2 code

Enter your AutoHotkey v2 snippet in the tester’s editor window or paste from clipboard.

Example:

MsgBox "Hello from test script!"

2️⃣ Run the code

Click Run Test.
The tool will:

Generate a unique file name based on date/time
Example:

Test_24_17_45_10.ahk


Save your script into the temp directory.

Execute it using the AutoHotkey64.exe runner.

3️⃣ View script output

Your test script will run as a separate AHK process. Anything it displays (MsgBox, GUI, TrayTip, etc.) is shown normally.

4️⃣ Cleanup

When you Exit the main GUI the tool automatically deletes: **Test_*.ahk** from the temp path so no leftover files remain.

## Happy Scripting !!!
