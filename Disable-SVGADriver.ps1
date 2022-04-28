# checks the current installed version of the VMware Horizon Agent and disables the SVGA video driver if the Agent version is 8.4 or higher

$AgentVersion = Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\VMware, Inc.\AgentVersions' -Name 'View-Agent' |
    Select-Object -ExpandProperty View-Agent

$VersionNumbers = $AgentVersion.Split('.')
[int]$NumberOne = $VersionNumbers[0]
[int]$NumberTwo = $VersionNumbers[1]

if ($NumberOne -gt 8) {
    Get-PnpDevice -FriendlyName "VMware SVGA 3D" | Disable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Write-Output Write-Output "Horizon Agent version: $AgentVersion"
    Restart-Computer -ComputerName $env:COMPUTERNAME -Force
}
elseif ($NumberOne -ge 8 -and $NumberTwo -ge 4) {
    Get-PnpDevice -FriendlyName "VMware SVGA 3D" | Disable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Write-Output "Horizon Agent version: $AgentVersion"
    Restart-Computer -ComputerName $env:COMPUTERNAME -Force
}