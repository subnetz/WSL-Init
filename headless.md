# Installation of headless Windows machine

## Overview

We will

-   install the Windows Subsystem for Linux (short: WSL)
-   update WSL to Version 2
-   install the distribution `Ubuntu-22.04`
-   set up `openssh-server` inside WSL, running on port 22
-   set up firewall rules for `openssh-server`
-   disable password authentication
-   enable key-based authentication
-   add other users
    -   copy pre-existing public keys for key-based authentication
    -   install `node version manager` (nvm) for each user

To make sure every script is in its place, connect to your remote machine via **Remote Desktop Connection**, download [this repo](github.com/subnetz/WSL-Init/archive/master.zip) and **extract it!**

It should look like this:

```
some_folder\
    copy_startup_script.bat
    headless.md
    init.sh
    laptop.md
    README.md
    [...]
```

## Update WSL

Since some kind of WSL is already installed in Windows 11, let's just "install without distribution".  
Open up CMD and type

```bat
wsl --install --no-distribution
```

### Restart your machine after the installation

Set your default WSL version to 2, check if it installed correctly, and update the subsystem

```bat
wsl --set-default-version 2
wsl --update
```

## Install Distribution

Let's install Ubuntu 22.04 for now.  
For the next step, be sure to use the "old" cmd.exe, since the new one doesn't accept shell input in the first installation of a linux distro.

```bat
wsl --install -d Ubuntu-22.04
```

For the initial unix username/password, just use local/local, we'll delete the user in the next step anyway.  
Exit the WSL shell with:

```bash
exit
```

You can now see all installed Distributions with

```bat
wsl --list
```

## Initial Ubuntu-22.04 setup

The script does the following:

-   sets `root` as the default WSl user
-   deletes the initial user
-   updates and upgrades with apt
-   installs build-essentials, cmake and openssh-server
-   disables password authentication for ssh
-   enables authentication via ssh keys

So, restart Ubuntu and run the script `start_wsl_init.bat`

## Run WSL on Windows Startup, add Firewall rules

The script `start_wsl_and_firewall.bat` does the following:

-   Checks if it runs as administrator
-   runs WSL in the background (WSL will no longer terminate itself when no shell is open)
-   creates a firewall rule called `OpenSSH Server (sshd) for WSL`
-   removes the "old port proxy" for WSL
-   gets the new local IP of WSL
-   adds a new port proxy for WSL for port 22

Run the `copy_startup_script.bat` script to copy `start_wsl_and_firewall.bat` to `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\`. If it does not work, copy it manually via explorer or via cmd by typing:

```bat
REM make sure to run as administrator!
copy ".\start_wsl_and_firewall.bat" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\" /Y
```

## Create users on Ubuntu

Since we deleted the first user, we only have the root user remaining.  
Now, we add all the users that want to use our headless machine.

We want to

-   add a user
-   add user to sudoers
-   add a home directory
-   add the correct public ssh key to `~/.ssh/authorized_keys`
-   set the correct rights for the `.ssh` folder
-   install nvm

So, take a look at `users.txt`, add username and public keys to the file, and open `run_createUsers.bat` or type `sudo bash createUsers.sh` inside WSL
