
param (
    [Parameter(Mandatory)]
    [int]$Balance,
    [Parameter(Mandatory)]
    [int]$Contribution,
    [Parameter(Mandatory)]
    [float]$Growth,
    [Parameter(Mandatory)]
    [int]$Year
)

$ObjectCollection = @()

for ($i = 1; $i -le $Year; $i++) {
    $Balance = $Balance + $Contribution + ($Balance * $Growth)
    $obj = New-Object -TypeName psobject
    $obj | Add-Member -MemberType NoteProperty -Name "Year" -Value $i
    $obj | Add-Member -MemberType NoteProperty -Name "Balance" -Value $Balance.ToString('C')
    $ObjectCollection += $obj
}

Write-Output $ObjectCollection