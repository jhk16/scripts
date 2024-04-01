#!/bin/bash

sudo apt update && sudo apt upgrade -y

# For tunning CPU frequency
# sudo apt install -y msr-tools

# For kernel build
sudo apt install -y build-essential libncurses5 libncurses5-dev bin86 kernel-package libssl-dev bison flex libelf-dev libpython2.7-dev mlocate

# For perf with all features on
sudo apt install -y libdwarf-dev libdw-dev binutils-dev libcap-dev libelf-dev \
	libnuma-dev libperl-dev python2 python2-dev python-setuptools \
	libssl-dev libunwind-dev libdwarf-dev libunwind-dev zlib1g-dev \
	liblzma-dev libaio-dev asciidoc libzstd-dev systemtap-sdt-dev \
	libslang2-dev binutils-dev libiberty-dev libbabeltrace-dev \
	libbabeltrace-ctf-dev libbfb0-dev python-is-python2 python3-pip \
	libgtk2.0-dev libaudit-dev

sudo apt install -y exuberant-ctags

## Build perf
sudo apt install libstdc++-10-dev
sudo apt install libc++-11-dev
sudo apt install libc++abi-11-dev
cd /path/linux/kernel/source
make -C tools/perf

## Install perf
# make prefix=/usr/local -C tools/perf install
# For more detail, please refer to 'make -C tools/perf help'

# For DCPMM dax
sudo apt install -y ipmctl ndctl daxctl

# For NUMA control
sudo apt install -y numactl

# To plot graphs
sudo apt install -y gnuplot
pip install numpy pandas matplotlib seaborn

# For YCSB
sudo apt install -y maven

# For RocksDB db_bench
sudo apt install -y libgflags-dev

# # For VoltDB
sudo apt install -y ant ant-optional cmake valgrind ntp ccache python-httplib2  apt-show-versions openjdk-8-jdk

# Build VoltDB
cd voltdb
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ant

# For silo
sudo apt install -y libdb++-dev

# For HiBench
sudo apt install -y scala

# Build HiBench all
cd Hibench
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 sudo mvn -Dspark=2.1 -Dscala=2.11 clean package

# Build Hadoop and Spark (hadoop-2.7.7, spark-2.4.7-bin-hadoop2.7 from Pond ASPLOS'23)
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
tar zxvf hadoop-2.7.7.tar.gz

wget https://archive.apache.org/dist/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz
tar zxvf spark-2.4.7-bin-hadoop2.7.tgz

# # For redis
sudo apt install -y pkg-config

# # For Spark-sql-perf(TPC-DS)
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk curl libblas3 liblapack3
sudo apt-get install apt-transport-https curl gnupg -yqq
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
sudo apt-get update
sudo apt-get install sbt

# # For QEMU to test linux kernel
sudo apt install -y qemu-system-x86
sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
wget https://download.qemu.org/qemu-8.0.5.tar.xz

# # To remove GUI package
sudo apt purge -y gdm3

# # For memcached 1.6.6
sudo apt install -y autotools-dev
sudo apt install -y automake
sudo apt install -y libevent-dev

# # For mutilate
sudo apt install -y scons libevent-dev gengetopt libzmq3-dev

## For IOMMU NPF tool (IOTLB test)

## For SR-IOV setup
# Refer to https://www.intel.com/content/www/us/en/developer/articles/technical/configure-sr-iov-network-virtual-functions-in-linux-kvm.html
sudo apt install libvirt-clients
sudo apt install libvirt-clients libvirt-daemon-system virtinst bridge-utils
# virsh dumpxml sr-iov-vf-testvm
