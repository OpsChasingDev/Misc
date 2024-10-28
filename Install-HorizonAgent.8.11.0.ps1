# install Horizon Agent 64x bit version 8.11.0-22661444
# CAUTION: THE COMPUTER WILL RESTART AUTOMATICALLY WHEN FINISHED

Start-Process -FilePath 'C:\HorizonTemp\VMware-Horizon-Agent-x86_64-2309-8.11.0-22661444.exe' -ArgumentList '/s /v"/qn VDM_VC_MANAGED_AGENT=1 REBOOT=ReallySuppress"' -Wait
$Test = Test-Path 'C:\Program Files\VMware\VMware View\Agent'
if ($Test -eq $true) {
    Write-Output "Horizon Agent installed - rebooting."
    Restart-Computer -Force
}
else {
    Write-Output "The Horizon Agent was not installed."
}