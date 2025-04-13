#!/bin/bash

docker exec -it integrated-bngblaster bash -c "bngblaster -I -C pppoe-bng.json -L pppoe.log -c 10"
