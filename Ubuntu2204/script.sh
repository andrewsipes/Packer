#!/bin/bash

#update image
sudo apt update

#insert generalization script
sudo tee ~/generalize.sh > /dev/null << 'EOF'
#!/bin/bash
sudo rm -f /etc/machine-id
sudo systemd-machine-id-setup
sudo ln -sf /etc/machine-id /var/lib/dbus/machine-id
sudo rm /etc/ssh/ssh_host_*
sudo ssh-keygen -A
sudo systemctl restart sshd
echo "Generalized on $(date)" >> /var/log/generalize_log.txt
EOF

#change execution parameters
sudo chmod +x ~/generalize.sh

#create cron job
sudo su
echo "@reboot root ~/generalize.sh" | sudo tee -a /etc/crontab

#require password on first boot
sudo passwd -e ubuntu
