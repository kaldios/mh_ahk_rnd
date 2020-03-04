9:: ; start key. change if wanted/needed. :: is required.

;restart script in admin mode
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%" 
    ExitApp
}

mash := a_sec
pressed := (a_min*60 + a_sec - 145)
Loop,
{

; spam button for picking stuff up.
    mashed := a_sec
    if (GetKeyState("f"))
    {
        Send {f up} ;
    }
    if (mashed - mash < 0)
    {
        mash := mashed
    }
    if (mashed - mash > 0)
    {
        mash := mashed
        Send {f down} ;
        sleep, 100
    }
		
; mantle/item use on timer. presses the use item button at set intervals. can be omitted.
    press := (a_min*60 + a_sec)
    if (GetKeyState("e"))
    {
        Send {e up} ;
    }
    if (press - pressed < 0)
    {
        pressed := pressed - 150
    }
    if (press - pressed > 150)
    {
        Send {e down} ;
        sleep, 100
        pressed := press
    }

; break loop. end key. change as wanted/needed.
    if (GetKeyState("0"))
        break
}	;
return
