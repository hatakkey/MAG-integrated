#!/bin/bash

## clear log files
for filename in ../logs/*.log; do
    > "$filename"
done

docker exec -d  integrated-mme open5gs-mmed
docker exec -d  integrated-hss open5gs-hssd
docker exec -d  integrated-pcrf open5gs-pcrfd

