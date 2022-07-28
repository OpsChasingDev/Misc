# wrapper to pass global variables in RMM script as arguments to this locally run PS script
param (
    [string]$Executable_File_Name,
    [string]$Install_Arguments_String
)

try {
    Start-Process -FilePath "C:\Savant\$Executable_File_Name" -ArgumentList "$Install_Arguments_String" -Wait
    Write-Output "SUCCESS"
}
catch {
    Write-Output "FAILED"
    $Error[0].ToString() | Out-File -FilePath "C:\Savant\Error.txt" -Force
}