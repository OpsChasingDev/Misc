Invoke-Command localhost {
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
} | Select-Object ComputerName,Member