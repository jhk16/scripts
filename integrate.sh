#!/bin/bash

sudo /home/kjh/scripts/prefetchers.sh disable > /dev/null
sudo /home/kjh/scripts/turbo-boost.sh disable > /dev/null
sudo /home/kjh/scripts/set_max_freq.sh > /dev/null
# cat /proc/cmdline
# cat /proc/cpuinfo | grep MHz
