$Share = @(
    '\\SL-DC-01\Tools'
    '\\SL-DC-01\TestShares'
)

$Letter = @(
    'T:'
    'S:'
)

$Login = cscript.exe \\SL-DC-01\NETLOGON\TestLogin.vbs
$Login = Write-Output $Login[3]

# check that number of shares and letters inputted are equal
if ($Share.Count -ne $Letter.Count) {
    Write-Output "The number of share and letters to map them are not equal."
    eventcreate /ID 13 /L APPLICATION /T WARNING /SO DriveMap /D "The number of share and letters to map them are not equal." > $null
    exit
}

# check that the shares have a valid UNC path
foreach ($h in $Share) {
    if ($h -notmatch '^\\\\.') {
        Write-Output "$h is not a valid UNC path"
        eventcreate /ID 13 /L APPLICATION /T WARNING /SO DriveMap /D "$h is not a valid UNC path" > $null
        exit
    }
}

# creating object for mapping info
$obj = New-Object -TypeName psobject
for ($i = 0; $i -lt $Share.Count; $i++) {
    $obj | Add-Member -MemberType AliasProperty -Name 'Letter' -Value $Letter[$i]
    $obj | Add-Member -MemberType AliasProperty -Name 'Share' -Value $Share[$i]
}
Write-Output $obj

eventcreate /ID 13 /L APPLICATION /T WARNING /SO DriveMap /D "wrote successfully" > $null