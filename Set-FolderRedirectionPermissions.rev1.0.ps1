<#
.Synopsis
   The cmdlet 'Set-FolderRedirectionPermissions' is specifically designed to fix NTFS permissions on a folder redirections repository
   and include some additional options for administrators.
.DESCRIPTION
   The intended use of this function is to re-apply all users' permissions to their respective redirection folders.  Permissions specified will only be granted if the name of
   the item within the parent directory matches the simple login name of a user in Active Directory (e.g. "TSawyer" or "Huck.Fin"; therefore, any folders with a name that do not match the login name of an AD user
   or miscellaneous items within the parent directory will have no action taken on them.

   A confirmation message will be presented before any action is taken to verify the operator knows what is about to happen.

   *** USE CAUTION AND TEST FIRST ***
   This function is extremely powerful and can easily affect end users' ability to work immediately.
   Do NOT run this operation unless you are fully aware of what you are about to do and how the function works.

   Other options this function provides allow the operator to supply an account that will have permissions set to all of the affected folders and child items regardless of whether or
   not that specified account's login name matches any of the folder names.  Such an operation could also be used to remove a user or group of users from having access to all the
   redirected items.  Take special care when using 'N' as your specified permission; this sets a 'Deny' for the accounts affected and will overwrite any granted access being given to
   the same user or group of users.  Setting all users for full access on their folders and then denying a group that contains those users will prevent them from being able to access
   their redirections.

   You can create a log file of all the items found in the parent directory that do not match an AD user login name using the 'Log' parameter.
.EXAMPLE
   Set-FolderRedirectionPermissions -ParentDirectory D:\TestRedirections -Permission F
   Looks at all items under D:\TestRedirections and applies CACLS permission 'F' (full access) to all items and their child items when a matching AD user login name exists.

   Each child item in the parent directory that matches a user account's login name will only give the full access permission to that matching user account.  No other user accounts
   will have their permissions modified to any other items or child items.

   For instance, if a child item of the parent directory D:\TestRedirections is named 'User01', and an AD account whose login name is 'User01' exists, then the user account 'User01'
   will be granted the 'F' permissions to that folder and all child items within that folder, but 'User01' will not have any permissions modified to the other folders located in the parent direcotry.
.EXAMPLE
   Set-FolderRedirectionPermissions -ParentDirectory D:\TestRedirections -Permission R -IncludeAdmin Administrator -AdminPermission F
   This example removes users from being able to modify their redirected folders but grants the provided 'Administrator' account full access permissions to all the items.
   Such an example could be used against an old redirection repository when migrating redirections to a new location, preventing users from somehow accidentally modifying the old data.
.EXAMPLE
    Set-FolderRedirectionPermissions -ParentDirectory D:\TestRedirections -Permission F -IncludeAdmin Administrator -AdminPermission F -Log C:\Test\redirectionlog.txt
    Gives users full access to their redirections and also grants the Administrator account full access to all redirections.  The 'Log' parameter is also specified to spit out
    any items in the parent directory that did not match an existing user account login name for auditing purposes.
.EXAMPLE
    Set-FolderRedirectionPermissions -ParentDirectory D:\TestRedirections -Permission F -IncludeAdmin TempAdmin -AdminPermission N
    Gives users full access to their redirections and also sets an explicit deny to all redirections for the 'TempAdmin' account belonging to a previously used consulting group.
.NOTES
   Current revision: 1.0
   Author: Robert Stapleton
   Date Published: 8/15/2021
   See updated versions of this script and more at: https://github.com/drummermanrob20/PowerShell-Scripts
#>

function Set-FolderRedirectionPermissions {

    [CmdletBinding ()]
    Param (
        <#The directory where folder redirections are pointed to containing folders for each user.#>
        [Parameter(Mandatory=$true)]
        [String]$ParentDirectory,
        <#
        This will be the permission given to each user on their respective redirections folder.
        Uses CACLS; must specify one of the below options:
        'F' - Full (full access)
        'C' - Change (write and modify)
        'W' - Write
        'R' - Read (read only)
        'N' - None (deny)
        #>
        [Parameter(Mandatory=$true)]
        [ValidateSet("F", "C", "W", "R", "N")]
        [String]$Permission,
        <#
        Specify a user account using the SamAccountName (pre-Windows 2000 name)
        Use this along with the -AdminPermission parameter to specify which permissions this account should be granted for all the folders and files within the -ParentDirectory.
        #>
        [String]$IncludeAdmin,
        <#
        This will be the permission given to the account specified with the -IncludeAdmin parameter for all of the folders and files within the -ParentDirectory.
        Uses CACLS; must specify one of the below options:
        'F' - Full (full access)
        'C' - Change (write and modify)
        'W' - Write
        'R' - Read (read only)
        'N' - None (deny)
        #>
        [ValidateSet("F", "C", "W", "R", "N")]
        [String]$AdminPermission,
        <#The file path where you want a log file.  The only data appended to this file are items found in the parent directory that do not match the name of an existing AD user account.#>
        [String]$Log
    )
    
    $Verify = Read-Host `n "You are about to change permissions on all folders" `
    "within" $ParentDirectory "such that" `n "the user account matching each folder name" `
    "will be granted the permission of" $Permission.ToUpper() "to all child items in that folder." `n `n `
    "Are you sure you want to continue? [Absolutely, Never]"

    if ($Verify -eq "Absolutely") {
        foreach ($d in (Get-ChildItem $ParentDirectory)) {
            if ((Get-ADUser -Filter * | select -ExpandProperty SamAccountName) -match $d) {

                $SamAccountName = (Get-ADUser -Filter * | select -ExpandProperty SamAccountName) -match $d
                CACLS "$ParentDirectory\$d" /E /P ${SamAccountName}:${Permission} > $null
                
                if ($IncludeAdmin) {CACLS "$ParentDirectory\$d" /E /P ${IncludeAdmin}:${AdminPermission} > $null}

                foreach ($file in $(Get-ChildItem "$ParentDirectory\$d" -Recurse)) {
                    Write-Host -ForegroundColor Yellow $file.FullName
                    CACLS $file.FullName /E /P ${SamAccountName}:${Permission} > $null
                    if ($IncludeAdmin) {CACLS $file.FullName /E /P ${IncludeAdmin}:${AdminPermission} > $null}
                    Write-Host -ForegroundColor Green "New Permissions"
                    CACLS $file.FullName
                }
            }
            else {
                Write-Host "User account $d does not exist."
                if ($Log) {Write-Output "$d account does not exist." | Out-File -FilePath "$Log" -Append}
            }
        }
    }
    else {Write-Host `n "Safe bet, my friend.  Read the help file." `n `n "Get-Help Set-FolderRedirectionPermissions"}
}