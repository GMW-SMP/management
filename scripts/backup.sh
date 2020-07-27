#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME=gmw-backup-$DATE.tar.gz
MC_DIR=$(yq r config.yaml server-directory)
BACKUP_TYPE=$1
RETENTION_DAYS=$2

echo "Creating backup directory."
mkdir -p $MC_DIR/../backups/$BACKUP_TYPE

echo "Creating server archive."
cd $MC_DIR/
tar -czvf $MC_DIR/../backups/$BACKUP_TYPE/$FILENAME logs worlds whitelist.json banned-ips.json banned-players.json

# TODO add logging support back
echo "Purging backups over $RETENTION_DAYS days old."
find $MC_DIR/../backups/ -type f -name 'gmw-backup-*.tar.gz' -mtime +$RETENTION_DAYS -print -exec rm -f {} \; #>> $LOG_FILE
echo "Purging server logs since they are stored in the current backup."
find $MC_DIR/logs -type f -name '*.log.gz' -print -exec rm -f {} \; #>> $LOG_FILE
