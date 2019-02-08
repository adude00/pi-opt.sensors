#!/bin/sh
#/opt/sensors/temp-camera > /run/temp/temp
#cp /run/temp/temp /run/temp/temp-camera
#               cp /run/temp/temp-camera /opt/temp/run # per OH
/opt/sensors/temp-soggiorno > /run/temp/temp
cp /run/temp/temp /run/temp/temp-soggiorno
/opt/sensors/watt.py |cut -dA -f2 > /run/temp/temp
cp /run/temp/temp /run/temp/watt
cat /run/temp/watt >> /opt/consumi/consumi-minuto
               cp /run/temp/watt /opt/temp/run # per OH
# MEDIA
echo 'scale=1;('`tail -n1 /opt/temp/dht22-temp`'+'`tail -n1 /opt/temp/temp-soggnew`')/2' |bc > /run/temp/temp-soggiorno-avg

               cp /run/temp/temp-soggiorno-avg /opt/temp/run # per OH

# RRD (in test)
sleep 1
/var/www/casa/lettura.sh
