#!/bin/bash

# List of hosts with their respective details (host, local directory)
hosts=(
    "integrated-MAG1:/root/MAG-integrated/cliscripts//MAG1"
    "integrated-MAG2:/root/MAG-integrated/cliscripts/MAG2"
    "integrated-TRA-integrated:/root/MAG-integrated/cliscripts/TRA-integrated"
)

USER="admin"
PASS="admin"

# Loop over each host's details
for host_info in "${hosts[@]}"; do
    # Extract host and local directory from the list
    HOST=$(echo "$host_info" | cut -d':' -f1)
    LOCAL_DIR=$(echo "$host_info" | cut -d':' -f2)

    REMOTE_DIR="scripts-md"  # Always use scripts-md as the remote directory

    # Wait until the VM is reachable (adjust timeout and retries if needed)
    until ping -c1 "$HOST" &>/dev/null; do
        echo "Waiting for $HOST to become reachable..."
        sleep 2
    done

    echo "$HOST is up, starting SFTP upload..."

    # Use lftp for scripting SFTP with password
    lftp -u "$USER","$PASS" sftp://$HOST <<EOF
cd cf1:/  
mkdir -p $REMOTE_DIR  
cd $REMOTE_DIR  
mput $LOCAL_DIR/*  
bye
EOF

    echo "Upload complete for $HOST."
done

