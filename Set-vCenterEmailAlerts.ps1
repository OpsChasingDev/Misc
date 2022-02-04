# this script assumes you've already connected to your vCenter instance using Connect-VIServer

<#
    CAUTION, PROCESSING PARAMETERS SUCH AS -CONFIM AND -WHATIF ARE NOT YET WRITTEN INTO THIS SCRIPT
    THERE IS NO SAFETY NET TO PREVENT YOU FROM PERFORMING THE ACTIONS IN THIS SCRIPT IF RAN
#>

param (
    [Parameter(Mandatory)]
    [String]$email
)

# the lines below each grab vCenter alarm definitions by using various string matches and stores them as variables
# the variables are piped to the New-AlarmAction cmdlet to set the email action to each definition, categorizing them by subject

# host hardware
$HostHardware = Get-AlarmDefinition "host hardware*"
$HostHardware | New-AlarmAction -Email -To $email -Subject "Host Hardware Problem"

# host connection
$HostConnection = Get-AlarmDefinition "host con*"
$HostConnection | New-AlarmAction -Email -To $email -Subject "Host Connection Problem"

# host cpu
$HostCPU = Get-AlarmDefinition "host cpu*"
$HostCPU | New-AlarmAction -Email -To $email -Subject "Host CPU Problem"

# host memory
$HostMemory = Get-AlarmDefinition "host memory*"
$HostMemory | New-AlarmAction -Email -To $email -Subject "Host Memory Problem"

# vSphere HA
$vSphereHA = Get-AlarmDefinition "vSphere HA*"
$vSphereHA | New-AlarmAction -Email -To $email -Subject "vSphere HA Problem"

# vCenter
$vCenter = Get-AlarmDefinition "vCenter*"
$vCenter | New-AlarmAction -Email -To $email -Subject "vCenter Problem"

# expired licenses
$License = Get-AlarmDefinition "Expired*"
$License | New-AlarmAction -Email -To $email -Subject "License Problem"

# datastore space
$DatastoreUsage = Get-AlarmDefinition "datastore usage on disk"
$DatastoreUsage | New-AlarmAction -Email -To $email -Subject "Datastore Usage Problem"

# datastore connection
$DatastoreConnection = Get-AlarmDefinition "cannot connect*"
$DatastoreConnection | New-AlarmAction -Email -To $email -Subject "Datastore Connection Problem"