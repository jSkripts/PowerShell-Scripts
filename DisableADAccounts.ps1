<#
  Created By Joel Perez
   https://github.com/jSkripts
#>

# Script to disable accounts from list
# Account name must be in from of SamAccountName
# TODO: Create GUI (Not needed but would be nice)

# Paramiters needed for script
Param (
    [string]$InputFile = (Read-Host "File Path to Users"),
    [string]$OutputFile = (Read-Host "Path to Output")
 )

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

$Result = @()
$DisabledCount = 0
$AlreadyDisabledCount = 0
$NotFoundCount = 0

Get-Content $InputFile | ForEach-Object {
    $User = $null
    $User = Get-ADUser $_
    If ($User) {
        If ($User.Enabled) {
            $User | Set-ADUser -Enabled $false
            $Result += New-Object PSObject -Property @{
                        User = $User.Name
                        DN = $User.distinguishedName
                        Status = "Disabled"
                        }
            $DisabledCount ++
            }
        Else {
         $Result += New-Object PSObject -Property @{
           User = $User.Name
           DN = $User.distinguishedName
           Status = "Already disabled"
          }
         $AlreadyDisabledCount ++
            }
     }
    Else {
   $Result += New-Object PSObject -Property @{
            User = $_
            DN = "N/A"
            Status = "User not found"
            }
    $NotFoundCount ++
    }
}


# Show results with Out Gridview
$Result = $Result | Select-Object User,Status,DN
$Result | Out-GridView
$Result | Export-CSV $OutputFile -NoTypeInformation
Clear-Host

# Output to console
Write-Host "Accounts in file: $((Get-Content $InputFile).Count)"
Write-Host "Users Disabled: $DisabledCount"
Write-Host "Users Already Disabled: $AlreadyDisabledCount"
Write-Host "Users Not Found: $NotFoundCount"