
If(!(Test-Path $profile))
                {
                New-Item -type file -force $profile
                Copy-Item AnthonyProfile.txt $profile -verbose
                }
Else
{
                $title = "Powershell Profile Already Exists"
                $message = "Do you want to edit(notepad), overwrite, or Quit?"

                $Edit = New-Object System.Management.Automation.Host.ChoiceDescription "&Edit", `
    "Edit the file in Notepad."

                $Overwrite = New-Object System.Management.Automation.Host.ChoiceDescription "&Overwrite", `
    "Overwrites the existing profile with AnthonyProfile(WARNING Deletes Current Profile)."
                
                $Quit = New-Object System.Management.Automation.Host.ChoiceDescription "&Quit", `
    "Retains all the files in the folder."

                $options = [System.Management.Automation.Host.ChoiceDescription[]]($Edit, $Overwrite, $Quit)

                $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

                switch ($result)
    {
        0 { Notepad $Profile} #Edit Option}
        1 { Copy-Item AnthonyProfile.txt $profile -verbose}
                                2 { Write-Host "Exiting..."}
    }
}
