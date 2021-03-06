# uninstalls the Horizon Agent from the computer
# CAUTION: THE COMPUTER WILL RESTART AUTOMATICALLY WHEN FINISHED

$application = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, ModifyPath |
    Where-Object {$_.DisplayName -eq 'VMware Horizon Agent'}
$modstring = $application.ModifyPath

$split = $modstring.Split(" ")
$split2 = $split[1]
$split3 = $split2.Substring(2)

$fullstring = "/X" + $split3 + " /norestart /quiet"

Start-Process msiexec.exe -ArgumentList "$fullstring" -Wait
$Test = Test-Path 'C:\Program Files\VMware\VMware View\Agent'
if ($Test -eq $false) {
    Write-Output "Horizon Agent uninstalled - rebooting."
    Restart-Computer -Force
}
else {
    Write-Output "The Horizon Agent was not installed."
}