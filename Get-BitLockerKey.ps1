# looks for a bitlocker recovery password on the C: drive of a computer with the intent of passing the output to Automate to fill in a custom field

$BitLocker = Get-BitLockerVolume -MountPoint C -ErrorAction SilentlyContinue | Where-Object {$_.VolumeStatus -eq 'FullyEncrypted'}

if ($BitLocker) {
    $Password = $BitLocker.KeyProtector
    foreach ($p in $Password) {
        if ($p.RecoveryPassword) {
            $Key = $p.RecoveryPassword
            Write-Output $Key
        }
    }
}
else {
    Write-Output 'C: drive not encrypted'
}