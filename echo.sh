while true
do
 	clear
	while read line
	do
		set -- "$line"
		IFS=";"; declare -a Array=($*)
		echo "`date`   "${Array[0]}"`curl -s "http://mycoinads.com/showstats.php?btcaddress="${Array[0]}" " -H "Cookie: btcaddress="${Array[0]}" ;" | grep 'Total Earned:' | sed 's/<.[^>]*>//g' | sed 's/Total Earned//'`"
	done < mergelist
	sleep 3
done
