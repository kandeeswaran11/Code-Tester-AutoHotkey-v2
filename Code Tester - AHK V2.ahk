;vt,mt,tnkat,vk,vt,jsr,srj,
#requires Autohotkey 2.0+
#SingleInstance Force

; Create GUI
myGui := Gui("AlwaysOnTop", "AHK V2 - Code Tester")
myGui.SetFont("s14", "Courier New")
myGui.MarginX := 5
myGui.MarginY := 5

; Edit Control (default colors)
Edit1 := myGui.Add("Edit", "x0 y0 w300 h300 +VScroll +HScroll")

; Buttons
RunBtn  := myGui.Add("Button", "x0 y310 w80 h30", "Run")
ExitBtn := myGui.Add("Button", "x90 y310 w80 h30", "Exit")

RunBtn.OnEvent("Click", RunCode)
ExitBtn.OnEvent("Click", (*) => exitallscripts())

exitallscripts()
{
;CleanupTestScripts()
myGui.Destroy()
}

; Allow resize
myGui.OnEvent("Size", GuiSize)
myGui.Opt("+Resize +MaximizeBox")
myGui.Show("w320 h360")
myGui.OnEvent("Close", (*) => CleanupTestScripts())

CleanupTestScripts() {
    scriptDir := A_ScriptDir "\TestScript"

    ; --- Kill running Test_*.ahk processes ---
    Loop Files scriptDir "\Test_*.ahk" {
        fullPath := A_LoopFileFullPath

        ; Get list of running AutoHotkey processes
        for proc in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name='AutoHotkey.exe'") {
            if InStr(proc.CommandLine, fullPath) {   ; Script match
                try ProcessClose(proc.ProcessId)
            }
        }

        ; Delete the script file
        try FileDelete(fullPath)
    }

    ExitApp
}


; Resize logic
GuiSize(thisGui, MinMax, W, H) {
    if MinMax = -1
        return
    Edit1.Move(, , W-5, H-60)
    RunBtn.Move(10, H-45)
    ExitBtn.Move(100, H-45)
}

/*;  Run button logic Test CASe
RunCode(*) {
    MsgBox Edit1.Value
}
*/

; Hotkeys for scrolling (context-sensitive)
#HotIf WinActive("Code Tester ahk_class AutoHotkeyGUI")
WheelUp::ScrollLines(-5)
WheelDown::ScrollLines(5)
#HotIf

; Run button handler
RunCode(*) {
	Edit1.value := Edit1.value ;"`npause::pause -1"
    ExecScript(Edit1.Value)
	
}

; Execute script function
ExecScript(Script) {
    ; Path to folder
    scriptDir := A_ScriptDir "\TestScript"
    DirCreate(scriptDir)

    ; --- Generate Date-Time Format ---
    dateTime := FormatTime(A_Now, "dd-MM-yyyy_HH_mm_ss")

    ; File path
    tempFile := scriptDir "\Test_" dateTime ".ahk"

    ; Optionally delete older files
    Loop Files scriptDir "\Test_*.ahk" {
        try FileDelete(A_LoopFileFullPath)
    }

    ; Write script
    FileAppend Script, tempFile, "UTF-8"

    ; Run it
    Run A_AhkPath ' "' tempFile '"'
}



; Scroll lines function
ScrollLines(lines, _hWnd := "") {
    static EM_LINESCROLL := 0xB6
    if (!_hWnd) {
        _hWnd := ControlGetFocus("A")
        _hWnd := ControlGetHwnd(_hWnd, "A")
    }
    PostMessage(EM_LINESCROLL, 0, lines, , "ahk_id " _hWnd)
}
