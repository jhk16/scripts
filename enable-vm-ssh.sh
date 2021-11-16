#/bin/bash

# This script should be executed on virtual enviornment
NETPLAN="/etc/netplan/init.yaml"
echo "network:" > ${NETPLAN}
echo "  ethernets:" >> ${NETPLAN}
echo "    ens3:" >> ${NETPLAN}
echo "      dhcp4: yes" >> ${NETPLAN}
echo "  version: 2" >> ${NETPLAN}

sudo ip link set dev ens3 up
sudo netplan apply
