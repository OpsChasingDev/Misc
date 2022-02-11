# uninstalls the Horizon Agent from the computer
# CAUTION: THE COMPUTER WILL RESTART AUTOMATICALLY WHEN FINISHED

$application = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, ModifyPath |
    Where-Object {$_.DisplayName -eq 'VMware Horizon Agent'}
$modstring = $application.ModifyPath

#$split = $modstring.Split("/X")
$split = $modstring.Split(" ")
$split2 = $split[1]
$split3 = $split2.Substring(2)

#$fullstring = $split2 + " /forcerestart /quiet"
$fullstring = "/X" + $split3 + " /forcerestart /quiet"

Start-Process msiexec.exe -ArgumentList "$fullstring"