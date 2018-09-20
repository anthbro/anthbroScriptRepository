<#

.SYNOPSIS
  gets the doDelete setting for a vra proxy server agent
.DESCRIPTION
  gets the doDelete setting for a vra proxy server agent
.PARAMETER $agent
  The agent you want to get the value of 
.INPUTS
  None
.OUTPUTS
  ("TRUE" or "FALSE") - i.e. setting of the doDeletes attribute for the agent
.NOTES
  Version:        1.0
  Author:         @anthbro
  Creation Date:  14/09/2018
  
.EXAMPLE
    getDoDeletes <agent name>
#>


function getDoDeletes{
#---declare Params---
    Param ([string] $agent)
    $vrmExe  =   "${env:ProgramFiles(x86)}\VMware\vCAC\Agents\$agent\DynamicOps.Vrm.VRMencrypt.exe"
    $vrmConfig = "${env:ProgramFiles(x86)}\VMware\vCAC\Agents\$agent\VRMAgent.exe.config"
    $getOutput = & "$vrmExe" @($vrmConfig,'get')
    $doDeletes = ($getOutput -split 'doDeletes: ')[2]
    return $doDeletes
}




