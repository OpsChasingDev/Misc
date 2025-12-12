# List of services to disable
$servicesToDisable = @(
    "XboxGipSvc",
    "XblAuthManager",
    "XblGameSave",
    "XboxNetApiSvc",
    "GoogleUpdaterInternalService144.0.7547.0",
    "GoogleUpdaterService144.0.7547.0",
    "edgeupdate",
    "edgeupdatem"
    #"WSearch",
    #"wuaserv",
    #"WpnService",
    #"SDRSVC"
)

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