#!/bin/bash
# Throws errors when run from Sempahore. Switch to ansible playbook
#rsync -rtEvv --dry-run --delete --exclude=".*/" /media/ext_storage/backups/ /mnt/nas_replicate_out/vector/backups_sync &> /tmp/rsync-backup-$(date +%Y-%m-%d_%H-%M-%S.txt)