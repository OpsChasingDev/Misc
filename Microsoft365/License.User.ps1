<#
- takes a user to copy licensing from and applies it to a desired, unlicensed user
- this effectively gives the unlicensed user the same license assignments as the specified example user
#>

$TargetUser = Read-Host "Enter the user who you want to apply licensing to (DisplayName or ObjectId)"
$ExampleUser = Read-Host "Enter the example user whose licensing mirrors what you want applied to the new user (DisplayName or ObjectId)"

Get-AzureADUser | Where-Object { $_.DisplayName -eq $TargetUser -or $_.ObjectId -eq $TargetUser } -ErrorAction Stop