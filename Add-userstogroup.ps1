$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://cabvm-exhybr-01.otcorp.opentable.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Import-PSSession $Session

$GroupCsv= Import-Csv '.\groups.csv'
$rec = @()
foreach($line in $GroupCsv){
$Groupname=$line.Groupname
$csv = Import-Csv '.\groups.csv'
foreach($r in $csv){
if($r.Department -eq $Department )
{ 
$DLGP = "" | Select "UserPrincipalName","GPname"
$DLGP.UserPrincipalName = $r.UserPrincipalName
$DLGP.GPname = $line.Groupname
$rec+= $DLGP
$DLGP=$null
}
}
}
$rmgp=@()
foreach($ln in $rec){
If($rmgp -notcontains $ln.GPname)
{
$rmgp+=$ln.GPname
}
}
foreach($gpl in $rmgp){
$Disgp=$gpl
$GPuser=@()
foreach($uln in $rec){
If($Disgp -eq $uln.GPname)
{
$GPuser+=$uln.UserPrincipalName
}
}
Update-DistributionGroupMember -Identity $($Disgp) -Member $GPuser -Confirm:$false -BypassSecurityGroupManagerCheck
$GPuser=$null
}