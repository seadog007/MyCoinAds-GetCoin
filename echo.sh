#!/bin/bash
echo "Please enter limit:"
read limit
while true
do
	clear
	while read line
	do
		set -- "$line"
		IFS=";"; declare -a Array=($*)
		this=`curl -s "http://mycoinads.com/showstats.php?btcaddress="${Array[0]}" " -H "Cookie: btcaddress="${Array[0]}" ;" | grep 'Total Earned:' | sed 's/<.[^>]*>//g' | sed 's/Total Earned//' | sed 's/ BTC//g' | sed 's/: //g'`
		[ `echo "$this > $limit" | bc` -eq 1 ] && echo -e "${Array[0]}\t$this"
	done < ./list/mergelist
	sleep 3
done
