#!/bin/bash -x

set -e

# update and upgrade
sudo apt-get update -y -qq > /dev/null
sudo apt-get dist-upgrade -y -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null

# install needed packages
sudo apt-get install -y -qq curl wget git openssh-server build-essential \
libssl-dev libreadline-dev zlib1g-dev dkms
