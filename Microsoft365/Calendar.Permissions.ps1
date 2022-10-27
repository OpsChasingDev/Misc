<#
function {
    param (
        [string]NewUser
        [switch]AllExisting
        [switch]TakePerm
        [switch]GivePerm
    )
}

has options:
    - add the new user to all existing mailbox calendar permissions
    - give all existing mailboxes permissions to the new user calendar
    - add the new user to specified existing mailbox calendar permissions
    - give specified existing mailboxes permissions to the new user calendar
#>