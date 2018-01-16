#!/bin/bash

if [ $# -ne 4 ]; then
	echo "Usage : $0 <Address> <Port> <Directory> <Size>"
	exit 1
fi

storjshare create \
  --storj 0x70262975F5f40f82D1098177eAf80db03D38b7B1 \
  --storage /home/storj/node3 --size 2GB \
  --rpcport "4030" --rpcaddress "sunyzero9.iptime.org" \
  --tunnelportmin 0 --tunnelportmax 0 

