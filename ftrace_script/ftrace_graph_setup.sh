#!/bin/bash 

TRACING_PATH="/sys/kernel/debug/tracing"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# clear ftrace set
echo 0 > $TRACING_PATH/tracing_on
echo 0 > $TRACING_PATH/options/sleep-time
echo > $TRACING_PATH/trace

echo "function_graph" > $TRACING_PATH/current_tracer

# set ftrace filter
cat ftrace_function_list > $TRACING_PATH/set_ftrace_filter
#echo "uvm_gpu_service_replayable_faults" > $TRACING_PATH/set_graph_function

echo 1 > $TRACING_PATH/tracing_on
