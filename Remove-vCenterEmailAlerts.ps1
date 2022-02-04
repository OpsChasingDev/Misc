# this script assumes you've already connected to your vCenter instance using Connect-VIServer

<#
    CAUTION, PROCESSING PARAMETERS SUCH AS -CONFIM AND -WHATIF ARE NOT YET WRITTEN INTO THIS SCRIPT
    THERE IS NO SAFETY NET TO PREVENT YOU FROM PERFORMING THE ACTIONS IN THIS SCRIPT IF RAN
#>

# host hardware
$HostHardware = Get-AlarmDefinition "host hardware*"
$HostHardware | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# host connection
$HostConnection = Get-AlarmDefinition "host con*"
$HostConnection | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# host cpu
$HostCPU = Get-AlarmDefinition "host cpu*"
$HostCPU | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# host memory
$HostMemory = Get-AlarmDefinition "host memory*"
$HostMemory | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# vSphere HA
$vSphereHA = Get-AlarmDefinition "vSphere HA*"
$vSphereHA | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# vCenter
$vCenter = Get-AlarmDefinition "vCenter*"
$vCenter | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# expired licenses
$License = Get-AlarmDefinition "Expired*"
$License | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# datastore space
$DatastoreUsage = Get-AlarmDefinition "datastore usage on disk"
$DatastoreUsage | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction

# datastore connection
$DatastoreConnection = Get-AlarmDefinition "cannot connect*"
$DatastoreConnection | Get-AlarmAction -ActionType SendEmail | Remove-AlarmAction