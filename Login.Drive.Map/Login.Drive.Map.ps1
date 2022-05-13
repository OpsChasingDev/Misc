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

Write-Output $login | Out-File 'C:\root\loginame.txt' -Force

eventcreate /ID 13 /L APPLICATION /T WARNING /SO LOGINTEST /D "wrote successfully" > $null