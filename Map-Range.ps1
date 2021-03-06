<# PowerShell version of the algorithm for mapping one range of numbers to another range of numbers

Example below to show what the output looks like for mapping a range of 0-100 to a range of 0-1

PS C:\git\Misc> scale -Number 5 -inMin 0 -inMax 100 -outMin 0 -outMax 1
0.05
PS C:\git\Misc> scale -Number 0 -inMin 0 -inMax 100 -outMin 0 -outMax 1
0
PS C:\git\Misc> scale -Number 50 -inMin 0 -inMax 100 -outMin 0 -outMax 1
0.5
PS C:\git\Misc> scale -Number 90 -inMin 0 -inMax 100 -outMin 0 -outMax 1
0.9
PS C:\git\Misc>

#>

function Map-Range {
    param (
        [Parameter(Mandatory)]
        [int]$Number,
        [Parameter(Mandatory)]
        [int]$inMin,
        [Parameter(Mandatory)]
        [int]$inMax,
        [Parameter(Mandatory)]
        [int]$outMin,
        [Parameter(Mandatory)]
        [int]$outMax
    )

    $calc = ($Number - $inMin) * ($outMax - $outMin) / ($inMax - $inMin) + $outMin
    $outputDiff = $outMax - $outMin
    $inputDiff = $inMax - $inMin
    
    Write-Verbose "Ratio between intput and output range differences is ${outputDiff}:$inputDiff"
    Write-Output $calc
}