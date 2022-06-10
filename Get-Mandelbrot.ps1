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

function Get-Mandelbrot {
    param (
        [double]$c,
        [double]$z = 0,
        [int64]$iteration
    )

    for ($i = 0; $i -lt $iteration; $i++) {
        $z = ($z * $z) + $c
        Write-Output $z
    }
}