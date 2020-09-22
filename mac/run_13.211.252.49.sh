#!/bin/bash
chmod +x ./run.sh
chmod 400 ../test_data/alexandr.pem
./run.sh 13.211.252.49 ubuntu ../test_data/alexandr.pem
