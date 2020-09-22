# Reverse-proxy tunnel

Some users behind NAT (doesn't have public IP) it is impossible to connect directly\* to the user proxy server. But the user can connect to any public IP server. It is possible to "switch" roles between client and server since they already have established bidirectional TCP stream. In short, this is how the reverse connection works.

\* This is possible via STUN/TURN protocols, but it can be unstable. And this solution will not work for some amount of users.

Short scheme:
The user server listens to socket on 9999 port
User relay connects to local 9999 port and remote 9999
User relay forwarding all traffic from remote 9999 port to local 9999 port
The remote client listens for 9999 port and waiting for a connection
Remote curl/chrome sending traffic to 9999 port and it is forwarded to user relay

```
brook <-- user relay <---> server relay <-- curl
```

#### SSH tunnel 
SSH supports by default reverse tunneling to provide access for PC behind the NAT. For each remote server, a new tunnel must be created. 
```sh
# Crating proxy on localhost:9999 endpoint
./brook socks5 --socks5 127.0.0.1:9999 &

# We want to provide this PC as proxy for 172.242.147.230 and 172.242.147.231
ssh -N -R 9999:127.0.0.1:7777 172.242.147.230 &
ssh -N -R 9999:127.0.0.1:7777 172.242.147.231 &

# Now both server can send any request to the brook by accessing their own 7777 port
# Like curl -x socks5://127.0.0.1:7777 https://api.myip.com
```
For security reasons, it's possible to create a separate user for the SSH channel without shell access. 
https://unix.stackexchange.com/questions/55106/disable-user-shell-for-security-reasons

SSH tunnel is overkill because it's implements encryption, authorization, and other stuff. There is enough to just forward any bytes between the user and the remote PC.


#### Usage example
The repo has `lin`, `win`, `mac` folders. It contains brook binaries from [here](https://github.com/txthinking/brook/releases). There are already exists a hardcoded script for the provided EC2 node: `run_13.211.252.49`. 
Linux/Mac example:
```sh
git clone https://github.com/80bots/proxy.git && cd ./proxy/mac
chmod +x ./run_13.211.252.49.sh
./run_13.211.252.49.sh
```
Linux and Mac have differences only in brook binary files.
On the Windows PC, you can double-click at `run_13.211.252.49.bat`

Also, there is `./run` script which accepts IP, username, pem as arguments. 
```sh
./run.sh remote_server.com ssh_user ssh_user.pem
```
