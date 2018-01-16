#/bin/bash
#===============================================================
# Configuration
CONFIG_PATH="/home/storj/.config/storjshare/configs"
CMD_START="storjshare start --config"
#===============================================================

storj_configs="${CONFIG_PATH}/*"

for conf_file in ${storj_configs}
do
        echo "STORJ node ($conf_file) : starting..."
        $CMD_START $conf_file
done

