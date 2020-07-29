#!/bin/sh

echo "First port used for proxy? Example 10000 "
read FIRST_PORT
echo "How many proxy do you want to create? Example 500"
read COUNT


IP4=$(curl -4 -s icanhazip.com)
IP6=$(curl -6 -s icanhazip.com | cut -f1-4 -d':')
IFACE=$(ip route get 8.8.8.8 | sed -nr 's/.*dev ([^\ ]+).*/\1/p')
LAST_PORT=$(($FIRST_PORT + $COUNT))
WORKDIR="/usr/local/3proxy"
WORKDATA="data.txt"


array=(1 2 3 4 5 6 7 8 9 0 a b c d e f)

gen64() {
        ip64() {
                echo "${array[$RANDOM % 16]}${array[$RANDOM % 16]}${array[$RANDOM % 16]}${array[$RANDOM % 16]}"
        }
        echo "$1:$(ip64):$(ip64):$(ip64):$(ip64)"
}


gen_data() {
    seq $FIRST_PORT $LAST_PORT | while read port; do
        echo "$IP4/$port/$(gen64 $IP6)/$IFACE"
    done
}

gen_iptables() {
    cat <<EOF
$(awk -F "/" '{print "iptables -I INPUT -p tcp --dport " $2 "  -m state --state NEW -j ACCEPT"}' ${WORKDATA})
EOF
}

gen_ifconfig() {
    cat <<EOF
$(awk -F "/" '{print "ifconfig " $4 " inet6 add " $3 "/64"}' ${WORKDATA})
EOF
}

get_config() {
        cat <<EOF
$(awk -F "/" '{print "proxy -n -6 -a -p" $2 " -e" $3}' ${WORKDATA})
EOF
}


cat >>/etc/rc.local <<EOF
bash ${WORKDIR}/boot_iptables.sh
bash ${WORKDIR}/boot_ifconfig.sh
ulimit -n 10048
service 3proxy start
EOF
echo "Generate raw file "
gen_data >data.txt
echo "Generate iptables file "
gen_iptables >$WORKDIR/boot_iptables.sh
echo "Generate ifconfig data "
gen_ifconfig >$WORKDIR/boot_ifconfig.sh
echo "Generate config file"
get_config >config.cfg
chmod +x $WORKDIR/boot_*.sh /etc/rc.local
echo "adding ipv6 to interface"
bash /etc/rc.local