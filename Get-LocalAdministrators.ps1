$path = Read-Host "Enter a full CSV file path to store information"

$servers = (Get-ADComputer -Filter *).Name

$RemoteOutput = Invoke-Command -ComputerName $servers -ScriptBlock {
    $hostname = hostname
    (Get-LocalGroupMember -Group Administrators).Name |
        ForEach-Object { Write-Output "[$hostname] $_"}
} -ErrorAction SilentlyContinue

$RemoteOutput | Export-Csv -Path $path -NoTypeInformation