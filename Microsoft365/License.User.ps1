<#
- takes a user to copy licensing from and applies it to a desired, unlicensed user
- this effectively gives the unlicensed user the same license assignments as the specified example user
#>

# take user input
$TargetUser = Read-Host "Enter the user (ObjectID) who you want to apply licensing to."
$ExampleUser = Read-Host "Enter the example user (ObjectID) whose licensing mirrors what you want applied to the new user."

# make sure both specified accounts exist
try { $TargetUserStored = Get-AzureADUser -ObjectId $TargetUser }
catch {
    Write-Error "Could not find a user account with an ObjectID of $TargetUser.  The script has stopped."
    break
}

try { $ExampleUserStored = Get-AzureADUser -ObjectId $ExampleUser }
catch {
    Write-Error "Could not find a user account with an ObjectID of $ExampleUser.  The script has stopped."
    break
}