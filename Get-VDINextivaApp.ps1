$VDI = (Get-AdComputer -Filter * | Where-Object {$_.Name -like '*VDI*'}).Name

Invoke-Command $VDI {
    Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{24D4336D-415E-4175-933F-BB9F3986484D}' -Name DisplayVersion |
    Select-Object PSComputerName, DisplayVersion
} -ErrorAction SilentlyContinue | Sort-Object PSComputerName
