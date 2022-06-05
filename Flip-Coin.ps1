<#
- based off current system uptime in ticks
- raw tick is gathered and manipulated to remove trailing zeros
- new result is turned into a string
- using the length of the string, separate each character
- turn each character back into an integer
- add the integers together
- if the sum is even, return heads; if the sum is odd, return tails
- *** add in a 'Harvey Dent' parameter to "make your own luck" xD
#>

    [int]$Sum = 0
    $tick = ((Get-Uptime).Ticks / 10000000)
    $t = $tick.ToString()
    $Length = $t.Length
    for ($l = 0; $l -lt $Length; $l++) {
        [int]$Index = $t.Substring($l,1)
        $Sum += $Index
    }
    if ($Sum/2 -is [System.Double]){
        Write-Output "Tails"
    }
    elseif ($Sum/2 -is [System.Int32]) {
        Write-Output "Heads"
    }