param (
    [Parameter(Mandatory)]
    [string]$ShortcutName,

    [Parameter(Mandatory)]
    [string]$TargetPath
)

$obj = New-Object -ComObject WScript.Shell
$link = $obj.CreateShortcut("C:\Windows\Temp\$ShortcutName.lnk")
$link.TargetPath = $TargetPath
$link.Save()

Move-Item -LiteralPath "C:\Windows\Temp\$ShortcutName.lnk" -Destination "C:\Users\Public\Desktop\$ShortcutName.lnk" -Force