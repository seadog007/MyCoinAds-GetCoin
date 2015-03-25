while true
do
 	clear
	while read line
	do
		set -- "$line"
		IFS=";"; declare -a Array=($*)
		echo "`date`   "${Array[1]}"`curl -s "http://mycoinads.com/showstats.php?btcaddress="${Array[1]}" " -H "Cookie: btcaddress="${Array[1]}" ;" | grep 'Total Earned:' | sed 's/<.[^>]*>//g' | sed 's/Total Earned//'`"
	done < mergelist
	sleep 3
done
