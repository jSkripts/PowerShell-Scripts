$UserCredential = Get-Credential


$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://CABVM-EXHYBR-01.otcorp.opentable.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session -DisableNameChecking