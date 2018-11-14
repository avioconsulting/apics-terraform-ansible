#!/bin/bash
# This is used when creating an amazon instance, as no swap was previously defined.
sudo dd if=/dev/zero of=/swapfile bs=1M count=768
sudo mkswap /swapfile
sudo chown root:root /swapfile
sudo chmod 600 /swapfile
sudo swapon /swapfile
