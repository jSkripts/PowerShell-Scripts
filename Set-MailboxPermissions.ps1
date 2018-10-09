<#
.SYNOPSIS
    Simple script to give users access to shared mailbox without having the mailbox download to Outlook desktop client
.DESCRIPTION
    Script will show a menu to choose either to check, remove, or add full access to a shared mailbox
.PARAMETER User
    Name of the user you want to change access for
    Email of shared emailbox
#>

# Checking connections to Exchange Online PS
Begin {
    Try { Get-MailboxPermission -Erroraction stop }


    Catch { 
    Clear-Host; 
    Write-Host "Not connected to Echange Online session" -ForegroundColor Red;
    $CRED = Get-Credential
    $SESSION = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $CRED -Authentication Basic -AllowRedirection 
    Import-PSSession $SESSION
    }
}

# If connected to EXO will bring up a menu
Process {
function Show-Menu {
     param (
           [string]$Title = 'Shared Mailbox FullAccess'
     )
     Clear-Host
     Write-Host "================ $Title ================"
     Write-Host "1: Check user delegation access to shared mailbox."
     Write-Host "2: Remove users 'Full Access' to shared mailbox."
     Write-Host "3: Add 'Full Access' rights to shared mailbox without AutoMapping enabled."
     Write-Host "4: Add 'Sendas Access' rights to shared mailbox."
     Write-Host "Q: Press 'Q' to quit."
}

do {
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                Clear-Host
                $email = Read-Host "Enter shared mailbox:"
                $user = Read-Host "Enter username:"
                Get-MailboxPermission -Identity $email -User $user

           } '2' {
                Clear-Host
                $email = Read-Host "Enter shared mailbox:"
                $user = Read-Host "Enter username:"
                Remove-MailboxPermission -Identity $email -User $user -AccessRights FullAccess
           } '3' {
                Clear-Host
                $email = Read-Host "Enter shared mailbox:"
                $user = Read-Host "Enter username:"
                Add-MailboxPermission -Identity $email -User $user -AccessRights FullAccess -AutoMapping:$false
            } '4' {
                Clear-Host
                $email = Read-Host "Enter shared mailbox:"
                $user = Read-Host "Enter username:"
                Add-RecipientPermission $email -AccessRights SendAs -Trustee $user  
           } 'q' {
                Remove-PSSession -ComputerName ps.outlook.com
                return
           }
     }
     pause
}
until ($input -eq 'q')
}