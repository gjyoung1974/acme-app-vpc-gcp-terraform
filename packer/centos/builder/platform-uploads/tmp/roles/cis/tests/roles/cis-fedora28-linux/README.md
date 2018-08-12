# RHEL7 CIS Benchmark role
#### Security and operationaly harden RHEL and Fedora19+ via CIS benchmark Guidance

```bash
$ ansible-playbook -i localhost, --skip=1.1.18,1.1.19,1.2.2,1.3.1,1.3.2,1.5.4,1.7.1.5,1.7.1.6,2.1.11,2.1.6,2.1.7,2.1.8,2.1.9,2.1.10,2.2.1.1,2.2.2,2.2.3,2.2.4,2.2.5,2.2.6,2.2.7,2.2.8,2.2.9,2.2.10,2.2.11,2.2.12,2.2.13,2.2.14,2.2.15,2.2.16,2.3.1,2.3.2,2.3.3,2.3.4,2.3.5,3.1.1,2.1.5,3.2.2,4.1.2 --e \"cis_level_1_exclusions=['3.2.8','5.3.4']\" playbook.yml --check
```

//TODOS:

1. switch "is package installed" tests from yum to dnf or package
1. Switch from Yum to DNF
https://prefetch.net/blog/2017/09/27/working-around-the-ansible-python2-yum-module-is-needed-for-this-module-error/

1. Switch from IPTables to FirewallD tests
1. Switch SystemD tests
1. existing accounts like root and any users get thier passwords expired immetiately and you can't log in after hardening
1. The FileSystem modules loading hardening breaks boot as it disables vfat (needed for UEFI boot)
/etc/modprobe.d/CIS.conf

1. Warning banner text: 
- banner not displated on XTerminal only actual terminal
- Banner not displated on Greeter screen



