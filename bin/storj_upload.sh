#!/bin/bash

if [ $# -ne 1 ]; then
    echo "$0 <YYYY-MM>"
    exit 1
fi

LOG_DIR=${HOME}/.config/storjshare/logs/
#LOG_DIR=/var/log/storj/

SPECIFY_YYYYMM=$1

#cat $LOG_DIR/*.log | fgrep "$SPECIFY_YYYYMM"
cat $LOG_DIR/*.log | fgrep "$SPECIFY_YYYYMM" | awk 'BEGIN {FS="[\" ]"} /Mirror download completed/ {kk += $14} /Shard download completed/ {sd += $14} /Shard upload completed/ {su += $14} END {print "Mirrors downloads: " kk; print "Shards downloads: " sd; print "Shards uploads: " su}'
