$importLocation = ".\tag.csv"

foreach($tag in Import-Csv $importLocation -UseCulture){
    Try{
        Get-TagCategory -Name $tag.Category -ErrorAction Stop
    }
    Catch{
        New-TagCategory -Name $tag.Category -Description $tag.cDescription -Cardinality $tag.Cardinality -Confirm:$false
    }
    if($tag.Name){
        Try{
            Get-Tag -Category $tag.Category -Name $tag.Name -ErrorAction Stop
        }
        Catch{
            New-Tag -Name $tag.Name -Category $tag.Category -Description $tag.Description -Confirm:$false
        }
    }
}
