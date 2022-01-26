#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "Please run as root or sudo"
    exit
fi
# Pre-requisite tools
# ipmctl : Choose mode among memory mode and App-Direct mode
# ndctl : In App-Direct mode, choose memory type(fsdax, devdax, pmem, system-ram)
# daxctl : Configure dax devices

daxctl reconfigure-device --mode=system-ram --no-online dax0.0
daxctl reconfigure-device --mode=system-ram --no-online dax1.0
