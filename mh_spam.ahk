#SingleInstance force

9:: ; start key. change if wanted/needed. :: is required.

;restart script in admin mode
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%" 
    ExitApp
}

mash := A_MSec
cam := A_Sec
pressed := (a_min*60 + a_sec - 145)
Loop,
{

; spam button for picking stuff up.
    mashed := A_MSec
	if (GetKeyState("f"))
	{
    	Send {f up} ;
        sleep, 5
    }
    if (mashed - mash < 0 || mashed - mash > 500)
    {
        mash := mashed
        Send {f down} ;
        sleep, 5
    }
		
; mantle/item use on timer. presses the use item button at set intervals. can be omitted.
    press := (a_min*60 + a_sec)
    if (GetKeyState("e"))
    {
        Send {e up} ;
        sleep, 5
    }
    if (press - pressed < 0)
    {
        pressed := pressed - 150
        Send {e down} ;
        sleep, 5
    }
    if (press - pressed > 150)
    {
        pressed := press
        Send {e down} ;
        sleep, 5
    }

; force camera forward
    camera := A_Sec
    if (GetKeyState("ctrl"))
    {
        Send {ctrl up} ;
        sleep, 5
    }
    if (camera - cam < 0 || camera - cam > 3)
    {
        cam := camera
        Send {ctrl down} ;
        sleep, 5
    }

; break loop. end key. change as wanted/needed.
    if (GetKeyState("0"))
        break
}	;
return
