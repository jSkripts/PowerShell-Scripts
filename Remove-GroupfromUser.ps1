########################################################

Import-Module ActiveDirectory

$list=Import-Csv c:\testing\disabledusers.txt
forEach ($item in $list) {
    $user = Get-ADUser $item.'SamAccountName'
    $user | Disable-ADAccount
    }
    

$TargetOU = "OU=ot,OU=disabled users,DC=otcorp,DC=opentable,DC=com" 
   Import-Csv -Path C:\testing\disabledusers.txt | ForEach-Object { 
$UserDN = (Get-ADUser -Identity $_.Name).distinguishedName 
Move-ADObject -Identity $UserDN -TargetPath $TargetOU 
 } 

$searchOU = "OU=ot,OU=disabled users,DC=otcorp,DC=opentable,DC=com"
 
$adgroup = Get-ADGroup -Filter 'GroupCategory -eq "Security" -or GroupCategory -eq "Distribution"' -SearchBase $searchOU
$adgroup | ForEach-Object{ $group = $_
    Get-ADGroupMember -Identity $group -Recursive | %{Get-ADUser -Identity $_.distinguishedName -Properties Enabled | ?{$_.Enabled -eq $false}} | ForEach-Object{ $user = $_
        $uname = $user.Name
        $gname = $group.Name
        Write-Host "Removing $uname from $gname" -Foreground Yellow
        Remove-ADGroupMember -Identity $group -Member $user -Confirm:$false
    }
}

#######################################################