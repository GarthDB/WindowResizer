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