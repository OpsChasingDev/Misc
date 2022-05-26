' Retrieve user name.
Set objNetwork = CreateObject("Wscript.Network")
strUserName = objNetwork.UserName

' Write retrieved user name out to the console
WScript.Echo strUserName