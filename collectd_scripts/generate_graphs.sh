#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2

rrdtool graph $OUTPUT_DIR/disk_octets.png -w 800 -h 800 DEF:disk_oct_read=$INPUT_DIR/disk_octets-vda.rrd:read:AVERAGE DEF:disk_oct_write=$INPUT_DIR/disk_octets-vda.rrd:write:AVERAGE LINE1:disk_oct_read#FF0000 LINE1:disk_oct_write#00FF00

rrdtool graph $OUTPUT_DIR/disk_ops.png -w 800 -h 800 DEF:disk_oct_read=$INPUT_DIR/disk_octets-vda.rrd:read:AVERAGE DEF:disk_oct_write=$INPUT_DIR/disk_octets-vda.rrd:write:AVERAGE LINE1:disk_oct_read#FF0000 LINE1:disk_oct_write#00FF00

rrdtool graph $OUTPUT_DIR/if_errors_vnet0.png -w 800 -h 800 DEF:if_errors-RX=$INPUT_DIR/if_errors-vnet0.rrd:rx:AVERAGE DEF:if_errors-TX=$INPUT_DIR/if_errors-vnet0.rrd:tx:AVERAGE LINE1:if_errors-RX#FF0000 LINE1:if_errors-TX#00FF00

rrdtool graph $OUTPUT_DIR/if_dropped_vnet0.png -w 800 -h 800 DEF:if_dropped-RX=$INPUT_DIR/if_dropped-vnet0.rrd:rx:AVERAGE DEF:if_dropped-TX=$INPUT_DIR/if_dropped-vnet0.rrd:tx:AVERAGE LINE1:if_dropped-RX#FF0000 LINE1:if_dropped-TX#00FF00

rrdtool graph $OUTPUT_DIR/if_octets_vnet0.png -w 800 -h 800 DEF:if_octets-RX=$INPUT_DIR/if_octets-vnet0.rrd:rx:AVERAGE DEF:if_octets-TX=$INPUT_DIR/if_octets-vnet0.rrd:tx:AVERAGE LINE1:if_octets-RX#FF0000 LINE1:if_octets-TX#00FF00

rrdtool graph $OUTPUT_DIR/if_packets_vnet0.png -w 800 -h 800 DEF:if_packets-RX=$INPUT_DIR/if_packets-vnet0.rrd:rx:AVERAGE DEF:if_packets-TX=$INPUT_DIR/if_packets-vnet0.rrd:tx:AVERAGE LINE1:if_packets-RX#FF0000 LINE1:if_packets-TX#00FF00

rrdtool graph $OUTPUT_DIR/virt_cpu_total.png -w 800 -h 800 DEF:cpu_ns=$INPUT_DIR/virt_cpu_total.rrd:ns:AVERAGE LINE1:cpu_ns#FF0000
