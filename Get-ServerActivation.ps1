# takes a list of computer names and shows if they have activated windows server licenses

param (
    [Parameter(Mandatory)]
    [string[]]$Computer
)

Invoke-Command -ComputerName $Computer {
    Get-CimInstance -ClassName SoftwareLicensingProduct |
        Where-Object {$_.Name -like '*window*' -and
        $_.LicenseFamily -like '*server*' -and
        $_.LicenseStatus -eq 1} |
        Select-Object Name,LicenseStatus,Id
} |
Select-Object PSComputerName,Name,LicenseStatus |
Sort-Object PSComputerName