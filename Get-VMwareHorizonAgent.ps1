# looks up registry key on a system for the version of the VMware Horizon View Agent installed
[Cmdletbinding()]
param (
    [Parameter(Mandatory,
        ValueFromPipelineByPropertyName)]
    [string[]]$ComputerName
)

Invoke-Command $ComputerName {
    Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\VMware, Inc.\AgentVersions' -Name 'View-Agent' |
    Select-Object PSComputerName, View-Agent
}