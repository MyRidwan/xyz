#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Ridwan Project
# (C) Copyright 2023
# =========================================
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
export Server_URL="raw.githubusercontent.com/myridwan/xyz/ipuk"
clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(wget -qO- ipv4.icanhazip.com);
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cek=$( curl -sS https://raw.githubusercontent.com/MyRidwan/izinvps/ipuk/ip | awk '{print $2}'  | grep $MYIP )
Name=$(curl -sS https://raw.githubusercontent.com/MyRidwan/izinvps/ipuk/ip | grep $MYIP | awk '{print $4}')
if [[ $cek = $MYIP ]]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo ""
echo -e "Your IP is ${red}NOT REGISTER${NC} @ ${red}EXPIRED${NC}"
echo ""
echo -e "Please Contact ${green}Admin${NC}"
echo -e "Telegram : t.me/JsPhantom"
exit 0
fi
clear

BURIQ() {
    curl -sS https://raw.githubusercontent.com/MyRidwan/izinvps/ipuk/ip >/root/tmp
    data=($(cat /root/tmp | grep -E "^### " | awk '{print $4}'))
    for user in "${data[@]}"; do
        exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
        d1=($(date -d "$exp" +%s))
        d2=($(date -d "$biji" +%s))
        exp2=$(((d1 - d2) / 86400))
        if [[ "$exp2" -le "0" ]]; then
            echo $user >/etc/.$user.ini
        else
            rm -f /etc/.$user.ini >/dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(wget -qO- ipv4.icanhazip.com);
Name=$(curl -sS https://raw.githubusercontent.com/MyRidwan/izinvps/ipuk/ip | grep $MYIP | awk '{print $4}')
echo $Name >/usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman() {
    if [[ -f "/etc/.$Name.ini" ]]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [[ "$CekOne" = "$CekTwo" ]]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION() {
    MYIP=$(wget -qO- ipv4.icanhazip.com);
    IZIN=$(curl -sS https://raw.githubusercontent.com/MyRidwan/izinvps/ipuk/ip | awk '{print $2}' | grep $MYIP)
    if [[ "$MYIP" = "$IZIN" ]]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#Detail
country="MY"
state="Project"
locality="KK"
organization="KYT-Project"
organizationalunit="KYT-Project"
commonname="KYT-Project"
email="JsPhantom-project@gmail.com"

# simple password minimal
curl -sS https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/password | openssl aes-256-cbc -d -a -pass pass:scvps07gg -pbkdf2 > /etc/pam.d/common-password
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

#install jq
apt -y install jq

#install shc
apt -y install shc

# install wget and curl
apt -y install wget curl

# install netfilter-persistent
apt-get install netfilter-persistent

#figlet
apt-get install figlet -y
apt-get install ruby -y
gem install lolcat

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

install_ssl(){
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            else
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            fi
    else
        yum install -y nginx certbot
        sleep 3s
    fi

    systemctl stop nginx.service

    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            else
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            fi
    else
        echo "Y" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
        sleep 3s
    fi
}

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
echo "clear" >> .profile
echo "status" >> .profile

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://${Server_URL}/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://${Server_URL}/vps.conf"
/etc/init.d/nginx restart

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# setting port ssh
cd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 40000' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 22' /etc/ssh/sshd_config
/etc/init.d/ssh restart

echo "=== Install Dropbear ==="
# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/ssh restart
/etc/init.d/dropbear restart

# Install SSLH
apt -y install sslh
rm -f /etc/default/sslh

# Settings SSLH
cat > /etc/default/sslh <<-END
Default options for sslh initscript
sourced by /etc/init.d/sslh
Disabled by default, to force yourself
to read the configuration:
- /usr/share/doc/sslh/README.Debian (quick start)
- /usr/share/doc/sslh/README, at "Configuration" section
- sslh(8) via "man sslh" for more configuration details.
Once configuration ready, you *must* set RUN to yes here
and try to start sslh (standalone mode only)
RUN=yes
binary to use: forked (sslh) or single-thread (sslh-select) version
systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh
DAEMON_OPTS="--user sslh --listen 0.0.0.0:700 --ssl 127.0.0.1:69 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194--pidfile /var/run/sslh/sslh.pid -n"
END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

cd
# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
[dropbear]
accept = 8880
connect = 127.0.0.1:22
[dropbear]
accept = 8443
connect = 127.0.0.1:109
[ws-stunnel]
accept = 444
connect = 700
[openvpn]
accept = 990
connect = 127.0.0.1:1194
END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

#OpenVPN
wget https://raw.githubusercontent.com/myridwan/xyz/ipuk/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# banner /etc/issue.net
wget -q -O /etc/issue.net "https://${Server_URL}/issues.net" && chmod +x /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config

# Ganti Banner
wget -O /etc/issue.net "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/issue.net"

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# install resolvconf service
apt install resolvconf -y

#start resolvconf service
systemctl start resolvconf.service
systemctl enable resolvconf.service

# download script
cd /usr/local/sbin
wget -O ins-helium "https://${Server_URL}/ins-helium.sh"
wget -O add-host "https://${Server_URL}/add-host.sh"
wget -O speedtest "https://${Server_URL}/speedtest_cli.py"
wget -O xp "https://${Server_URL}/xp.sh"
wget -O menu "https://${Server_URL}/menu.sh"
wget -O status "https://${Server_URL}/status.sh"
wget -O info "https://${Server_URL}/info.sh"
wget -O restart "https://${Server_URL}/restart.sh"
wget -O dns "https://${Server_URL}/dns.sh"
wget -O nf "https://${Server_URL}/media.sh"
wget -O limit "https://${Server_URL}/limit-speed.sh"
wget -O menu-tr "https://${Server_URL}/menu-tr.sh"
wget -O menu-ws "https://${Server_URL}/menu-ws.sh"
wget -O menu-vless "https://${Server_URL}/menu-vless.sh"
wget -O menu-xtr "https://${Server_URL}/menu-xtr.sh"
wget -O menu-xrt "https://${Server_URL}/menu-xrt.sh"
wget -O certxray "https://${Server_URL}/cert.sh"

# menu ssh ovpn
wget -O m-sshovpn "https://raw.githubusercontent.com/myridwan/xyz/ipuk/m-sshovpn.sh"
wget -O usernew "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/trial.sh"
wget -O renew "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/renew.sh"
wget -O hapus "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/hapus.sh"
wget -O cek "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/cek.sh"
wget -O member "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/member.sh"
wget -O delete "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/delete.sh"
wget -O autokill "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/ceklim.sh"
wget -O portovpn "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/portovpn.sh"
wget -O tendang "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/tendang.sh"
wget -O insshws "https://raw.githubusercontent.com/myridwan/xyz/ipuk/sshws/insshws.sh"
wget -O issue "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/issue.net"
wget -O webmin "https://raw.githubusercontent.com/myridwan/xyz/ipuk/ssh/webmin.sh"

chmod +x menu-tr
chmod +x menu-ws
chmod +x menu-vless
chmod +x menu-xtr
chmod +x menu-xrt
chmod +x certxray
chmod +x ins-helium
chmod +x menu
chmod +x add-host
chmod +x speedtest
chmod +x xp
chmod +x status
chmod +x info
chmod +x restart
chmod +x dns
chmod +x nf
chmod +x limit

chmod +x m-sshovpn
chmod +x usernew
chmod +x trial
chmod +x renew
chmod +x hapus
chmod +x cek
chmod +x member
chmod +x delete
chmod +x autokill
chmod +x ceklim
chmod +x portovpn
chmod +x tendang
chmod +x insshws
chmod +x issue
chmod +x webmin

echo "0 6 * * * root reboot" >> /etc/crontab
echo "0 0 * * * root /usr/bin/xp" >> /etc/crontab
echo "*/2 * * * * root /usr/bin/cleaner" >> /etc/crontab
cd

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1

# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting nginx"
/etc/init.d/nginx restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting cron "
/etc/init.d/cron restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting fail2ban"
/etc/init.d/fail2ban restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting resolvconf"
/etc/init.d/resolvconf restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting vnstat"
/etc/init.d/vnstat restart >/dev/null 2>&1
history -c
echo -e "[ ${green}ok${NC} ] Restarting openvpn"
/etc/init.d/openvpn restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting ssh "
/etc/init.d/ssh restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting dropbear "
/etc/init.d/dropbear restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting sslh "
/etc/init.d/sslh restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting stunnel4 "
/etc/init.d/stunnel4 restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting squid "
/etc/init.d/squid restart >/dev/null 2>&1

screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/ssh-vpn.sh
rm -f /root/key.pem
rm -f /root/cert.pem
# finishing
clear
