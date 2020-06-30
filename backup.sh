#!/bin/bash

FILENAME=gmw-backup-$(date +"%Y-%m-%d_%H-%M-%S").tar.gz
LOG_FILE=/home/mc/scripts/logs/backups-$(date +"%Y-%m-%d").log
MC_DIR=/home/mc/server
BACKUP_DIR=/home/mc/backups

echo "Creating backup directories."
mkdir -p $LOG_FILE/..
mkdir -p $BACKUP_DIR
touch $LOG_FILE

echo "Creating server archive."
cd $MC_DIR
tar czf $BACKUP_DIR/$FILENAME logs plugins worlds bukkit.yml bukkit.yml paper.yml spigot.yml whitelist.json server.properties banned-ips.json banned-players.json >> $LOG_FILE

echo "Purging backups over 30 days old."
find $BACKUP_DIR -type f -name 'gmw-backup-*.tar.gz' -mtime +29 -print -exec rm {} \; >> $LOG_FILE
echo "Purging server logs since they are stored in the current backup."
find $MC_DIR/logs -type f -name '*.log.gz' -print -exec rm {} \; >> $LOG_FILE
