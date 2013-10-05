WindowResizer
=============

An [Alfred 2](http://www.alfredapp.com/) Workflow that will resize windows to exact pixel dimensions.


Installation
=============
Download the [workflow](https://github.com/GarthDB/WindowResizer/releases) file and double click it to install it in Alfred.


Usage
=============

The worklow is simple.  It just resizes the topmost window to the pixel dimensions entered.  Format the dimensions as `WIDTHxHEIGHT` (replacing `WIDTH` and `HEIGHT` with the size in pixels).

Exmaple:

```
resizer 400x500
```
![Resizer](//screenshot.png)

Script
===

The actual AppleScript is:

```AppleScript
to splitString(aString, delimiter)
	set retVal to {}
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {delimiter}
	set retVal to every text item of aString
	set AppleScript's text item delimiters to prevDelimiter
	return retVal
end splitString
on alfred_script(q)
	set newDimensions to splitString(q as text, "x")
	tell application "System Events"
		set frontApp to name of first application process whose frontmost is true
	end tell
	
	try
		tell application frontApp
			set current to bounds of the first window
			tell window 1
				set the bounds to {item 1 of current, item 2 of current, (item 1 of current) + (item 1 of newDimensions), (item 2 of current) + (item 2 of newDimensions)}
			end tell
		end tell
	on error errMsg
		tell application "System Events" to tell application process frontApp
			tell window 1
				set size to {item 1 of newDimensions, item 2 of newDimensions}
			end tell
		end tell
	end try
	
end alfred_script
```

Colophon
===

* This workflow uses Geert JM Vanderkelen's [string splitter example](http://geert.vanderkelen.org/splitting-as-string-and-joining-a-list-using-applescript/).
* The resize icon has been added to [The Noun Project](http://thenounproject.com/garthdb/)
