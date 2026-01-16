#!/bin/bash

#insert generalization script
sudo tee ~/generalize.sh > /dev/null << 'EOF'
#!/bin/bash

# Generalize
sudo rm -f /etc/machine-id
sudo systemd-machine-id-setup
sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id
sudo rm /etc/ssh/ssh_host_*
sudo ssh-keygen -A
sudo systemctl restart sshd
sudo echo "Generalized on $(date)" | sudo tee -a /var/log/generalize_log.txt > /dev/null

# remove cron job
sudo sed -i '\@reboot root /home/ubuntu/generalize.sh@d' /etc/crontab

# remove script
sudo rm -f /home/ubuntu/generalize.sh

sudo reboot

EOF

# insert change hostname name script
sudo tee /etc/profile.d/changeHostname.sh > /dev/null << 'EOF'

if [ $(hostname) -eq "ubuntu-server" ]; then

    echo "The Current Hostname is: $(hostname)"
    read -p "Please Enter a new hostname: " new_hostname
    sudo hostnamectl set-hostname "$new_hostname"
    echo "Hostname Updated to $new_hostname"
    sudo rm -f /etc/profile.d/changeHostname.sh

fi
EOF

#update kernel to support for ASR
echo y | sudo apt install linux-image-5.15.0-121-generic
echo y | sudo apt install linux-headers-5.15.0-121-generic
sudo sed -i '/GRUB_DEFAULT=0/c\GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 5.15.0-121-generic"' /etc/default/grub
sudo bash -c 'update-grub'

#update image
sudo apt update

# change execution parameters
sudo chmod +x ~/generalize.sh
sudo chmod +x /etc/profile.d/changeHostname.sh

# require password on first boot
sudo passwd -e ubuntu

# create cron job
sudo bash -c 'echo "@reboot root /home/ubuntu/generalize.sh" >> /etc/crontab'