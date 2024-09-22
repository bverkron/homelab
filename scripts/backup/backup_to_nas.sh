#!/bin/bash
# screen -S background -d -L -Logfile "/tmp/rsync-$(date +%Y-%m-%d_%H-%M-%S.txt)" -m rsync -rtERvv --dryrun --delete --exclude=".*/" /media/ext_storage/backups/ /mnt/nas_replicate_out/vector/backups/
rsync -rtERvv --dry-run --delete --exclude=".*/" /media/ext_storage/backups/ /mnt/nas_replicate_out/vector/backups/ &> /tmp/rsync-backup-$(date +%Y-%m-%d_%H-%M-%S.txt)