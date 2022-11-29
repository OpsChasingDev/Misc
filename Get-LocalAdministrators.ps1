$Path = Read-Host "Enter the full path to a CSV file where data will be stored"
$Computer = (Get-ADComputer -Filter *).Name

Invoke-Command -ComputerName $Computer -ScriptBlock {
    $objCol = @()
    $Member = Get-LocalGroupMember -Group Administrators
    foreach ($m in $Member) {
        $obj = [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            Member = $m.Name
        }
        $objCol += $obj
    }
    Write-Output $objCol
} -ErrorAction SilentlyContinue | Select-Object ComputerName, Member | Export-Csv -Path $Path -NoTypeInformation -Force