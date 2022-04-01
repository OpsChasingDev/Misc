$StartIP = Read-Host "Enter start IP (e.g. 45)"
$EndIP = Read-Host "Enter end IP (e.g. 55)"

$Array = @($StartIP..$EndIP)
$Collection = @()
$Subnet = '192.168.1.'

foreach ($a in $Array) {
    $IP = $Subnet + $a
    # Write-Output $IP
    $TCPTest = Test-NetConnection -ComputerName $IP -Port 443
    if ($TCPTest.TcpTestSucceeded -eq $true) {
        $Collection += $IP
    }
}

Write-Output $Collection