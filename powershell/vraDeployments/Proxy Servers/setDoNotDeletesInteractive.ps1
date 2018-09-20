# ---------------------------------
# PURPOSE: Run on vRA proxy server to not delete failed jobs.
# AUTHOR: ANTHONY BROWN
# LAST UPDATE: 13/04/2018
# COMMENTS:
#             This script will do a dir of the agents installed on the proxy server you run it on (default path only)
#             Then it will find the current doDelete flag for each one and ask if you want to change it (default no)
#             If you select to change it, it will do so
#             Finally it will print to screen a summary of all agents doDelete flags at the time of script ends
#             for validation purposes.
# 
# ---------------------------------


# get all agents installed on proxy
$agentArray = @(Get-ChildItem "${env:ProgramFiles(x86)}\VMware\vCAC\Agents" | select -expand name )
$changedAgents = @()
#set path locations for exe and config file



# function declaration for getDoDelete
# USAGE: getDoDeletes <agent name>
# RETURNS: "TRUE" or "FALSE"
function getDoDeletes{
    Param ([string] $agent)
    $vrmExe  =   "${env:ProgramFiles(x86)}\VMware\vCAC\Agents\$agent\DynamicOps.Vrm.VRMencrypt.exe"
    $vrmConfig = "${env:ProgramFiles(x86)}\VMware\vCAC\Agents\$agent\VRMAgent.exe.config"
    $getOutput = & "$vrmExe" @($vrmConfig,'get')
    $doDeletes = ($getOutput -split 'doDeletes: ')[2]
    return $doDeletes
}


# function declaration for setDoDelete 
# USAGE: setDoDeletes <agent name> <New doDelete setting ("TRUE":"FALSE")
function setDoDeletes{
    Param ([string] $agent, [string] $newSetting)
    $vrmExe  =   "${env:ProgramFiles(x86)}\VMware\vCAC\Agents\$agent\DynamicOps.Vrm.VRMencrypt.exe"
    $vrmConfig = "${env:ProgramFiles(x86)}\VMware\vCAC\Agents\$agent\VRMAgent.exe.config"
    if("TRUE","FALSE" -notcontains $newSetting.ToUpper()){
        throw "doDelete can only be set to TRUE or FALSE you are trying to change it to $newSetting"
    }
    & "$vrmExe" @($vrmConfig,'SET','doDeletes',$newSetting.ToUpper())
}

#function declaration restartServiceInteract
# USAGE: restartServiceInteract <service Name>
function restartServiceInteract{
    Param ([string] $service)
   
    $answer = ""
    while("y","n" -notcontains $answer){ 
        Write-Host -NoNewline -ForegroundColor Green  "Would you like to restart the service " 
        Write-Host -NoNewline -ForegroundColor Yellow "$service "                        
        Write-Host -NoNewline -ForegroundColor Green  "(y,n) [n] : " 
        $answer = Read-Host
        if($answer -eq ""){$answer = "n"}
    }

    if($answer -eq "y"){
        Restart-Service "$serviceName" 
    }

}

     
#main script 
#create some space between prompt and script outputs
Write-Host
Write-Host

foreach($agent in $agentArray){
         
    
    
    $doDeletes = getDoDeletes $agent
       
    $answer = ""

    while("y","n" -notcontains $answer){ 
       
        Write-Host -NoNewline -ForegroundColor Green  "Currently doDeletes for agent " 
        Write-Host -NoNewline -ForegroundColor Yellow "$agent "                        
        Write-Host -NoNewline -ForegroundColor Green  "is set to "                     
        Write-Host -NoNewline -ForegroundColor Yellow "$doDeletes "                    
        Write-Host -NoNewline -ForegroundColor Green  "would you like this changed (y,n) [n] : " 
        
        $answer = Read-Host
        if($answer -eq ""){$answer = "n"}
    }


    if($answer -eq "y"){
        #work out if you need to set to true or false
       
        $newDoDeleteArr = {@("TRUE","FALSE")}.Invoke()
        $newDoDeleteArr.Remove($doDeletes) | Out-Null    
        $newDoDelete = $newDoDeleteArr[0]
    
       Write-Host "Setting doDeletes to $newDoDelete for $agent" -ForegroundColor White
       setDoDeletes $agent $newDoDelete
       $changedAgents += $agent

     }
    
     
}

#create some space between main and summary table
Write-Host

#create summary table
foreach($agent in $agentArray){
    
    $doDeletes = getDoDeletes $agent
    
    Write-Host -ForegroundColor Green  -NoNewline "Agent " 
    Write-Host -ForegroundColor Yellow -NoNewline "$agent " 
    Write-Host -ForegroundColor Green  -NoNewline "doDeletes are set to " 
    Write-Host -ForegroundColor Yellow -NoNewline "$doDeletes" 
    Write-Host
    
}

#if any agents settings were changed offer to restart the service (default: n)
if($changedAgents){
    Write-Host
    Write-Host -ForegroundColor Green  "The settings for the following agents were changed: "
    Write-Host -ForegroundColor Yellow -NoNewline $($changedAgents -join ',')
    Write-Host
    
    foreach($changedAgent in $changedAgents){
        $serviceName = "VMware vCloud Automation Center Agent - $changedAgent"
        restartServiceInteract $serviceName
    }
}
        

#create some space between script and prompt outputs
Write-Host

