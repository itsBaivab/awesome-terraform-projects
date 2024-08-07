add-content -path C:\Users\mukho\.ssh\config -value @'


Host $(hostname)
 HostName ${hostname}
 User ${user}
 IdentityFile ${identity_file}
'@ 