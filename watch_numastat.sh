#!/bin/bash

watch -n1 "numastat -zmc | grep -A24 Total"
