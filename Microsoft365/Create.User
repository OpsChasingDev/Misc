# prompt user input
$FirstName = Read-Host "Enter a first name"
$LastName = Read-Host "Enter a last name"
$UserPass = Read-Host "Enter an initial password" -AsSecureString

# connect to M365 account using Graph
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

# formulating values
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $Password

# user creation
$NewUserSplat = @{
    AccountEnabled
    DisplayName
    GivenName
    Surname
    UserPrincipalName
    PasswordProfile

}
New-AzureADUser @NewUserSplat