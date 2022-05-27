# from Kirk Munro, PowerShell + DevOps Global Summit 2019
# https://youtu.be/tz0pcE1e2us?t=1715

# Test-1 returns the error information on the internals of the function's logic
# this is generally more useful if you are the author of the function and need to know what in the function's logic is broken
function Test-1 {
    [CmdletBinding()]
    param()
    1/0
}

# Test-2 returns the error information on the function itself
# this is generally more useful if you need to show that this function was the problem in your script containing other elements/logic

function Test-2 {
    [CmdletBinding()]
    param()
    $callerErrorActionPreference = $ErrorActionPreference
    try {
        1/0
    } catch {
        Write-Error $_ -ErrorAction $callerErrorActionPreference
    }
}