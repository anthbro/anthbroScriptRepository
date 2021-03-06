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

     
#main script 
#create some space between prompt and script outputs
Write-Host
Write-Host

foreach($agent in $agentArray){
         
		$serviceName = "VMware vCloud Automation Center Agent - $agent"
        Restart-Service "$serviceName" 
    
}

Write-Host
Write-Host
