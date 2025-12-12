# List of services to disable
$servicesToDisable = @(
    "XboxGipSvc",
    "XblAuthManager",
    "XblGameSave",
    "XboxNetApiSvc",
    "edgeupdate",
    "edgeupdatem"
    #"WSearch",
    #"wuaserv",
    #"WpnService",
    #"SDRSVC"
)
# Add Google Update services dynamically
$servicesToDisable += (Get-Service | Where-Object { $_.Name -like "*googleupdater*" }).Name

foreach ($svc in $servicesToDisable) {

    # Stop the service if running
    Try {
        Stop-Service -Name $svc -Force -ErrorAction Stop
    }
    Catch {}

    # Set service startup type to disabled
    Try {
        Set-Service -Name $svc -StartupType Disabled -Force
    }
    Catch {}

}