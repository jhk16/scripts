#/bin/bash

# You need to modify the kernel source root path & Linux release image path
KERNEL=./
IMAGE=./

# Check below kernel configurations
## For debugging
# CONFIG_DEBUG_INFO=y
# CONFIG_FRAME_POINTER=y
# CONFIG_KGDB=y
# CONFIG_KGDB_SERIAL_CONSOLE=y

## For ssh
# CONFIG_E1000=y
# CONFIG_E1000E=y
# CONFIG_E1000E_HWTS=y

sudo qemu-system-x86_64 \
        -kernel $KERNEL/arch/x86/boot/bzImage \
        -append "rw console=ttyS0,115200 root=/dev/sda" \
        -hda $IMAGE/bionic.img \
        -enable-kvm -cpu host \
        -nographic \
        -device e1000,netdev=net0 \
        -netdev user,id=net0,hostfwd=tcp::2222-:22 \
        -m 16G \
        -smp cpus=8,cores=4,maxcpus=8,dies=1,sockets=2,threads=1 \
        -numa node,nodeid=0,cpus=0-3 \
        -numa node,nodeid=1,cpus=4-7 \
        -pidfile vm.pid -s \
        2>&1 | tee vm.log
