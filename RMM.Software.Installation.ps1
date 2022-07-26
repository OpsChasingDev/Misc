param (
    [string]$Executable_File_Name,
    [string]$Install_Arguments_String
)

Start-Process "C:\Savant\$Executable_File_Name" -ArgumentList $Install_Arguments_String -Wait