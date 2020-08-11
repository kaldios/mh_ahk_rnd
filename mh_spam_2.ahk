#SingleInstance force

; this is almost the same as the first macro. for now, it's just to have an extra copy.
; key differences are-
; - this one toggles which big monster is focused upon. this can be disabled by commenting out that code.
; - the shortcut menus are used for activating both cloaks. this needs to be config'd precisely or it will not work.
; if you want to use this, let me know so i can (help you?) set it up.

9::

;restart script in admin mode
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%" 
   ExitApp
}

mash := A_MSec
cam := A_Sec
pressed := (A_Min*60 + A_Sec - 145)
Loop,
{

;        sleep, 100
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


; left mantle use on radial key - get color
	
    PixelGetColor, MC, 222, 395 ; 219, 395
    B:="0x" SubStr(MC,3,2) ;substr is to get the piece
    B1:=B+0 ;add 0 is to convert it to the current number format

; right mantle use on radial key - get color
	
    PixelGetColor, MC1, 304, 395
    B2:="0x" SubStr(MC1,3,2) ;substr is to get the piece
    B3:=B2+0 ;add 0 is to convert it to the current number format

; left mantle use on radial key - test usable
	
    if ((B1>36 && B1<50) and !(B3>50 and B3<85))  { ; item (ghillie mantle+) ready
        Send {f5 down} ; shortcut 1 (top)
        sleep, 100
        Send {f5 up} ;
        sleep, 100
        Send {2 down} ; location 2
        sleep, 100
        Send {2 up} ;
    }

; right mantle use on radial key - test usable
	
    if ((B3>95 and B3<115) and !(B1>50 and B1<85)) { ; vitality mantle
        Send {f1 down} ; shortcut key. default is f1.
        sleep, 100
        Send {f1 up} ;
        sleep, 100
        Send {3 down} ;
        sleep, 100
        Send {3 up} ;
    }

; see mantle colors detected
; ToolTip, %MC%`r%B1%`r%MC1%`r%B3%, 4000, 4000, 1 ; displays the colors found by the GetPixelColor code above. full hex color, and required segment in dec.
; ToolTip, |, 222, 400, 2 ; not really needed. used as a marker for seeing where GetPixelColor is pointed.
; ToolTip, |, 304, 400, 3 ; same as above. one for each mantle.
 
 
 ; active wheel item use on timer
;	press := (A_Min*60 + A_Sec)
;	if (GetKeyState("e"))
;	{
;    	Send {e up} ;
;	}
;	if (press - pressed < 0)
;	{
;	    pressed := pressed - 150
;	}
;	if (press - pressed > 150)
;	{
;        Send {e down} ;
;        sleep, 100
;		pressed := press
;	}
 
 ; toggle monster focus
  press := (A_Min*60 + A_Sec)
  if (GetKeyState("q"))
  {
      Send {q up} ;
  }
  if (press - pressed < 0)
  {
      pressed := pressed - 150
  }
  if (press - pressed > 150)
  {
      Send {q down} ; make this line a comment to disable. or comment the whole block.
      sleep, 5
      pressed := press
  }

; ToolTip , Text, X, Y, WhichToolTip
; kill tooltip 
  if (GetKeyState("0"))
      ToolTip

; break loop. 
  if (GetKeyState("0"))
      break
}	;
return

; notes
; screen center: 1920, 1076
; bottom right?: 3840, 2152 % 0.0578125 | 0.0791666666666667, 0.1835501858736059

^0::Reload
