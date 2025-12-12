# List of services to disable
$servicesToDisable = @(
    "XboxGipSvc",
    "XblAuthManager",
    "XblGameSave",
    "XboxNetApiSvc",
    "GoogleUpdaterInternalService144.0.7547.0",
    "GoogleUpdaterService144.0.7547.0",
    "edgeupdate",
    "edgeupdatem",
    "WSearch",
    "wuaserv",
    "WpnService",
    "SDRSVC"
)

if ($servicesToDisable.Count -eq 0) {
    Write-Host "No services specified. Add service names to the script before running."
    exit
}

foreach ($svc in $servicesToDisable) {
    Write-Host "Processing service: $svc..."

    # Stop the service if running
    Try {
        Stop-Service -Name $svc -Force -ErrorAction Stop
        Write-Host "  → Service stopped."
    }
    Catch {
        Write-Host "  → Could not stop service or it may already be stopped."
    }

    # Set service startup type to disabled
    Try {
        Set-Service -Name $svc -StartupType Disabled
        Write-Host "  → Startup type set to Disabled."
    }
    Catch {
        Write-Host "  → Failed to set startup type."
    }

    Write-Host ""
}

Write-Host "Completed service disabling operation."