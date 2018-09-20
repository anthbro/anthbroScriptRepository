
# This was copied from here https://communities.vmware.com/thread/509598
# It will take all tags from all connected vi servers and output it to the csv in the exportLocation
# Recommend you only connect to the viserver you are trying to export from and disconnect all others.
# Once you export disconnect from the viserver then connect to the server you want to import to then run the import.


$exportLocation = ".\tag.csv"



&{foreach($tCat in Get-TagCategory){

    $tags = Get-Tag -Category $tCat

    if($tags){

        $tags | Select @{N='Category';E={$tCat.Name}},@{N='cDescription';E={$tCat.Description}},@{N='Cardinality';E={$tCat.Cardinality}},Name,Description

    }

    else{

        $tCat | Select @{N='Category';E={$tCat.Name}},@{N='cDescription';E={$tCat.Description}},@{N='Cardinality';E={$tCat.Cardinality}},@{N='Name';E={''}},@{N='Description';E={''}}

    }

}} | Export-Csv $exportLocation -NoTypeInformation -UseCulture
