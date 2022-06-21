$Collection = @()
$DomainUser = (Get-ADUser -Filter *).SamAccountName
foreach ($u in $DomainUser) {
    $login = net user $u | findstr "Last"
    $obj = [PSCustomObject]@{
        User = $u
        LastLogin = $login.TrimStart("Last login")
    }
    $Collection += $obj
}
Write-Output $Collection | Where-Object {$_.LastLogin -ne "Never"} | Sort-Object LastLogin | Export-Csv -Path 'C:\Scripts\LastLogin.csv' -Force -NoTypeInformation