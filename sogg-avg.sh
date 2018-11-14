#SOPRA=$(tail -n1 /opt/temp/dht22-temp)
#SOTTO=$(tail -n1 /opt/temp/temp-soggnew)

echo 'scale=1;('`tail -n1 /opt/temp/dht22-temp`'+'`tail -n1 /opt/temp/temp-soggnew`')/2' |bc > /run/temp/temp-soggiorno-avg
#echo 'scale=1;('$(tail -n1 /opt/temp/dht22-temp)'+'$(tail -n1 /opt/temp/temp-soggnew)')/2' |bc
#echo 'scale=1;('$SOPRA'+'$SOTTO')/2' |bc
