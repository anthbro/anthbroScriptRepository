Function Enable-SSH {
Param(
[Parameter(Mandatory=$True)]
  [String]$ESXiServer
                ) #end Param

$ESXHost = get-vmhost $ESXiServer
connect-viserver $ESXHost
Get-VMHost $ESXHost | Get-VMHostService | where {$_.Label -eq "SSH"} | start-vmhostservice -Confirm:$false
} #End Function Disable-SSH

Function Disable-SSH {
Param(
[Parameter(Mandatory=$True)]
  [String]$ESXiServer
                ) #end Param

$ESXHost = get-vmhost $ESXiServer
connect-viserver $ESXHost
Get-VMHost $ESXHost | Get-VMHostService | where {$_.Label -eq "SSH"} | stop-vmhostservice -Confirm:$false

} #End Function Disable-SSH

Function Disable-SSHAll {
Write-Host "WARNING: This will disable SSH on ALL connected hosts."
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$ESXHostList = get-vmhost 

                ForEach($ESXHost in $ESXHostList) {
                Get-VMHost $ESXHost | Get-VMHostService | where {$_.Label -eq "SSH"} | stop-vmhostservice -Confirm:$false
                } #End ForEach

} #End Function Disable-SSHAll

Function Enable-SSHAll {

Write-Host "WARNING: This will enable SSH on ALL connected hosts."
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$ESXHost = get-vmhost 

Get-VMHost $ESXHost | Get-VMHostService | where {$_.Label -eq "SSH"} | start-vmhostservice -Confirm:$false

} #End Function Enable -SSHAll

Function Set-SSHTimeOut {
param(
[Parameter(Mandatory=$True)]
  [int]$TimeoutInSeconds
) #End Param

Write-Host "This will set the SSH Timeout for sessions and for SSH to be enabled to be $TimeoutInSeconds seconds for all connected hosts"
Write-Host "This is done by setting the Advanced Setting for UserVars.ESXiShellTimeOut and UserVars.ESXiShellInteractiveTimeout"
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$ESXHost = get-vmhost $UserESX

                ForEach($ESXHost in $ESXHostList) {
                Get-VMHost $ESXHost | Get-AdvancedSetting -Name 'UserVars.ESXiShellInteractiveTimeout' | Set-AdvancedSetting -Value $TimeoutInSeconds -Confirm:$false
                Get-VMHost $ESXHost | Get-AdvancedSetting -Name 'UserVars.ESXiShellTimeout' | Set-AdvancedSetting -Value $TimeoutInSeconds -Confirm:$false
                } #End ForEach

} #End Function SSHTimeOut

Function Disable-SSHAlarm {

Write-Host "This will turn off the SSH Alarm for all connected hosts sessions and for SSH to be enabled to be $TimeoutInSeconds seconds for all connected hosts"
Write-Host "This is done by setting the Advanced Setting for UserVars.SupressShellWarning to 1"
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$ESXHost = get-vmhost 

                ForEach($ESXHost in $ESXHostList) {
                Get-VMHost $ESXHost | Get-AdvancedSetting -Name 'UserVars.SupressShellWarning' | Set-AdvancedSetting -Value 1 -Confirm:$false
                
                } #End ForEach

} #End Function SSHTimeOut

Function Enable-SSHAlarm {

Write-Host "This will turn on the SSH Alarm for all connected hosts sessions and for SSH to be enabled to be $TimeoutInSeconds seconds for all connected hosts"
Write-Host "This is done by setting the Advanced Setting for UserVars.SupressShellWarning to 0"
Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$ESXHost = get-vmhost 

                ForEach($ESXHost in $ESXHostList) {
                Get-VMHost $ESXHost | Get-AdvancedSetting -Name 'UserVars.SupressShellWarning' | Set-AdvancedSetting -Value 0 -Confirm:$false
                
                } #End ForEach

} #End Function SSHTimeOut