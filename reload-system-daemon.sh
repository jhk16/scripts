#!/bin/bash

# You should check your systemd-logind.service, systemd-udev.service file
# You can see IPAddressDeny= in your file, so, you comment that line.

# PATH of systemd-logind: /lib/systemd/system/systemd-logind.service
# PATH of systemd-udevd : /lib/systemd/system/systemd-udevd.service

sudo systemctl daemon-reload
sudo systemctl restart systemd-logind.service
sudo systemctl restart systemd-udevd.service
