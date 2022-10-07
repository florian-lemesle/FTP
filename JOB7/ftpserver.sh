#!/bin/bash

apt update && apt upgrade
apt install vsftpd 
systemctl restart vsftpd
apt install openssh-server
systemctl enable ssh

cat >>/etc/ssh/sshd_config<<EOF 
AllowGroups sftp
Match group sftp
X11Forwarding no
AllowTcpForwarding no
ForceCommand internal-sftp
EOF

cat >>/etc/vsftpd.conf<<EOF 
write_enable=YES
local_umask=022
EOF

systemctl restart ssh
addgroup sftp

useradd -m Merry
echo Merry:kalimac | chpasswd
usermod -G sftp Merry
chmod 700 /home/Merry/

useradd -m Pippin
echo Pippin:secondbreakfast | chpasswd
usermod -G sftp Pippin
chmod 700 /home/Pippin/




