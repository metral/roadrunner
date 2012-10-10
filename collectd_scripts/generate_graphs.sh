#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2
START_TIME=$3
END_TIME=$4

function graph {

    rrdtool graph $OUTPUT_DIR/disk_octets.png -w 800 -h 800 \
        DEF:disk_oct_read=$INPUT_DIR/disk_octets-vda.rrd:read:AVERAGE \
        DEF:disk_oct_write=$INPUT_DIR/disk_octets-vda.rrd:write:AVERAGE \
        LINE2:disk_oct_read#FF0000 \
        LINE2:disk_oct_write#00FF00 $1 

    rrdtool graph $OUTPUT_DIR/disk_ops.png -w 800 -h 800 \
        DEF:disk_oct_read=$INPUT_DIR/disk_octets-vda.rrd:read:AVERAGE \
        DEF:disk_oct_write=$INPUT_DIR/disk_octets-vda.rrd:write:AVERAGE \
        LINE2:disk_oct_read#FF0000 \
        LINE2:disk_oct_write#00FF00 $1 

    rrdtool graph $OUTPUT_DIR/if_errors_vnet0.png -w 800 -h 800 \
        DEF:if_errors-RX=$INPUT_DIR/if_errors-vnet0.rrd:rx:AVERAGE \
        DEF:if_errors-TX=$INPUT_DIR/if_errors-vnet0.rrd:tx:AVERAGE \
        LINE2:if_errors-RX#FF0000 \
        LINE2:if_errors-TX#00FF00 $1 

    rrdtool graph $OUTPUT_DIR/if_dropped_vnet0.png -w 800 -h 800 \
        DEF:if_dropped-RX=$INPUT_DIR/if_dropped-vnet0.rrd:rx:AVERAGE \
        DEF:if_dropped-TX=$INPUT_DIR/if_dropped-vnet0.rrd:tx:AVERAGE \
        LINE2:if_dropped-RX#FF0000 \
        LINE2:if_dropped-TX#00FF00 $1 

    rrdtool graph $OUTPUT_DIR/if_octets_vnet0.png -w 800 -h 800 \
        DEF:if_octets-RX=$INPUT_DIR/if_octets-vnet0.rrd:rx:AVERAGE \
        DEF:if_octets-TX=$INPUT_DIR/if_octets-vnet0.rrd:tx:AVERAGE \
        LINE2:if_octets-RX#FF0000 \
        LINE2:if_octets-TX#00FF00 $1 

    rrdtool graph $OUTPUT_DIR/if_packets_vnet0.png -w 800 -h 800 \
        DEF:if_packets-RX=$INPUT_DIR/if_packets-vnet0.rrd:rx:AVERAGE \
        DEF:if_packets-TX=$INPUT_DIR/if_packets-vnet0.rrd:tx:AVERAGE \
        LINE2:if_packets-RX#FF0000 \
        LINE2:if_packets-TX#00FF00 $1 

    rrdtool graph $OUTPUT_DIR/virt_cpu_total.png -w 800 -h 800 \
        DEF:cpu_ns=$INPUT_DIR/virt_cpu_total.rrd:ns:AVERAGE \
        LINE2:cpu_ns#FF0000 $1 

}

if [ -z != $START_TIME ] && [ -z != $END_TIME ]; then
    params="--start $START_TIME --end $END_TIME"
    graph "$params"
else
    graph
fi
