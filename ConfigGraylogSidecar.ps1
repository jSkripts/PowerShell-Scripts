<# 
  Created By Joel aka jskripts
   https://github.com/jSkripts
#>

# Script to configure Graylog sidecar collector

$ServerUrl = "https://graylog-prod-sc-01.otsql.opentable.com:9000/api"
#Gets hostname
$Hostname = HOSTNAME.EXE


#Sets configuration for sidecar collector
collector_sidecar_installer.exe /S -SERVERURL= $ServerUrl -TAGS="windows,iis" -NODEID= $Hostname


#Installs and starts sidecar collector
Set-Location 'C:\Program Files\Graylog\collector-sidecar'

.\Graylog-collector-sidecar.exe -service install
.\Graylog-collector-sidecar.exe -service start

