function Get-Power {
    param (
        [Parameter(Mandatory)]
        [double]$StartValue,

        [Parameter(Mandatory)]
        [int]$PowerValue
    )
    $IterativeValue = $StartValue
    for ($i = 1; $i -lt $PowerValue; $i++) {
        $StartValue = $StartValue * $IterativeValue
    }
    Write-Output $StartValue
}