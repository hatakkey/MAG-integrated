#!/bin/bash

# Detect OS (CentOS, RHEL, Fedora, Ubuntu, Debian, etc.)
function detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_ID=${ID,,}  # lowercase
    else
        echo "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
}

# Main logic
function run_os_specific_script() {
    detect_os

    case "$OS_ID" in
        centos|rhel|fedora)
            SCRIPT="./create_bridges-centos.sh"
            ;;
        ubuntu|debian)
            SCRIPT="./create_bridges-ubuntu.sh"
            ;;
        *)
            echo "Unsupported OS: $OS_ID"
            exit 2
            ;;
    esac

    if [ ! -x "$SCRIPT" ]; then
        echo "Script $SCRIPT not found or not executable."
        exit 3
    fi

    echo "Running $SCRIPT..."
    exec "$SCRIPT"
}

run_os_specific_script
