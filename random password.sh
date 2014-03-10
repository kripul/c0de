#!/bin/bash
# Created by Ipoel Huda
# Random password user.

#buat pass secara random
passrandom=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

read -p "Masukkan username : " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
# proses mengganti passwordnya
echo -e "$passrandom\n$passrandom" | passwd $username
echo "Password untuk user $username : $passrandom" 
else
echo "Username tidak ditemukan"
	exit 2
fi
