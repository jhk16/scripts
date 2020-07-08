#!/bin/bash

watch -n1 "numastat -mc | grep -A28 Total"
