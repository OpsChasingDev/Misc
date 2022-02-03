Get-CimInstance -ClassName SoftwareLicensingProduct |
    Where-Object {$_.Name -like '*window*' -and
    $_.LicenseFamily -like '*server*' -and
    $_.LicenseStatus -eq 1} |
    Select-Object Name,LicenseStatus,Id