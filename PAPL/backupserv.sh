#!/bin/bash

#il faut au préalable créer un tunnel ssh par échange de clé donc sans avoir à taper le  #mot de passe en clair dans le script, afin de pouvoir automatiser le script de façon sécurisé car en tls c'est impossbile; Il faut donc créer une clé publique sur le client, l'envoyer sur le server dans les clés authorisées, désactiver l'auth avec mdp et activer l'auth pub key dans sshd #config.

date=$(date '+%d-%m-%Y-%H-%M')
tar cvpzf /home/flo1/backup_$date.tar.gz /home/

sftp flo2@192.168.182.139 <<EOF 
put /home/flo1/backup_$(date '+%d-%m-%Y-%H-%M').tar.gz
exit
EOF

rm -r /home/flo1/backup_$(date '+%d-%m-%Y-%H-%M').tar.gz


