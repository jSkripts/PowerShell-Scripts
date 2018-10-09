# Set-ExecutionPolicy Unrestricted

$CRED = Get-Credential
$SESSION = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $CRED -Authentication Basic -AllowRedirection
Import-PSSession $SESSION -DisableNameChecking
