# uninstalls the Horizon Agent from the computer
# CAUTION: THE COMPUTER WILL RESTART AUTOMATICALLY WHEN FINISHED

$application = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, ModifyPath | Where-Object {$_.DisplayName -eq 'VMware Horizon Agent'}
$modstring = $application.ModifyPath

$split = $modstring.Split("/X")
$split2 = $split[2]
$fullstring = "/X" + $split2 + " /forcerestart /quiet"

Start-Process msiexec.exe -ArgumentList "$fullstring"