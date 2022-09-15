# takes a login identity as input and searches non-system and non-admin shares for any NTFS permissions with that identity listed
$Identity = Read-Host "Enter a login identity ('domain\username' or 'group name') to search for"

$ExcludeShare = @(
    'NETLOGON'
    'SYSVOL'
)
$Share = Get-SmbShare | Where-Object {$_.Name -notmatch '.\$$' -and $ExcludeShare -notcontains $_.Name}

foreach ($s in $Share) {
    $ACL = (Get-Acl -Path $s.Path).Access
    if ($ACL.IdentityReference -eq $Identity) {
        Write-Output $ACL
    }
}