### create Hyper-V External Switch - if not exists ###
$externalSwitch=(Get-VMSwitch | Where-Object SwitchType -eq External).Name
if ($null -eq $externalSwitch) 
{ $newSwitchName="ExternalSwitch"
  New-VMSwitch -name $newSwitchName -NetAdapterName Ethernet -AllowManagementOS $true
  $env:ExtSwitchName=$newSwitchName }
else 
{ $externalSwitch=(Get-VMSwitch | Where-Object SwitchType -eq External) | Select-Object -ExpandProperty Name
  $env:ExtSwitchName=$externalSwitch }

### set variables - VM spec ###
$env:linuxVMname="vgtubt00"
$env:windowsVMname="vgtwin00"
$env:cpuCount="2"
$env:memorySize="2048"

### set variables - VM count and box name ###
$env:linuxCount=0
$env:windowsCount=2
$env:linuxBox="generic/ubuntu1804"
$env:windowsBox="gusztavvargadr/windows-server"

### set variables - scripts paths ###
$env:linuxScript="./scripts/network.sh"
$env:windowsScript="./scripts/network.ps1"

### set variables for IPs ###
$env:linuxIPs="192.168.1.3"
$env:windowsIPs="192.168.1.4"

### run Vagrant ###
vagrant up
Write-Host "Waiting for VM configuration..."
Start-Sleep -s 90
Write-Host "Done!"

### create VMs snapshots ###
$vms=Get-VM | Where-Object {($_.Name -match $env:linuxVMname) -or ($_.Name -match $env:windowsVMname)} | Select-Object -ExpandProperty Name
foreach($vm in $vms)
{
    Write-Host "Creating snapshot for $vm..."
    Checkpoint-VM -Name $vm -SnapshotName FreshInstall
    Write-Host "Snapshot created!"
}



