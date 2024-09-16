#!/bin/bash
SOURCE_DIR="$HOME/test"
BACKUP_DIR="$HOME/backups"
DATE=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +30 -exec rm {} \;
if [ $? -eq 0 ]
then
    echo "Backup created successfully: $BACKUP_FILE"
else
     echo "Backup unsuccessful"
fi