#!/bin/bash

echo "Stopping eNodeB and UE processes..."

docker exec -it integrated-enodeb1 bash -c "pkill srsenb; sleep 5; ps -ef"
docker exec -it integrated-ue1 bash -c "pkill srsue; sleep 5; ps -ef"

echo "Process check completed."

