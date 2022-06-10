function Get-Mandelbrot {
    param (
        [double]$c,
        [double]$z,
        [int64]$iteration
    )

    for ($i = 0; $i -lt $iteration; $i++) {
        $z = ($z * $z) + $c
        Write-Output $z
    }
}