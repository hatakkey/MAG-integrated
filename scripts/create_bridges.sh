#!/bin/bash

# Detect OS
function detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_ID=${ID,,}
        echo "Detected OS: $OS_ID"
    else
        echo "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
}

# Create bridge if it doesn't exist
function create_bridges() {
    BRIDGES=("br-s1ap" "br-gtpc" "br-gtpu" "br-diam" "br-enb")

    for br in "${BRIDGES[@]}"; do
        if ! ip link show "$br" &>/dev/null; then
            echo "Creating bridge: $br"
            ip link add "$br" type bridge
        else
            echo "Bridge $br already exists. Skipping."
        fi
        ip link set "$br" up
    done
}

# CentOS/Fedora firewalld config
function configure_firewalld() {
    echo "Configuring firewalld..."
    for br in "${BRIDGES[@]}"; do
        firewall-cmd --permanent --zone=docker --add-interface="$br"
    done
    firewall-cmd --reload
}

# Ubuntu/Debian iptables config
function configure_iptables() {
    echo "Configuring iptables rules for bridges..."
    for br in "${BRIDGES[@]}"; do
        iptables -C DOCKER-USER -i "$br" -j ACCEPT 2>/dev/null || iptables -I DOCKER-USER -i "$br"
 -j ACCEPT
    done
    iptables-save > /etc/iptables/rules.v4
}

# Main
function main() {
    detect_os
    create_bridges

    case "$OS_ID" in
        centos|rhel|fedora)
            configure_firewalld
            ;;
        ubuntu|debian)
            configure_iptables
            ;;
        *)
            echo "Unsupported OS: $OS_ID"
            exit 2
            ;;
    esac

    echo "All bridges configured successfully for $OS_ID."
}

main

