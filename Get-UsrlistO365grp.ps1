#$Users = (Get-Recipient -RecipientPreviewFilter {RecipientTypeDetails -eq "UserMailbox" -and CustomAttribute3 -ne "N"} -ResultSize Unlimited

$file = ("$HOME\groups.txt")
$groups = (Get-Content $file)
#Set-UnifiedGroup -UnifiedGroupWelcomeMessageEnabled:$false -Identity kayaksync
ForEach ($group in $groups){
    Write-Output $group | Out-File -FilePath $HOME\Output.txt -Append
    Get-UnifiedGroupLinks -Identity $group -LinkType Members | Format-Table | Out-File -FilePath $HOME\Output.txt -Append
}