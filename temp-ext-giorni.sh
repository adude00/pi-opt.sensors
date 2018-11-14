#!/bin/sh
#
# Script che fa la media di NUMERO valori in un file di IN
# Da eseguire alle 00:01 dopo 35s di sleep
# Nel file OUT mette data:valori
#

IN=/run/temp/fuori-temperatura
GIORNI=/opt/consumi/temp-fuori-giorni

# 6 misurazioni all'ora per 24h = 144
VALORI=144

sleep 30

#OGGI=$(date +%Y-%m-%d:)
OGGI=$(date +%Y-%m-%d: -d "1 day ago")

echo -n $OGGI >> $GIORNI
tail -n $VALORI $IN | awk '{ sum+=$1} END {print sum/NR}' >> $GIORNI

# SOMMA: cat /run/temp/consumi-minuto | awk '{ sum+=$1} END {print sum}'
# MEDIA: cat /run/temp/consumi-minuto | awk '{ sum+=$1} END {print sum/NR}'
