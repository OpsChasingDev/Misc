function Get-Power {
    param (
        [double]$StartValue,
        [int]$PowerValue
    )
    $IterativeValue = $StartValue
    for ($i = 1; $i -lt $PowerValue; $i++) {
        $StartValue = $StartValue * $IterativeValue
    }
    Write-Output $StartValue
}