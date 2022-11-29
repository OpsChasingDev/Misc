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
} -ErrorAction SilentlyContinue | Select-Object ComputerName, Member