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
