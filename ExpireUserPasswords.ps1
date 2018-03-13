# Script to expire AD passwords from a list
# Account name must be in from of SamAccountName

$file = Read-Host 'What is the path to the file'

ForEach ($user in $(Get-Content $file)) {
    Get-ADUser -Identity $user | Set-ADUser -ChangePasswordAtLogon 1
    }