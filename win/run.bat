@echo off
SET ec2_node=%1
SET ec2_user=%2
SET ec2_pem=%3

SET PATH=%PATH%;%CD%\OpenSSH-Win32
start /B brook.exe socks5 --socks5 127.0.0.1:9999
echo Brook started

ssh -i %ec2_pem% -N -R 9999:127.0.0.1:9999 %ec2_user%@%ec2_node%
