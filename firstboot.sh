#!/bin/bash

# Function to check the Linux Distribution
get_distribution() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo $ID
    elif [ -f /etc/redhat-release ]; then
        echo "rhel"
    elif [ -f /etc/lsb-release ]; then
        echo "ubuntu"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    else
        echo "Unsupported distribution!"
        exit 1
    fi
}

# Function to update & install packages
update_and_install_packages() {
    distribution=$(get_distribution)
    case "$distribution" in
        "debian" | "ubuntu" | "linuxmint")
            sudo apt-get update
            sudo apt-get -y upgrade
            sudo apt-get -y install vim curl wget git
            ;;
        "centos" | "rhel" | "fedora")
            sudo yum update -y
            sudo yum install -y vim curl wget git
            ;;
        "arch")
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm vim curl wget git
            ;;
        *)
            echo "Unsupported distribution!"
            exit 1
            ;;
    esac
}

# Main execution
update_and_install_packages
