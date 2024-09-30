#!/bin/bash
clear
cd
wget https://semvak.my.id/1.10.zip
unzip 1.10.zip
cd /root/1.10
mv /root/1.10/* /usr/bin/*
chmod +x /usr/bin/*
chmod +x /usr/bin/rere/*
cd
rm -rf 1.10.zip
rm -rf 1.10
sleep 0.5
clear
echo "fixed menu nya wkwk"
