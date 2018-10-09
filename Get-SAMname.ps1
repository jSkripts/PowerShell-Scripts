Import-Module ActiveDirectory

$aResults = @()
$List = Get-Content ".\users.txt"
            
ForEach($Item in $List){
    $Item = $Item.Trim()
    $User = Get-ADUser -Filter{displayName -like $Item -and SamAccountName -notlike "admin-*" -and Enabled -eq $True} -Properties SamAccountName, GivenName, Surname, telephoneNumber, mail

    $hItemDetails = New-Object -TypeName psobject -Property @{    
        UserName = $User.SamAccountName
       }

    #Add data to array
    $aResults += $hItemDetails
}

$aResults | Export-CSV ".\Results.csv"