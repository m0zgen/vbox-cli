#!/bin/bash
# Simple management tool for VirtualBox machines
# Created by Yevgeniy Goncharov / https://sys-adm.in

# ---------------------------------------------------------- VARIABLES #
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPTPATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
SCRIPTNAME=`basename "$0"`

# ---------------------------------------------------------- Colorize #

Info() {
  printf "\033[1;32m$@\033[0m\n"
}

Warning() {
  printf "\033[1;35m$@\033[0m\n"
}

Error() {
  printf "\033[1;31m$@\033[0m\n"
}

End() {
  echo -e ""
}

# ---------------------------------------------------------- FUNCTIONS #
function find-vbox(){
  # Check if VirtualBox installed
  if [[ -f /usr/bin/VBoxManage ]]; then
    Info "\nVirtualBox found!\n"
  fi
}

function usage() {

    Info "\nUsage"

    echo -e "" \
    "$SCRIPTNAME -show | --show-vm\n" \
    "$SCRIPTNAME -status | --show-vm-status\n" \
    "$SCRIPTNAME -running | --show-vm-running\n" \
    "$SCRIPTNAME -start | --start-vm [vmname]\n" \
    "$SCRIPTNAME -start-hidden | --start-vm-hidden [vmname]\n" \
    "$SCRIPTNAME -start-simple | --start-vm-simple-gui [vmname]\n" \
    "$SCRIPTNAME -pause | --pause-vm [vmname]\n" \
    "$SCRIPTNAME -resume | --resume-vm [vmname]\n" \
    "$SCRIPTNAME -reset | --reset-vm [vmname]\n" \
    "$SCRIPTNAME -off | --poweroff-vm [vmname]\n" \
    "$SCRIPTNAME -save | --save-vm [vmname]\n" \
    "$SCRIPTNAME -i | --install\n" \
    "$SCRIPTNAME -u | --uninstall\n"
}

# VM Statuses
function show-vm(){
  VBoxManage list vms | sed "s/\"\(.*\)\".*/\1/"
  End
}

function show-vm-status(){
  VBoxManage list vms -l | grep -e ^Name: -e ^State  | sed "s/Name:[ ]*\(.*\)/\1 \//;s/State:[\ ]*//" | paste -d " " - -
}

function show-vm-running(){
  VBoxManage list runningvms
}

# VM Operations
#
function start-vm(){

  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage startvm $1
  fi

}

function start-vm-hidden(){

  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage startvm $1 --type headless
  fi

}

function start-vm-simple-gui(){

  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage startvm $1 --type sdl
  fi

}

function pause-vm(){

  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage controlvm $1 pause
  fi

}

function resume-vm(){

  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage controlvm $1 resume
  fi

}

function reset-vm(){

  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage controlvm $1 reset
  fi

}

function poweroff-vm(){
  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage controlvm $1 poweroff
  fi
}

function save-vm(){
  if [[ -z "$1" ]]; then
    Warning "Please determine [vmname]"
  else
    VBoxManage controlvm $1 savestate
  fi
}

# Install
#
function install(){
  if [ "$(id -u)" != "0" ]; then
    Error "This script must be run as root" 1>&2
    exit 1
  else
    if [[ -f /usr/bin/$SCRIPTNAME ]]; then
        Warning "Script already installed. Uninstall first."
      else
        cp $SCRIPTPATH/$SCRIPTNAME /usr/bin/
        Info "Script installed to folder /usr/bin/$SCRIPTNAME"
    fi
  fi
}

# Uninstall
#
function uninstall(){
  if [ "$(id -u)" != "0" ]; then
    Error "This script must be run as root" 1>&2
    exit 1
  else
    if [[ -f /usr/bin/$SCRIPTNAME ]]; then
        rm /usr/bin/$SCRIPTNAME
        Info "Script removed from folder /usr/bin/$SCRIPTNAME. Done!"
      else
        Warning "Script not installed!"
    fi

  fi
}

# ---------------------------------------------------------- CHECK ARGS #
if [[ -z $1 ]]; then
  find-vbox
  usage
  End
  exit
fi

# ---------------------------------------------------------- ARGS #
while [ "$1" != "" ]; do
    case $1 in
        -show | --show-vm )                       shift
                                                  show-vm
                                                  ;;
        -status | --show-vm-status )              shift
                                                  show-vm-status
                                                  ;;
        -running | --show-vm-running )            shift
                                                  show-vm-running
                                                  ;;
        -start | --start-vm )                     shift
                                                  start-vm $1
                                                  ;;
        -start-hidden | --start-vm-hidden )       shift
                                                  start-vm-hidden $1
                                                  ;;
        -start-simple | --start-vm-simple-gui )   shift
                                                  start-vm-simple-gui $1
                                                  ;;
        -pause | --pause-vm )                     shift
                                                  pause-vm $1
                                                  ;;
        -resume | --resume-vm )                   shift
                                                  resume-vm $1
                                                  ;;
        -reset | --reset-vm )                     shift
                                                  reset-vm $1
                                                  ;;
        -off | --poweroff-vm )                     shift
                                                  poweroff-vm $1
                                                  ;;
        -save | --save-vm )                       shift
                                                  save-vm $1
                                                  ;;
        -i | --install )                          shift
                                                  install
                                                  ;;
        -u | --uninstall )                        shift
                                                  uninstall
                                                  ;;
        -h | --help )                             usage
                                                  exit
                                                  ;;
        * )                                       usage
                                                  exit 1
    esac
    shift
done