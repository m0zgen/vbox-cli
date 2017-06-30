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
    "$SCRIPTNAME -states | --show-vm-states\n" \
    "$SCRIPTNAME -running | --show-vm-running\n" \
    "$SCRIPTNAME -start | --start-vm [vmname]\n" \
    "$SCRIPTNAME -start-hidden | --start-vm-hidden [vmname]\n" \
    "$SCRIPTNAME -start-simple | --start-vm-simple-gui [vmname]\n" \
    "$SCRIPTNAME -pause | --pause-vm [vmname]\n" \
    "$SCRIPTNAME -resume | --resume-vm [vmname]\n" \
    "$SCRIPTNAME -reset | --reset-vm [vmname]\n" \
    "$SCRIPTNAME -off | --poweroff-vm [vmname]\n" \
    "$SCRIPTNAME -save | --save-vm [vmname]\n"
}

function show-vm(){
  VBoxManage list vms | sed "s/\"\(.*\)\".*/\1/"
  End
}

function show-vm-states(){
  VBoxManage list vms -l | grep -e ^Name: -e ^State  | sed "s/Name:[ ]*\(.*\)/\1 \//;s/State:[\ ]*//" | paste -d " " - -
}

function show-vm-running(){
  VBoxManage list runningvms
}

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

  End

}

function resume-vm(){
  End
}

function reset-vm(){
  End
}

function poweroff-vm(){
  End
}

function save-vm(){
  End
}

# ---------------------------------------------------------- ACTION #



# ---------------------------------------------------------- CHECK ARGS #
if [[ -z $1 ]]; then
  find-vbox
  Warning "Please see help: $SCRIPTNAME --help"
  End
  exit
fi

# ---------------------------------------------------------- ARGS #
while [ "$1" != "" ]; do
    case $1 in
        -show | --show-vm )                       shift
                                                  show-vm
                                                  ;;
        -states | --show-vm-states )              shift
                                                  show-vm-states
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
        -f | --file )           shift
                                filename=$1
                                ;;
        -f | --file )           shift
                                filename=$1
                                ;;
        -f | --file )           shift
                                filename=$1
                                ;;
        -i | --interactive )    interactive=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done