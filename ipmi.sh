#!/bin/bash
IPADDR=$1
NETMASK=$2
GATEWAY=$3

# 1. check ipmi modules
# lsmod | grep ipmi

# sudo modprobe ipmi_devintf
# sudo modprobe ipmi_msghandler

# 2. install ipmitool
# sudo apt install -y ipmitool

# 3. configure ipmi network
# sudo ipmitool lan set 1 ipsrc static
# sudo ipmitool lan set 1 ipaddr ${IPADDR}
# sudo ipmitool lan set 1 netmask ${NETMASK}
# sudo ipmitool lan set 1 defgw ipaddr ${GATEWAY}

# sudo ipmitool lan print 1

# 4. create user for IPMI control

# sudo ipmitool user list 1
# sudo ipmitool user list 1		# listing user for channel 1
# ID  Name	     Callin  Link Auth	IPMI Msg   Channel Priv Limit
# 2   ADMIN            false   false      true       ADMINISTRATOR

# create user (ID: 3, jonghyeon): set name <user id> <username>
# sudo ipmitool user set name 3 jonghyeon

# update user’s password: (set password <user id> <password>)
# sudo ipmitool user set password 3 XXXXX

# ipmitool user list 1
# ID  Name	     Callin  Link Auth	IPMI Msg   Channel Priv Limit
# 2   ADMIN            false   false      true       ADMINISTRATOR
# 3   jonghyeon        true    false      false      NO ACCESS

# setting permission: ipmitool user priv <user id> <privilege level> <channel number>
# sudo ipmitool user priv 3 4 1
# sudo ipmitool user list 1
# ID  Name	     Callin  Link Auth	IPMI Msg   Channel Priv Limit
# 2   ADMIN            false   false      true       ADMINISTRATOR
# 3   jonghyeon        true    false      true       ADMINISTRATOR

# enable your account
# ipmitool user enable 3
