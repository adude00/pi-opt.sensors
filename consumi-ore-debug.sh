#!/bin/sh
#
# Script da lanciare una volta all'ora che calcola il consumo medio in W dell'ora passata
# facendo la media dei valori delle righe del file $MINUTI
#
# Crea quindi un file $ORE che verrà preso da zabbix con tail -n1
# E poi cancella il file dei consumi in modo che venga ricreato il prossimo minuto

# Ma prima di tutto aspetta 15 secondi che il normale cron abbia finito....

MINUTI=/run/temp/consumi-minuto
ORE=/opt/consumi/consumi-ore
TOTALE=/opt/consumi/consumo-totale

#sleep 15

#cat $MINUTI | awk '{ sum+=$1} END {print sum/NR}' >> $ORE

#rm -f $MINUTI

# Adesso aggiorniamo il file dei consumi totali, che non fa altro che sommare
# il vecchio totale con il consumo di quest'ora...

CONSUMO_ULTIMORA=`tail -n1 $ORE |cut -d. -f1`
echo consumo ultimora $CONSUMO_ULTIMORA
TOTALE_VECCHIO=`cat $TOTALE`
echo consumo totale $TOTALE_VECCHIO
TOTALE_NUOVO=`expr $CONSUMO_ULTIMORA + $TOTALE_VECCHIO`
echo somma $TOTALE_NUOVO
#echo $TOTALE_NUOVO > $TOTALE

# SOMMA: cat /run/temp/consumi-minuto | awk '{ sum+=$1} END {print sum}'
# MEDIA: cat /run/temp/consumi-minuto | awk '{ sum+=$1} END {print sum/NR}'
