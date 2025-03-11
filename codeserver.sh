cd ~/
sleep 2
ls -la
sleep 2
pwd
sleep 2
curl -s -L -o code-server.tar.gz https://github.com/coder/code-server/releases/download/v4.14.1/code-server-4.14.1-linux-amd64.tar.gz
sleep 2

tar -xf code-server.tar.gz
sleep 2

export PATH=$HOME/code-server-4.14.1-linux-amd64/bin:$PATH
sleep 2

mkdir .config
sleep 2

mkdir .config/code-server
sleep 2

touch .config/code-server/config.yaml
sleep 2

cat > .config/code-server/config.yaml <<END
bind-addr: 127.0.0.1:8080
auth: password
password: IhatePopUpsWut
cert: false
END

sleep 2
cat .config/code-server/config.yaml

sleep 2

curl -k https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz -L -O -J
tar -xvf frp_0.48.0_linux_amd64.tar.gz
# start from daemon
cp frp_0.48.0_linux_amd64/frpc ~/


sleep 2

array=()
for i in {a..z} {A..Z} {0..9}; 
   do
   array[$RANDOM]=$i
done

currentdate=$(date '+%d-%b-%Y_Hug_')
ipaddress=$(curl -s api.ipify.org)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
underscore="_"
underscored_ip+=$underscore
currentdate+=$underscored_ip

randomWord=$(printf %s ${array[@]::8} $'\n')
currentdate+=$randomWord

randomNumber=$(shuf -i 10000-65000 -n 1)

sleep 2

cat > frpc.ini <<END
[common]
server_addr = emergencyaccess.teatspray.uk
server_port = 995

[codeserver.$currentdate]
type = tcp
local_ip = 127.0.0.1
local_port = 8080
remote_port = $randomNumber
subdomain = $currentdate

END

sleep 2

echo "Your Codeserver connection details will be $currentdate.emergencyaccess.teatspray.uk:$randomNumber" 

sleep 2

./frpc -c frpc.ini &

sleep 2

code-server
