#!/bin/bash

docker exec -it integrated-bngblaster bash -c "bngblaster -I -C dhcp-bng.json -L dhcp.log -c 10 "
