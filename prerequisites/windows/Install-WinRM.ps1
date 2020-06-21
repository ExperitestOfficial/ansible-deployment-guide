
#########################################################
# bootstrap script for ansible
# configures - firewall, and winrm settings
#########################################################

# $url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "ConfigureRemotingForAnsible.ps1"

# (New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file

winrm enumerate winrm/config/Listener

winrm quickconfig

winrm get winrm/config/Service

winrm get winrm/config/Winrs

(Get-Service -Name winrm).Status