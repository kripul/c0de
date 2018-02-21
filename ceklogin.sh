#!/bin/bash
# author: Ipoel Huda
# Copyright 2014 (c) esteh.info
# Nyontek script dari agan Mikodemos

echo ' '
echo ' '
echo "               Dropbear Users Login Monitor "
echo "---------------------------------------------------------------"
echo "  Date-time    |  PID      |  User Name      |  From Host " 
echo "---------------------------------------------------------------" 

logdebian=/var/log/auth.log
logcentos=/var/log/secure
loginsukses='auth succeeded'


#buat centos
if [ -s /etc/redhat-release ]; then
pids=`pgrep dropbear`
		for pid in $pids 
		do
		#waktu login
		pidlogs=`cat $logcentos | grep "$pid" |grep "$loginsukses" |awk '{print $3}'`;
		i=0
		for pidend in $pidlogs
		do
    let i=i+1
    done   
    if [ $pidend ];then
       login=`cat "$logcentos" |grep "$pidend" |grep "$loginsukses" | grep "$pid"`
       PID=$pid
       user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`;
       waktu=`echo $login |awk -F" " '{print $2,$3}'`;
	   fromip=`echo $login |awk -F" " '{print $12}' | awk -F":" '{print $1}'`;
       while [ ${#waktu} -lt 13 ]
       do
           waktu=$waktu" " 
       done

       while [ ${#user} -lt 16 ]
       do
           user=$user" " 
       done
       while [ ${#PID} -lt 8 ]
       do
           PID=$PID" " 
       done

       
       echo "  $waktu|  $PID | $user|  $fromip "
    fi
done

#buat debian
else if [ -s /etc/debian_version ]; then
pids=`pgrep dropbear`
		for pid in $pids 
		do
		#waktu login
		pidlogs=`cat $logdebian | grep "$pid" |grep "$loginsukses" |awk '{print $3}'`;
		i=0
		for pidend in $pidlogs
		do
    let i=i+1
    done   
    if [ $pidend ];then
       login=`cat "$logdebian" |grep "$pidend" |grep "$loginsukses" | grep "$pid"`
       PID=$pid
       user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`;
       waktu=`echo $login |awk -F" " '{print $2,$3}'`;
	   fromip=`echo $login |awk -F" " '{print $12}' | awk -F":" '{print $1}'`;
       while [ ${#waktu} -lt 13 ]
       do
           waktu=$waktu" " 
       done

       while [ ${#user} -lt 16 ]
       do
           user=$user" " 
       done
       while [ ${#PID} -lt 8 ]
       do
           PID=$PID" " 
       done

       
       echo "  $waktu|  $PID | $user|  $fromip "
    fi
done
fi
fi

echo "---------------------------------------------------------------" 
echo "                        Scrypt Asli @ Mikodemos   " 
exit 0
