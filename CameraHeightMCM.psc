Scriptname CameraHeightMCM extends SKI_ConfigBase

int function GetVersion()
    return 1
endFunction

float fCurrentHeight = 0.0
float fDefaultHeight = 0.0
int iHeightSliderID

event OnConfigInit()
    ModName = "1st person Camera Adjustment"
    Pages = new string[1]
    Pages[0] = "General"
endEvent

event OnPageReset(string page)
    if (page == "General")
        SetCursorFillMode(TOP_TO_BOTTOM)
        iHeightSliderID = AddSliderOption("1st Person Camera Height", fCurrentHeight, "{1}")
    endif
endEvent

event OnOptionSliderOpen(int option)
    if (option == iHeightSliderID)
        SetSliderDialogStartValue(fCurrentHeight)
        SetSliderDialogDefaultValue(fDefaultHeight)
        SetSliderDialogRange(-20.0, 50.0)
        SetSliderDialogInterval(1.0)
    endif
endEvent

event OnOptionSliderAccept(int option, float value)
    if (option == iHeightSliderID)
        fCurrentHeight = value
        SetSliderValue(option, fCurrentHeight)
        UpdateCamera()
    endif
endEvent

function UpdateCamera()
    Game.SetGameSettingFloat("fFirstPersonCameraHeight", fCurrentHeight)
endFunction

event OnConfigClose()
    ; This forces the game to reload camera settings
    Game.ForceThirdPerson()
    Utility.Wait(0.1)
    Game.ForceFirstPerson()
endEvent
