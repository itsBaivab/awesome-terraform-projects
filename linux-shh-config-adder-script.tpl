cat <<EOF > /D:/terraform-learnings/linux-shh-config-adder-script.sh
#!/bin/bash

cat <<EOT >> ~/.ssh/config

Host $(hostname)
    HostName ${hostname}
    User ${user}
    IdentityFile ${identity_file}

EOT
EOF