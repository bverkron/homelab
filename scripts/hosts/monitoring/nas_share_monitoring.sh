echo echo $(date '+%Y-%m-%d %H:%M:%S') Network share check > /mnt/ReplicateOut_master_control/monitoring/up.txt

if [ $? -eq 0 ]; then
    echo $(date '+%Y-%m-%d %H:%M:%S') Network share OK
    curl "https://uptime-kuma.ournetwork.ca/api/push/yISAMDTRaC?status=up&msg=OK&ping="
else
    echo $(date '+%Y-%m-%d %H:%M:%S') Network share FAILED
fi