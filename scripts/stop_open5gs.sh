#!/bin/bash

echo "Stopping Open5GS services and verifying processes..."

docker exec -it integrated-mme bash -c "killall open5gs-mmed; sleep 5; ps -ef"
docker exec -it integrated-hss bash -c "killall open5gs-hssd; sleep 5; ps -ef"
docker exec -it integrated-pcrf bash -c "killall open5gs-pcrfd; sleep 5; ps -ef"

echo "Process check completed."

