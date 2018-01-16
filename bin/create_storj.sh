#!/bin/bash

CONFIG_FILE=${0%.*}.conf
if [ -f $CONFIG_FILE ]; then
	echo "CONFIG : $CONFIG_FILE"
else
	echo "Could not find $CONFIG_FILE."
	exit 1
fi

source $CONFIG_FILE

iteration=1
while : ;
do
if [ $iteration -gt ${NODE_CNT} ]; then
	break;
fi
storjshare create --storj ${ETH_CONTRACT} \
			   --storage ${PARENT_DIR}/node${iteration} --size ${SIZE_PER_NODE} \
			   --rpcport ${PORT} --rpcaddress ${ADDRESS} \
			   --noedit
let iteration++
let PORT++
done
