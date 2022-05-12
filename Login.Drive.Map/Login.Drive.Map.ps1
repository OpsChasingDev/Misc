<#
Add array here that can be manually modified to add share paths
Each path provided will be run through upon user login
#>

$share = @(
    # add a share name like '\\SERVER\Share'
    '\\SL-DC-01\Tools'
)

$letter = @(
    # add a drive letter like 'F:'
    'T:'
)

$login = cscript.exe \\SL-DC-01\NETLOGON\TestLogin.vbs
$login = Write-Output $login[3]

# determine input for shares list and drive letter mappings

New-SmbShare