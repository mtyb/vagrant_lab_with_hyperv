
param (
    [parameter (Mandatory=$true)]
    [string]$NewIPAddress
)

### create script variables ###
$netConfig=Get-NetIPConfiguration
$netIP=$NewIPAddress
$nicIndex=$netConfig.InterfaceIndex
$nicGateway=$netConfig.IPv4DefaultGateway.NextHop
$nicDNS=$netConfig.DNSServer.ServerAddresses

### create netconfig script ###
Add-Content "C:\net_config.ps1" "New-NetIPAddress -InterfaceIndex $nicIndex -PrefixLength 24 -DefaultGateway $nicGateway -IPAddress $netIP; Set-DnsClientServerAddress -InterfaceIndex $nicIndex -ServerAddresses $nicDNS"

### create Scheduled Task ###
$currentTime=(Get-Date -DisplayHint time)
$triggerTime=$currentTime.AddSeconds(90)
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "C:\net_config.ps1"
$trigger = New-ScheduledTaskTrigger -Once -At $triggerTime
Register-ScheduledTask "NetConfig" -Action $action -Trigger $trigger -User "NT AUTHORITY\SYSTEM"

