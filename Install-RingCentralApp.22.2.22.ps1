# configure firewall rules
$RCSplatInbound = @{
    Program = 'C:\program files\ringcentral\ringcentral.exe'
    Action = 'Allow'
    Profile = 'Domain, Private, Public'
    DisplayName = 'Allow RingCentral Inbound traffic'
    Description = 'Prevents Windows Firewall from interfering with RingCentral'
    Direction = 'Inbound'
}
New-NetFirewallRule @RCSplatInbound

$RCAppSplatInbound = @{
    Program = '%localappdata%\programs\ringcentral\ringcentral.exe'
    Action = 'Allow'
    Profile = 'Domain, Private, Public'
    DisplayName = 'Allow RingCentral App Inbound traffic'
    Description = 'Prevents Windows Firewall from interfering with RingCentral App'
    Direction = 'Inbound'
}
New-NetFirewallRule @RCAppSplatInbound

# install app
Start-Process 'C:\Savant\RingCentral-x64.msi' -ArgumentList '/q'