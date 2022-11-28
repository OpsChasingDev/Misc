$servers = (Get-ADComputer -Filter *).Name

Invoke-Command -ComputerName $servers -ScriptBlock {
    $hostname = hostname
    (Get-LocalGroupMember -Group Administrators).Name |
        ForEach-Object { Write-Output "[$hostname] $_"}
} -ErrorAction SilentlyContinue