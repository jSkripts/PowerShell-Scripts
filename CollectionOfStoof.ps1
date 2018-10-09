Get-Mailbox  -RecipientTypeDetails SharedMailbox -ResultSize Unlimited | Get-MailboxPermission | Select Identity,User,AccessRights | Export-Csv .\sharedmailboxpermission.csv –NoTypeInformation

Get-Mailbox | Select-Object -Property alias | Out-File Sharedmail.txt

Get-DistributionGroup -Identity "otstaff" | Set-DistributionGroup -RequireSenderAuthenticationEnabled $false

$file = ("$HOME\alias.txt")
$alias = (Get-Content $file)
ForEach ($box in $alias){
    Get-Mailbox -Identity $box | Format-List EmailAddresses
}

Get-Mailbox -OrganizationalUnit "OU=Service Mailboxes,OU=OT,DC=otcorp,dc=opentable,dc=com" | Where-Object {$_.RecipientTypeDetails -like "SharedMailbox"} | Get-ADPermission | Where-Object { ($_.ExtendedRights -like "*send-as*") -and ($_.User -like "given user")}

Get-ADUser -Filter * -SearchBase "OU=Disabled Users,OU=OT,DC=otcorp,dc=opentable,dc=com" -Properties EmployeeNumber | Where-Object {$_.Enabled -eq $false} | Select-Object SAMAccountName,EmployeeNumber | Export-Csv -Path $HOME\disabled.csv -NoTypeInformation

$file = ("$HOME\alias.txt")
$alias = (Get-Content $file)
#Set-UnifiedGroup -UnifiedGroupWelcomeMessageEnabled:$false -Identity kayaksync
ForEach ($box in $alias){
    Write-Output $box | Out-File -FilePath $HOME\shared.txt -Append
    Get-MailboxStatistics -Identity $box | Select-Object -Property  | Out-File -FilePath $HOME\shared.txt -Append
    Get-Mailbox -Identity $box | Out-File -FilePath $HOME\shared.txt -Append
}