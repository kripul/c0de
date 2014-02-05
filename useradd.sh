#!/bin/bash
# created by ipoelhuda
# visit http://ipoelhuda.com/

if [ $(id -u) -eq 0 ]; then
	read -p "Masukkan username : " username
	read -p "Masukkan password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username sudah ada!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		usermod -s /bin/false $username
		usermod -g jual $username
		[ $? -eq 0 ] && echo "User berhasil ditambahkan ke system!" || echo "Gagal menambahkan user!"
	fi
else
	echo "Hanya root yang boleh menambahkan user"
	exit 2
fi
