$VDI = (Get-AdComputer -Filter * | Where-Object {$_.Name -like '*VDI*'}).Name

Invoke-Command $VDI { Get-StartApps | Where-Object name -like '*nextiva*' | Select-Object PSComputerName,Name } -ErrorAction SilentlyContinue | Sort-Object PSComputerName
