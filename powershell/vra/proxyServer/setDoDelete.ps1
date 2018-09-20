## gets the doDelete setting for a vra proxy server agent
## do delete is the setting you change to FALSE if you want it to not delete on failure.

# function declaration for setDoDelete 
# USAGE setDoDeletes <agent name> <New doDelete setting (TRUE FALSE)>
function setDoDeletes{
    Param ([string] $agent, [string] $newSetting)
    $vrmExe  =   ${envProgramFiles(x86)}VMwarevCACAgents$agentDynamicOps.Vrm.VRMencrypt.exe
    $vrmConfig = ${envProgramFiles(x86)}VMwarevCACAgents$agentVRMAgent.exe.config
    if(TRUE,FALSE -notcontains $newSetting.ToUpper()){
        throw doDelete can only be set to TRUE or FALSE you are trying to change it to $newSetting
    }
    & $vrmExe @($vrmConfig,'SET','doDeletes',$newSetting.ToUpper())
}

