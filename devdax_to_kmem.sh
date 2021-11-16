#!/bin/bash

dax_path=/sys/bus/dax/drivers
dax_arr=()

if [ $EUID -ne 0 ]; then
    echo "Please run as root or sudo"
    exit
fi

for dev in $dax_path/device_dax/dax*
do
    dax_arr+=($(basename $dev))
done

for entry in ${dax_arr[@]}
do
    daxctl reconfigure-device --mode=system-ram --no-online dax0.0
    daxctl reconfigure-device --mode=system-ram --no-online dax1.0
    # echo "Unbinding $entry..."
    # echo $entry > $dax_path/device_dax/unbind
    # echo "Adding volatile-memory $entry..."
    # echo $entry > $dax_path/kmem/new_id
done
