#!/bin/bash
#echo "Pilih mau konek ke server yang mana bos? "
echo ""
echo "server 1"
echo "server 2"
echo "server 3"
echo "server 4"

read -p "Pilih mau konek ke server yang mana bos? " option
case $option in
	1)
	ssh root@local.com
	;;
	2)
	ssh kripul@hostname.com
	;;
	3)
	ssh root@hostname.co
	;;
	4)
	ssh kripul@hostname.com
	;;
	*) 
	echo "lu pencet nomer berapa bos?"
	;;
esac
