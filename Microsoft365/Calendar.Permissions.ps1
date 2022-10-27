<#
function {
    param (
        [string]TargetUser
        [string]Permission
        [switch]AllExisting
        [string[]]OtherUser
        [switch]GrantTarget
        [switch]GrantOther
    )
}

- sets up connection to 365 exchange using live connection
- 
- features:
    - add the new user to all existing mailbox calendar permissions
    - give all existing mailboxes permissions to the new user calendar
    - add the new user to specified existing mailbox calendar permissions
    - give specified existing mailboxes permissions to the new user calendar
    - supports whatif/confirm
- error handling:
    - verifies connection is set up
        - break with error if not
    - verifies that specified user exists
        - break with error if not
    - verifies each change made
        - continues if not
        - reports if no change was made
- input
    - credentials to connect to 365 exchange
    - user whose permissions need to be given/taken
    - user(s) who will be granted access to the target user or who the target user will be granted access to
- output
    - confirmation information
#>