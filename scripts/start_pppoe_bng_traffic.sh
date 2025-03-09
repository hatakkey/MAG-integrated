#!/bin/bash

docker exec -it integrated-bngblaster bash -c "bngblaster -I -C pppoe-bngnoncups.json -L pppoe.log -c 1"
