#/bin/bash
#===============================================================
# Configuration
CONFIG_PATH="/home/storj/.config/storjshare/configs"
CMD_START="storjshare stop -i"
#===============================================================

storj_configs="${CONFIG_PATH}/*"

for conf_file in ${storj_configs}
do
	node_filename=$(basename $conf_file)
	node_name=${node_filename%%.*}
        echo "STORJ node ($node_name) : stopping..."
        $CMD_START ${node_name}
done

