#!/bin/bash
#
# Script che calcola i consumi settimanali contando gli ultimi 168 consumi orari
#
# Da lanciare il primo minuto del primo giorno della settimana (lunedi 00:01 am)

# Aspetto 30 secondi che finiscano gli altri script
sleep 3

CONSUMIORARI=/run/temp/fuori-temperatura

DOMENICA=$(date +%Y-%m-%d -d "1 day ago")
LUNEDI=$(date +%Y-%m-%d -d "7 day ago")

VALORE=$(tail -n 1008 $CONSUMIORARI | awk '{ sum+=$1} END {print sum/NR}')

echo "$LUNEDI -> $DOMENICA : $VALORE"
