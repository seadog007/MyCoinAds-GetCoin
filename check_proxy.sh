limit=100
while read line
do
	until [ `jobs | wc -l | sed 's/ //g'` -lt $limit ]
	do
		sleep 0.5
	done
	echo `curl -s http://orange.tw -x \"$line\" --max-time 10` &
done < ./list/proxylist
