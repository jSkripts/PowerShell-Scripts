# This script is to querey the AD to check when an active user last set their password
get-aduser -filter 'enabled -eq $true' -SearchBase "OU=Users,OU=OT,DC=otcorp,DC=opentable,DC=com" -properties passwordlastset  |
# Filters passwordlastset for last 30days
Where {$_.Passwordlastset -le (Get-date).AddDays(-30)} |
# Sorts the list by Name in aphabetical order
sort-object name |
# Selects atributes we are looking for
select-object Name, SamAccountName, passwordlastset |
# Exports to CSV file
Export-csv -path C:\Users\jperezsanchez\Documents\results.csv
