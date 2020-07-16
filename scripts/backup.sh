#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME=gmw-backup-$DATE.tar.gz
PROJ_BASE_DIR=$(yq r config.yaml server-directory)
BACKUP_TYPE=$1
RETENTION_DAYS=$2

echo "Creating backup directory."
mkdir -p $PROJ_BASE_DIR/backups/$BACKUP_TYPE

echo "Creating server archive."
cd $PROJ_BASE_DIR/
tar -czvf $PROJ_BASE_DIR/../backups/$BACKUP_TYPE/$FILENAME logs worlds whitelist.json banned-ips.json banned-players.json

echo "Purging backups over 30 days old."
find $BACKUP_DIR -type f -name 'gmw-backup-*.tar.gz' -mtime +$RETENTION_DAYS -print -exec rm {} \; >> $LOG_FILE
echo "Purging server logs since they are stored in the current backup."
find $MC_DIR/logs -type f -name '*.log.gz' -print -exec rm {} \; >> $LOG_FILE
