#!/bin/bash
chmod +x ./run.sh
chmod 400 ../test_data/test-proxy.pem
./run.sh 13.59.107.162 ubuntu ../test_data/test-proxy.pem
