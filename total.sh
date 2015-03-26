total=0
clear
while read line
do
  set -- "$line"
  IFS=";"; declare -a Array=($*)
  this="`curl -s "http://mycoinads.com/showstats.php?btcaddress="${Array[1]}" " -H "Cookie: btcaddress="${Array[1]}" ;" | grep 'Total Earned:' | sed 's/<.[^>]*>//g' | sed 's/Total Earned//' | sed 's/ BTC//g' | sed 's/: //g'`"
  #[ `echo "$this > 0" | bc` -eq 1 ] && echo $this
  [ `echo "$this > 0" | bc` -eq 1 ] && total=`echo "$this + $total" | bc`
  [ `echo "$this > 0" | bc` -eq 1 ] && echo $total
done < mergelist
sleep 3
