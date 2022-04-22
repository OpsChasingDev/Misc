Write-Output "Starting the test operation"
$t = 4
$i = 0

$i++
$p = (($i/$t)*100)
Write-Progress -Activity "Installing first software..." -Status "$p% Complete" -PercentComplete $p
Start-Sleep -Seconds 5

$i++
$p = (($i/$t)*100)
Write-Progress -Activity "Installing second software..." -Status "$p% Complete" -PercentComplete $p
Start-Sleep -Seconds 5

$i++
$p = (($i/$t)*100)
Write-Progress -Activity "Installing third software..." -Status "$p% Complete" -PercentComplete $p
Start-Sleep -Seconds 5

$i++
$p = (($i/$t)*100)
Write-Progress -Activity "Istalling fourth software..." -Status "$p% Complete" -PercentComplete $p
Start-Sleep -Seconds 5