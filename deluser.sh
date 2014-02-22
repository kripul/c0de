#!/bin/bash
# created by ipoelhuda
# visit http://ipoelhuda.com/

if [ $(id -u) -eq 0 ]; then
read -p "Masukkan username yang ingin dihapus : " username
userdel -r $username
groupdel $username

else
echo "Hanya root yang boleh menghapus user"
exit 2
fi
