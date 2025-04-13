#!/bin/bash

echo "Stopping eNodeB and UE processes..."

# Kill srsenb in eNodeB container and confirm
docker exec integrated-enodeb1 bash -c "pkill -9 srsenb; sleep 2; echo 'Processes after pkill:'; ps -ef"

# Kill srsue in UE container and confirm
docker exec integrated-ue1 bash -c "pkill -9 srsue; sleep 2; echo 'Processes after pkill:'; ps -ef"

echo "Process check completed."
