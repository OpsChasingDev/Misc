# gets the logged in user through a VBScript and writes the username to output

$Login = cscript.exe \\SL-DC-01\NETLOGON\login.vbs
$Login = Write-Output $Login[3]