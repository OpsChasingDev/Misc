function Flip-Coin {
    <#
    .SYNOPSIS
        A small function to randomly generate "Heads" or "Tails"
    .DESCRIPTION
        A small function to randomly generate "Heads" or "Tails"
    .EXAMPLE
        PS C:\git\Misc> Flip-Coin      
        
        Heads
    .EXAMPLE
        PS C:\git\Misc> Flip-Coin -HarveyDent $true
        
        Heads
        You make your own luck...
    #>
    [CmdletBinding()]
    param (
        [bool]$HarveyDent = $false
    )

    if ($HarveyDent -eq $false) {
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
    }
    else {
        Write-Output "Heads"
        Write-Host "You make your own luck..."
    }
}