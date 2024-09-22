# If all infra needs to be shutdown, for example if there is power outage or other maintenance happening in the server room
#   then the NAS may not be up when this server boots up. Thus the monitoring script can be used to attempt to re-mount the shared.
#   Tested by using sudo unmount -l /mnt/ReplicateOut_master_control/ and then running this script. It reconnected the share as expected.
#   Have not tested the failure scenario where NAS is offline when this run, for example.
MONITORING_FILE=/mnt/nas_replicate_out/monitoring/up.txt
echo $(date '+%Y-%m-%d %H:%M:%S') Network share check > $MONITORING_FILE

if [ $? -eq 0 ]; then
    echo $(date '+%Y-%m-%d %H:%M:%S') Network share OK
    curl "https://uptime-kuma.ournetwork.ca/api/push/yISAMDTRaC?status=up&msg=OK&ping="
else
    echo $(date '+%Y-%m-%d %H:%M:%S') Network share FAILED
    echo $(date '+%Y-%m-%d %H:%M:%S') Attempting to mount...
    sudo mount -a
    echo $(date '+%Y-%m-%d %H:%M:%S') Network share check after re-mount > $MONITORING_FILE
    if [ $? -eq 0 ]; then
        echo $(date '+%Y-%m-%d %H:%M:%S') Network share mounted OK
        curl "https://uptime-kuma.ournetwork.ca/api/push/yISAMDTRaC?status=up&msg=OK&ping="
    else
        echo $(date '+%Y-%m-%d %H:%M:%S') Network mount FAILED
        curl "https://uptime-kuma.ournetwork.ca/api/push/yISAMDTRaC?status=down&msg=Mount_failed&ping="
    fi
fi 