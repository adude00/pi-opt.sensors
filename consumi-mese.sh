#!/bin/bash
#
# Script che a fine mese calcola i consumi del mese precedente e li segna in un file

# Aspetto 25 secondi che finiscano gli altri script
sleep 25

CONSUMIORARI=/opt/consumi/consumi-ore

IERI=$(date +%Y-%m -d "1 day ago")
#OGGI=$(date +%Y-%m)

#echo IERI: $IERI
#echo OGGI: $OGGI

GIORNIMESE=$(cal -d $IERI |awk 'FNR>2{d+=NF}END{print d}')

#echo GIORNIMESE: $GIORNIMESE

OREMESE=$((24*$GIORNIMESE))

#echo OREMESE: $OREMESE

echo -n "$IERI:"
tail -n $OREMESE $CONSUMIORARI | awk '{ sum+=$1} END {print sum}'
