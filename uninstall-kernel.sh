#!/bin/bash
# Referenced by https://sjp38.github.io/post/uninstall-kernel/

kernel=$1
if [[ -z $kernel ]]; then
	echo "no kernel name"
	exit
fi
check=($(ls /boot | grep $kernel))

if [[ -z $check ]]; then
	echo "no exist kernel"
	exit
fi

rm /boot/vmlinuz-$kernel
rm /boot/initrd.img-$kernel
rm /boot/System.map-$kernel
rm /boot/config-$kernel
rm -fr /lib/modules/$kernel
rm /var/lib/initramfs-tools/$kernel
update-grub2
