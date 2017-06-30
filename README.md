# Vbox-cli
Simple management tool for VirtualBox machines on Fedora / CentOS

[Russian article in my Blog](https://sys-adm.in/virtualization/720-upravlenie-mashinami-virtualbox-iz-terminala.html)

# Usage
If You run script without parameters, You see help, how to usage this script.
```
 vbox-cli.sh -show | --show-vm
 vbox-cli.sh -status | --show-vm-status
 vbox-cli.sh -running | --show-vm-running
 vbox-cli.sh -start | --start-vm [vmname]
 vbox-cli.sh -start-hidden | --start-vm-hidden [vmname]
 vbox-cli.sh -start-simple | --start-vm-simple-gui [vmname]
 vbox-cli.sh -pause | --pause-vm [vmname]
 vbox-cli.sh -resume | --resume-vm [vmname]
 vbox-cli.sh -reset | --reset-vm [vmname]
 vbox-cli.sh -off | --poweroff-vm [vmname]
 vbox-cli.sh -save | --save-vm [vmname]

```
# Show
```
-show | --show-vm
```
Show all created VM

# Status
```
-status | --show-vm-status
```
Show VM statuses. Example:
```
./vbox-cli.sh -status
cent01 / powered off (since 2017-06-30T19:20:03.939000000)
scrum / powered off (since 2017-06-30T18:33:17.693000000)
centos-custom / powered off (since 2017-06-20T15:55:37.000000000)
win10 / powered off (since 2017-06-22T18:12:51.000000000)
kali / powered off (since 2017-05-23T19:04:18.000000000)
fedora / powered off (since 2017-06-30T19:16:16.538000000)
```

# Show running VM
```
-running | --show-vm-running
```

# Start VM
```
-start | --start-vm [vmname]
```
Example:
```
vbox-cli.sh -start cent01
```

# Start Hidden
Start VM in background without GUI windows

# Start simple
Start VM in simple window without control buttons and menus

# Pause / Resume
Pause VM / Resume VM

# Reset
Fast reset (reboot) VM

# Poweroff
Shutdown VM

# Save
Save current VM state

# Install / Uninstall
This command must be run from root. After script run with parameter "-i" script will be installed to folder /usr/bin, after run script with parameter "-u", script will be deleted from folder /usr/bin.

---

[Thx MILOSZ](https://blog.sleeplessbeastie.eu/2013/07/23/virtualbox-how-to-control-virtual-machine-using-command-line/)