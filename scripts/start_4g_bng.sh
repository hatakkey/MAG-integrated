#!/bin/bash

docker exec -d  integrated-enodeb1 bin/bash -c "/bin/srsenb enb.conf > /opt/open5gs/var/log/open5gs/enb1.log"
docker exec -d  integrated-ue1 bin/bash -c "/bin/srsue ue.conf > /opt/open5gs/var/log/open5gs/ue1.log"
# Wait for the tun_srsue interface to be ready
docker exec -it  integrated-ue1 /bin/bash -c '
while ! ip link show tun_srsue > /dev/null 2>&1; do
    echo "Waiting for tun_srsue to be ready..."
    sleep 1
done
ip route add 1.1.1.0/24 dev tun_srsue
echo "IP route added successfully."
'


