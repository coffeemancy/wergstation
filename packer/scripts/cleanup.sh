#!/bin/bash -x

set -e

# cleanup apt cruft
sudo apt-get autoremove -y
sudo apt-get clean
sudo apt-get autoclean
