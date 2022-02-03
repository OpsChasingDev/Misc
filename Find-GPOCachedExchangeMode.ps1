# the below makes an XML report of all GPOs and then parses each report to see if any of those GPOs contain a setting whose name matches "*cached exchange mode*"

$guidall = (Get-GPO -All).Id.Guid
foreach ($g in $guidall) {
    [xml]$r = Get-GPOReport -Guid $g -ReportType Xml
    $name = $r.GPO.User.ExtensionData.Extension.Policy.Name
    if ($name -like "*cached exchange mode*") {
        Write-Output $r.GPO.Name
    }
}