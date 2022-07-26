# wrapper to pass global variables in RMM script as arguments to this locally run PS script
param (
    [string]$Executable_File_Name,
    [string]$Install_Arguments_String
)

Start-Process "C:\Savant\$Executable_File_Name" -ArgumentList $Install_Arguments_String -Wait

Write-Output "Installed $Executable_File_Name on $ENV:COMPUTERNAME."