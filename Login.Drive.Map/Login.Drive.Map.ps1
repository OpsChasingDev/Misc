$Share = @(
    '\\SL-DC-01\Tools'
    '\\SL-DC-01\TestShares'
)

$Letter = @(
    'T:'
    'S:'
)

#$Login = cscript.exe \\SL-DC-01\NETLOGON\TestLogin.vbs
#$Login = Write-Output $Login[3]

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
$Collection = @()
for ($i = 0; $i -lt $Share.Count; $i++) {
    $obj = New-Object -TypeName psobject
    $obj | Add-Member -MemberType NoteProperty -Name 'Letter' -Value $Letter[$i]
    $obj | Add-Member -MemberType NoteProperty -Name 'Share' -Value $Share[$i]
    $Collection += $obj
}

# getting current logged in user credentials
$cred = [System.Net.CredentialCache]::DefaultNetworkCredentials
  $user = $cred.UserName
  $pass = $cred.SecurePassword
  $domain = $cred.Domain
$domUser = $domain + '\' + $user
$PSCred = New-Object System.Management.Automation.PSCredential($domUser, $pass)


for ($f = 0; $f -lt $Collection.Count; $f++) {
    Remove-SmbMapping -LocalPath $Collection[$f].Letter -Force -ErrorAction SilentlyContinue
    New-SmbMapping -LocalPath $Collection[$f].Letter -RemotePath $Collection[$f].Share
    # net use $Collection[$f].Letter /del > $null
    # net use $Collection[$f].Letter $Collection[$f].Share > $null
}

Start-Sleep -Seconds 5
Get-Process explorer | Stop-Process -Force

eventcreate /ID 13 /L APPLICATION /T WARNING /SO DriveMap /D "wrote successfully" > $null

<#
# the below grabs the current logged in username and password and stores them as a PSCredential object
# if we use the below, the current credentials for the logged in user can be obtained, and then those stored credentials can be passed to the drive mapping cmdlet

$cred = [System.Net.CredentialCache]::DefaultNetworkCredentials
$user = $cred.UserName
$pass = $cred.SecurePassword
$dom = $cred.Domain
$domuser = $dom + "\" + $user
$pscred = New-Object System.Management.Automation.PSCredential($domuser, $pass)
#>