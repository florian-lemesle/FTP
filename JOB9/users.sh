#!/bin/bash

userlist=$(cat /home/flo/userlist.csv|awk 'NR>1'| awk 'BEGIN{ FS=" *,"; OFS="," } {$1=$1; print $0}')


for line in $userlist; do
    

    Id=$(echo $line | cut -d ',' -f 1)
    Prenom=$(echo $line | cut -d ',' -f 2)
    Nom=$(echo $line | cut -d ',' -f 3)
    Mdp=$(echo $line | cut -d ',' -f 4)
    Role=$(echo $line | cut -d ',' -f 5)
    
    Username=$Prenom-$Nom
    addgroup sftp
    
    
    if [ $Role = Admin ]
    then
    
              useradd -m $Username
         echo $Username:$Mdp | sudo chpasswd
              usermod -G sudo $Username
              usermod -G sftp $Username
         chmod 700 /home/$Username/
         touch /etc/vsftpd.chroot_list
         cat >>/etc/vsftpd.chroot_list<<EOF 
         $Username
EOF

    
    else
    
              useradd -m $Username
         echo $Username:$Mdp | sudo chpasswd
              usermod -G sftp $Username
         chmod 700 /home/$Username/
   
    fi
     
done 


touch /etc/vsftp.user_list
cat >>/etc/vsftp.user_list<<EOF 
$Username
EOF

cat >>/etc/vsftpd.conf<<EOF 
userlist_enable=YES
userlist_file=/etc/vsftp.user_list
userlist_deny=NO
allowed_writeable_chroot=YES
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
EOF










