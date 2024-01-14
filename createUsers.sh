#!/bin/bash

while IFS=' ' read -r user sshtype sshkey sshident; do
    i=0
    while read var; do
        [ -z "${!var}" ] && {
            let i=i+1
        }
    done <<EOF
user
sshtype
sshkey
sshident
EOF

    if [ $i -gt 0 ]; then
        echo "ERROR: users.txt needs to have 4 parameters:"
        echo "<username> <ssh-key type> <public ssh-key> <ssh-key identifier>"
        exit 1
    else

        if id "$user" >/dev/null 2>&1; then
            echo "user $user already exists, only updating key file"
        else
            echo "adding user $user with key $sshtype $sshkey $sshident"
            sudo useradd -m -p $(openssl passwd -1 $user) --groups sudo -s /bin/bash $user
        fi

        sudo mkdir /home/$user/.ssh
        sudo chmod 700 /home/$user/.ssh
        sudo mv /home/$user/.ssh/authorized_keys /home/$user/.ssh/authorized_keys.old
        sudo echo "$sshtype $sshkey $sshident" >/home/$user/.ssh/authorized_keys
        sudo chmod 600 /home/$user/.ssh/authorized_keys
        sudo chown $user:$user /home/$user/.ssh -R
        runuser -l $user -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

    fi

done <users.txt
