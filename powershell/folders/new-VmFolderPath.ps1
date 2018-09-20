<#

.SYNOPSIS
  Creates a complete vsphere vm folder path
.DESCRIPTION
  Takes a folder path, and iterates through the folder path checking if the folder exists, 
  each folder that doesn't exist is created.
.PARAMETER $vmFolderPath
    The vm folder path you want to create 
.INPUTS
  None
.OUTPUTS
  Name
.NOTES
  Version:        1.0
  Author:         @anthbro
  Creation Date:  14/09/2018
  
.EXAMPLE
    $VcFolderPath  = "DCAS-DT02\HDC VxBlock\DC-SOE-Templating\Windows\$soeVersion"
    create-VmFolderPath $VcFolderPath
#>

#code:

function create-VmFolderPath([string]$folderpath){

    try{
        #from folder path get virtual data center
        $pathArray		= $vcFolderPath.split("\")
        #get datacenter vm folder object and set it as initial testPath value
        $testPath                             = (get-datacenter $pathArray[0]).getvmfolder() 
    }catch{ 
        throw "Datacenter in vc folder path is missing or does not exist or was not found."
    }#end try,catch,finally
    
    #set folders by removing the vDC from the pathArray
    $folders                                               = $pathArray[1..($pathArray.length-1)]
    #check if first folder exists, create it if it doesn't, move to next folder and continue
    
    forEach($vmfolder in $folders){
    
	    try{ 
	        #check if current folder exists
	        $testPath | get-folder $vmfolder -ErrorAction Stop  
	    }catch{ 
	        #if not create it
	        $testPath | new-folder $vmfolder
	    }finally{
	        #iterate pathtest depth
	        $testPath = $testPath | get-folder $vmfolder
	    }#end try,catch,finally
	
	}#end foreach

}#end function
