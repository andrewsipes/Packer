#!/bin/bash
sudo apt update
sudo ufw enable
sudo ufw allow 22, 80, 443/tcp
echo y |sudo apt install apache2
sudo passwd -e ubuntu