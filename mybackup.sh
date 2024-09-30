#!/bin/bash

SOURCE_DIR="/home/khushi/test"             # Directory to back up on Server A
DEST_DIR="/home/khushi_user/backupsss"     # Backup location on Server B
MONTHLY_BACKUP_DIR="$DEST_DIR/monthly"
WEEKLY_BACKUP_DIR="$DEST_DIR/weekly"
DAILY_BACKUP_DIR="$DEST_DIR/daily"
CURRENT_DATE=$(date +'%Y-%m-%d')
CURRENT_MONTH=$(date +'%Y-%m')
DAY_OF_MONTH=$(date +'%d')
BACKUP_NAME="backup-$CURRENT_DATE.tar.gz"

ssh khushi_user@192.168.1.8 "mkdir -p $DAILY_BACKUP_DIR; mkdir -p $WEEKLY_BACKUP_DIR; mkdir -p $MONTHLY_BACKUP_DIR"

tar -czf - "$SOURCE_DIR" | ssh khushi_user@192.168.1.8 "cat > $DAILY_BACKUP_DIR/$BACKUP_NAME"

ssh khushi_user@192.168.1.8 "find $DAILY_BACKUP_DIR -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;"

tar -czf - "$SOURCE_DIR" | ssh khushi_user@192.168.1.8 "cat > $WEEKLY_BACKUP_DIR/$BACKUP_NAME"

ssh khushi_user@192.168.1.8 "find $WEEKLY_BACKUP_DIR -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;"

if [ "$DAY_OF_MONTH" -eq 01 ]
then
    ssh khushi_user@192.168.1.8 "tar -czf $MONTHLY_BACKUP_DIR/$CURRENT_MONTH.tar.gz -C $DAILY_BACKUP_DIR ."
    ssh khushi_user@192.168.1.8 "find $MONTHLY_BACKUP_DIR -maxdepth 1 -type f -mtime +365 -exec rm -f {} \;"
fi

if [ -n "$1" ]
then
    MONTH=$1
    ls "$MONTHLY_BACKUP_DIR" | grep "$MONTH"
fi

if [ $? -eq 0 ]
then
    echo "Backup created successfully: $BACKUP_NAME"
else
     echo "Backup unsuccessful"
fi