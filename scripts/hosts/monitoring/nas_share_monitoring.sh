touch /mnt/ReplicateOut_master_control/monitoring/up.txt;
if [ $? -eq 0 ]; then
    echo OK
    curl "http://vector.ournetwork.ca:3001/api/push/yISAMDTRaC?status=up&msg=OK&ping="
else
    echo FAIL
fi