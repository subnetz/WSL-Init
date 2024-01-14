#!/bin/bash

# set root as default WSL user
sudo echo "[boot]
systemd=true
[user]
default=root" >/etc/wsl.conf

# delete initial user
firstUser=$(grep -Po '^sudo.+:\K.*$' /etc/group)
sudo userdel -r $firstUser

# update
sudo apt update
sudo apt upgrade -y

# install build-essentials, cmake and ssh-server
sudo apt install -y build-essential cmake openssh-server

# disable password authentication via ssh, only authenticate via ssh keys
sudo sed -i "s/.*RSAAuthentication.*/RSAAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -ri "s/^#? *PasswordAuthentication *yes.*/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/.*AuthorizedKeysFile.*/AuthorizedKeysFile\t\.ssh\/authorized_keys/g" /etc/ssh/sshd_config
sudo sed -i "s/.*PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
sudo systemctl restart ssh
