$share = @(
    '\\SL-DC-01\Tools'
    '\\SL-DC-01\TestShares'
)

$letter = @(
    'T:'
    'S:'
)

$login = cscript.exe \\SL-DC-01\NETLOGON\TestLogin.vbs
$login = Write-Output $login[3]

# check that number of shares and letters inputted are equal
if ($share.count -ne $letter.count) {
    Write-Output "The number of share and letters to map them are not equal."
    eventcreate /ID 13 /L APPLICATION /T WARNING /SO DriveMap /D "The number of share and letters to map them are not equal." > $null
    exit
}

# check that the shares have a valid UNC path
foreach ($s in $share) {
    if ($s -notmatch '^\\\\.') {
        Write-Output "$s is not a valid UNC path"
        eventcreate /ID 13 /L APPLICATION /T WARNING /SO DriveMap /D "$s is not a valid UNC path" > $null
        exit
    }
}

# creating objects for mapping info
$obj = New-Object -TypeName psobject


# mapping drives

foreach ($s in $share) {
    New-SmbMapping -LocalPath 

eventcreate /ID 13 /L APPLICATION /T WARNING /SO LOGINTEST /D "wrote successfully" > $null