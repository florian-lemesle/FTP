#!/bin/bash

apt-get --purge autoremove vsftpd 
apt-get --purge autoremove openssh-server

groupdel sftp

userdel Merry
rm -r /home/Merry

userdel Pippin
rm -r /home/Pippin

