#!/bin/bash

TRACE_DIR=/sys/kernel/debug/tracing
# Get root 

cd $TRACE_DIR 
sleep 1

echo > $TRACE_DIR/set_event
sleep 1

# Disable ftrace for configuration
echo 0 > $TRACE_DIR/tracing_on
sleep 1

# Exapnd buffer size 
#echo 50000 > $TRACE_DIR/buffer_size_kb
sleep 1

#Set current tracer to function
echo function > $TRACE_DIR/current_tracer
sleep 1

#echo 1 > $TRACE_DIR/events/vmscan/mm_vmscan_wakeup_kswapd/enable
echo 1 > $TRACE_DIR/events/migrate/mm_migrate_move_page/enable
sleep 1

echo migrate_move_page > $TRACE_DIR/set_ftrace_filter
sleep 1

echo 1 > $TRACE_DIR/options/func_stack_trace
sleep 1

echo 1 > $TRACE_DIR/tracing_on
sleep 1
