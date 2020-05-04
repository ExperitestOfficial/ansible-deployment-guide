# SSH Login

## Login to remote machine without password {#passwordless-login}

Perform the following step to ensure connectivity from the executor to the target machine.

* create ssh key - `ssh-keygen`\
  follow the step in the cli

* copy the ssh public key - `ssh-copy-id <username>@<machine-ip>`\
  enter credentials of the target machine and confirm

## [Elevating permissions without password](#passwordless-elevation)

Login is not enough, we also (need in some cases) to perform commands as sudo.

Perform the following command in the target machine to avoid password request when elevating permissions (becoming sudo)

* open sudoers file - `sudo visudo`
* add the user to no password - in the end of the file\
  `<username> ALL=(ALL) NOPASSWD:ALL`

NOTE:\
If NOPASSWD is not allowed (for security reasons), the alternative is adding the following variable to the ansible inventory file:

```
[mac-instance]
<machine-ip>

[mac-instance:vars]
ansible_user=<username>
ansible_become_user=<username>      <---
ansible_password=<password>         <---
ansible_become_password=<password>  <---
```

## [Confirm host identity](#known-hosts)

Successful login doesn't guarantee that the target is actually the target (attacker can accept all logins). \
To avoid coping secrets to unknown hosts, you need to confirm (once per target) the identity of the target. 

This can be done by logging in once from the control to the target machine. \
During the login you will be prompt to add the host to known host. \
Approving will add the signature to ~/.ssh/known_hosts file.

### Ignoring known hosts
It is ***not recommended*** to turn off this feature. \
Having said that, if you execute from multiple control machine (not recommended), known hosts file can be a pain. \
[Read more](https://docs.ansible.com/ansible/latest/user_guide/intro_getting_started.html#host-key-checking) about how to disable this feature in the official docs.
