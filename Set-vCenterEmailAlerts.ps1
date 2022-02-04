
# $vCenter = Connect-VIServer vcenter01-atl.theprestonpartnership.com -Force

param (
    [Parameter(Mandatory)]
    [String]$email
)

# host hardware
$HostHardware = Get-AlarmDefinition "host hardware*" | New-AlarmAction -Email -To $email -Subject "Host Hardware Problem"
# host connection
$HostConnection = Get-AlarmDefinition "host con*" | New-AlarmAction -Email -To $email -Subject "Host Connection Problem"
# host cpu
$HostCPU = Get-AlarmDefinition "host cpu*" | New-AlarmAction -Email -To $email -Subject "Host CPU Problem"
# host memory
$HostMemory = Get-AlarmDefinition "host memory*" | New-AlarmAction -Email -To $email -Subject "Host Memory Problem"
# vSphere HA
$vSphereHA = Get-AlarmDefinition "vSphere HA*" | New-AlarmAction -Email -To $email -Subject "vSphere HA Problem"
# vCenter
$vCenter = Get-AlarmDefinition "vCenter*" | New-AlarmAction -Email -To $email -Subject "vCenter Problem"
# expired licenses
$License = Get-AlarmDefinition "Expired*" | New-AlarmAction -Email -To $email -Subject "License Problem"
# datastore space
$DatastoreUsage = Get-AlarmDefinition "datastore usage on disk" | New-AlarmAction -Email -To $email -Subject "Datastore Usage Problem"
# datastore connection
$DatastoreConnection = Get-AlarmDefinition "cannot connect*" | New-AlarmAction -Email -To $email -Subject "Datastore Connection Problem"

<################################>
<# remove email actions #>
<#
# host hardware
$HostHardware = Get-AlarmDefinition "host hardware*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# host connection
$HostConnection = Get-AlarmDefinition "host con*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# host cpu
$HostCPU = Get-AlarmDefinition "host cpu*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# host memory
$HostMemory = Get-AlarmDefinition "host memory*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# vSphere HA
$vSphereHA = Get-AlarmDefinition "vSphere HA*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# vCenter
$vCenter = Get-AlarmDefinition "vCenter*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# expired licenses
$License = Get-AlarmDefinition "Expired*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# datastore space
$DatastoreUsage = Get-AlarmDefinition "datastore usage on disk" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
# datastore connection
$DatastoreConnection = Get-AlarmDefinition "cannot connect*" | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction
#>