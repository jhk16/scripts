#!/bin/bash
sudo ndctl disable-namespace all
sudo ndctl destroy-namespace all
sudo ipmctl create -goal MemoryMode=100
# Reboot
