#!/bin/bash
EC2_NODE=$1
EC2_USER=$2
EC2_PEM=$3

chmod +x ./brook
./brook socks5 --socks5 127.0.0.1:9999 &
BROOK_PID=$!
echo "Brook started on: $BROOK_PID"

echo "Started tunnel at 9999 port"
ssh -i $EC2_PEM -N -R 9999:127.0.0.1:9999 $EC2_USER@$EC2_NODE

echo "Killing brook `kill $BROOK_PID`"
