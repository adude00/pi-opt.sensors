#!/bin/sh
#
# Script da lanciare una volta al giorno, che calcola il consumo totale del giorno 
# facendo la somma dei valori delle ultime 24 ore.
#
# Crea quindi un file $GIORNO che verrà preso da zabbix con tail -n1
# E poi cancella il file dei consumi in modo che venga ricreato il prossimo minuto

# Ma prima di tutto aspetta 30 secondi che gli altri due cron abbiano finito...

ORE=/opt/consumi/consumi-ore
GIORNI=/opt/consumi/consumi-giorni

sleep 30

#OGGI=$(date +%Y-%m-%d:)
OGGI=$(date +%Y-%m-%d: -d "1 day ago")

echo -n $OGGI >> $GIORNI
tail -n 24 $ORE | awk '{ sum+=$1} END {print sum}' |cut -d. -f1 >> $GIORNI

# SOMMA: cat /run/temp/consumi-minuto | awk '{ sum+=$1} END {print sum}'
# MEDIA: cat /run/temp/consumi-minuto | awk '{ sum+=$1} END {print sum/NR}'
