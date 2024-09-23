# Loop doesn't work with Ansible Semaphore because it will only capture the output after it's done by default. Might be a way to get it "live" but easier to just loop in Semaphore
# while true
# do
  AMOUNT=""
  AMOUNT_TRANSFERED=$(du -h --max-depth=1 /share/single_disk_root/archive/ | grep /share/single_disk_root/archive/$ | sed 's/G.*//')
  TOTAL=472 # Amount of source at the time. Doesn't change while transfer is happening to don't bother to have it autocalculated live, especially since it adds extra load onto the disk while transfer is happening a takes quite a while to calculate
  awk -v amount=$AMOUNT_TRANSFERED -v total=$TOTAL -v date="$(date)" 'BEGIN { print  ( date " = " amount / total * 100 "%" ) }'
#   sleep 300
# done