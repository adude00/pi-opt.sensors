#!/bin/bash
#

RAW=$(python /opt/sensors/wunderground-api.py)
TNEW=$(echo $RAW |awk -F : '{ print $1 }')
HNEW=$(echo $RAW |awk -F : '{ print $2 }') 
PNEW=$(echo $RAW |awk -F : '{ print $3 }')
TOLD=$(tail -n1 /run/temp/fuori-temperatura)

MAX="40"
zero="0"
MIN="-20"

RESULT=$(echo $TNEW'<'$MAX | bc -l)

if [ "$RESULT" -eq "$zero" ]
        then
                echo "TROPPO CALDO: $TNEW > $MAX"
		echo "RESULT: $RESULT"
                exit
        else
		echo DEBUG non è troppo caldo: $TNEW
	fi

RESULT=$(echo $TNEW'>'$MIN | bc -l)

if [ "$RESULT" -eq "$zero" ]
        then
                echo "TROPPO FREDDO: $TNEW < $MIN"
                echo "RESULT: $RESULT"
                exit
        else
                echo DEBUG non è troppo freddo: $TNEW
        fi

OLDPLUS=$(echo "$TOLD + 10" |bc)
MAGGIORE=$(echo $TNEW'>'$OLDPLUS | bc -l)

if [ "$MAGGIORE" -ne "$zero" ] 
	then
		echo FUCKFARENHEIT
		exit
	fi

echo $TNEW >> /run/temp/fuori-temperatura
echo $TNEW > /opt/temp/fuori-temperatura
echo $HNEW |sed s/%// > /run/temp/fuori-umidita
cp /run/temp/fuori-umidita /opt/temp/
echo $PNEW > /run/temp/fuori-pressione
