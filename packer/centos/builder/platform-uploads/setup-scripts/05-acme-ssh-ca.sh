#!/bin/bash -xe

# ACME-ssh-ca
# sudo cp /tmp/acme-cas.pub /etc/ssh/acme-cas.pub
sudo mkdir -p /etc/ssh/auth_principals/
sudo sh -c 'echo "TrustedUserCAKeys /etc/ssh/acme-cas.pub" >> /etc/ssh/sshd_config'
sudo sh -c 'echo "AuthorizedPrincipalsFile /etc/ssh/auth_principals/%u" >> /etc/ssh/sshd_config'
sudo sh -c 'echo "acme-recovery-user" > /etc/ssh/auth_principals/acme-recovery-user'
sudo sh -c 'echo "acme-recovery-user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/acme-recovery-user'
sudo useradd -m acme-recovery-user -s /bin/bash
sudo -H -u acme-recovery-user bash -c 'mkdir ~/.ssh'
# sudo -H -u acme-recovery-user bash -c 'cat /tmp/acme-recovery-user.pub > ~/.ssh/authorized_keys'
# sudo chmod 600 /home/acme-recovery-user/.ssh/authorized_keys
