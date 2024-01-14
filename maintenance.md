# Maintenance Commands

-   **[WSL](#wsl_top)**
    -   [Shut down WSL](#shutdown_wsl)
    -   [Start WSL in the background](#start_wsl_background)
    -   [Install a new WSL distribution](#wsl_install_distro)
    -   [Remove a WSL distribution](#wsl_remove)
-   **[Linux](#linux_top)**
    -   [Remove a user](#linux_deluser)
    -   [Add a user (scripted, with public key)](#linux_scriptadduser)

<a name="wsl_top"></a>

# WSL

<a name="shutdown_wsl"></a>

## Shut down WSL

```bat
wsl -t Ubuntu-22.04
```

<a name="list_all_distros"></a>

## List all WSL distributions

```bat
wsl --list --verbose
```

<a name="start_wsl_background"></a>

## Start WSL in the background

```bat
wsl --exec dbus-launch true
```

<a name="wsl_install_distro"></a>

## Install a new WSL distribution

List the available distributions with

```bat
wsl --list --online
```

Install a new distribution with

```bat
wsl --install -d <distro_name>
```

<a name="wsl_remove"></a>

## Remove a WSL distribution

List the available distributions with

```bat
wsl --list --online
```

Remove a new distribution with

```bat
wsl --unregister <distro_name>
```

<a name="linux_top"></a>

# Linux

<a name="linux_deluser"></a>

## Remove a user

List all sudo users with

```bash
grep -Po '^sudo.+:\K.*$' /etc/group
```

Remove a user with

```bash
sudo userdel -r <username>
```

<a name="linux_scriptadduser"></a>

## Add a user (scripted, with public key)

Add `<user> <ssh-type> <ssh-key> <ssh-ident>` to `users.txt`, for example

```
myUser ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvTi5LTKhdmOW7bVqHwGwto4BRqiGCd6hK1Ek/guJws myUser@testing
```

After that, run `run_createUsers.bat`

<a name="linux_scriptmodifykey"></a>

## Modify public key of already existing user

Add `<user> <ssh-type> <ssh-key> <ssh-ident>` to `users.txt`, for example

```
myAlreadyExistingUser ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvTi5LTKhdmOW7bVqHwGwto4BRqiGCd6hK1Ek/guJws myUser@testing
```

After that, run `run_createUsers.bat`
