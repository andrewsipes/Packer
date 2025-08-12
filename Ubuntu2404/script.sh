#!/bin/bash

#update image
sudo apt update

#insert generalization script
sudo tee ~/generalize.sh > /dev/null << 'EOF'
#!/bin/bash

# COUNTER="/home/ubuntu/counter.txt"
# REBOOTS=0

# Create counter file if not exists
# if [ ! -e "$COUNTER" ]; then
#     echo 0 > /home/ubuntu/counter.txt
# fi

# Set Count variable
# count=$(cat "$COUNTER")

# Generalize
sudo rm -f /etc/machine-id
sudo systemd-machine-id-setup
sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id
sudo rm /etc/ssh/ssh_host_*
sudo ssh-keygen -A
sudo systemctl restart sshd
sudo echo "Generalized on $(date)" | sudo tee -a /var/log/generalize_log.txt > /dev/null

# If count is less than target, increment and exit
# if [ "$count" -lt "$REBOOTS" ]; then
#     count=$((count + 1))
#     echo "$count" > "$COUNTER"
#     exit 0
# fi

# remove cron job
sudo sed -i '\@reboot root /home/ubuntu/generalize.sh@d' /etc/crontab

sudo rm -f /home/ubuntu/generalize.sh
sudo rm -f /home/ubuntu/counter.txt

sudo dhclient -r
sudo dhclient

EOF

# change execution parameters
sudo chmod +x ~/generalize.sh

# require password on first boot
sudo passwd -e ubuntu

# create cron job
sudo bash -c 'echo "@reboot root /home/ubuntu/generalize.sh" >> /etc/crontab'