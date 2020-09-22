@echo off
icacls ..\test_data\alexandr.pem /inheritance:r
icacls ..\test_data\alexandr.pem /grant:r "%username%":"(R)"
./run.bat 13.211.252.49 ubuntu ..\test_data\alexandr.pem