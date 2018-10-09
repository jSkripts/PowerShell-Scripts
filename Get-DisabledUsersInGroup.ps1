Param (
    [string]$InputGroup = (Read-Host "Enter group to search"),
    [string]$Outputfile = ("$HOME\output.csv")  
 )
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

$Users=(Get-ADGroupMember  -Identity $InputGroup | Select-Object samaccountname) | Export-CSV $HOME\temp.csv -NoTypeInformation

$file = "$HOME\temp.csv"

ForEach ($user in $(Get-Content $file |foreach {$_ -replace "`"", ""})){
    Get-ADUser -Identity $user | Select-Object samaccountname,enabled | Export-CSV -Append -Force -Path $OutputFile -NoTypeInformation | Out-GridView
}