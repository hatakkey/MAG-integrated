#!/bin/bash

docker exec -it integrated-bngblaster bash -c "bngblaster -I -C pppoe-notraffic.json -L pppoe.log -c 10"
