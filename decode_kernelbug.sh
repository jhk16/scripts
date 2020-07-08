#!/bin/bash

# dmesg > input.log
# The source directory is linux kernel root
INPUT=$1

./scripts/decode_stacktrace.sh vmlinux ./ < $INPUT > output.log

cat output.log
