#!/bin/bash
echo "enter server address"
read server_addr

ssh root@$server_addr /bin/bash << EOF

  sudo dd if=/dev/zero of=/swapfile bs=1M count=2000
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  sudo swapon -s

  adduser deployer
  gpasswd -a deployer sudo

  sudo echo "deployer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

  su deployer

  mkdir ~/.ssh
  chmod 700 ~/.ssh
  touch ~/.ssh/authorized_keys
EOF

cat ~/.ssh/id_rsa.pub | ssh root@$server_addr "cat - >> /home/deployer/.ssh/authorized_keys"

ssh root@$server_addr /bin/bash << EOF
  su deployer
  chmod 600 ~/.ssh/authorized_keys
EOF