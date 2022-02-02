
param (
    [Parameter(Mandatory)]
    [int]$Balance,
    [Parameter(Mandatory)]
    [int]$Contribution,
    [Parameter(Mandatory)]
    [float]$Growth = 0.08,
    [Parameter(Mandatory)]
    [int]$Years = 1
)

for ($i = 1; $i -le $Years; $i++) {
    $Balance = $Balance + $Contribution + ($Balance * $Growth); Write-Output $Balance
}
