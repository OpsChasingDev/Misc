$VDI = (Get-ADComputer -Filter *).Name

Invoke-Command -ComputerName $VDI -ErrorAction SilentlyContinue {
    Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\VMware, Inc.\AgentVersions' -Name 'View-Agent' |
    Select-Object PSComputerName, View-Agent
}

