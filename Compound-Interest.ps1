# grabs a current balance, monthly contributions, average growth percentage, and number of years standing to show you what the new balance will be each year
param (
    [Parameter(Mandatory)]
    [int]$Balance,
    [Parameter(Mandatory)]
    [int]$MonthlyContribution,
    [Parameter(Mandatory)]
    [int]$GrowthPercent,
    [Parameter(Mandatory)]
    [int]$Year
)

$ObjectCollection = @()
$GrowthRaw = $GrowthPercent / 100
$Contribution = $MonthlyContribution * 12

for ($i = 1; $i -le $Year; $i++) {
    $Balance = $Balance + $Contribution + ($Balance * $GrowthRaw)
    $obj = New-Object -TypeName psobject
    $obj | Add-Member -MemberType NoteProperty -Name "Year" -Value $i
    $obj | Add-Member -MemberType NoteProperty -Name "New Balance" -Value $Balance.ToString('C')
    $ObjectCollection += $obj
}

Write-Output $ObjectCollection