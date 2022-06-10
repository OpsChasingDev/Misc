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

function Get-Mandelbrot {
    param (
        [Parameter(Mandatory)]
        [double]$c,

        [double]$z = 0,
        
        [Parameter(Mandatory)]
        [int64]$Iteration
    )

    for ($i = 0; $i -lt $Iteration; $i++) {
        $z = (Get-Power -StartValue $z -PowerValue 2) + $c
        Write-Output $z
    }
}