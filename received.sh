total=0
clear
while read line
do
  set -- "$line"
  IFS=";"; declare -a Array=($*)
  res="`curl -s "http://mycoinads.com/showstats.php?btcaddress="${Array[0]}" " -H "Cookie: btcaddress="${Array[0]}" ;"`"
  tt="`echo "$res" | grep 'Total Earned:' | sed 's/<.[^>]*>//g' | sed 's/Total Earned: //' | sed 's/ BTC//g'`"
  tb=`echo "$res" | grep 'Your Current Balance:' | sed 's/<.[^>]*>//g' | sed 's/Your Current Balance: //g' | sed 's/ BTC//g'`
  echo $res
  echo $tt
  echo $tb
  #[ `echo "$this > 0" | bc` -eq 1 ] && echo $this
  #[ `echo "$this > 0" | bc` -eq 1 ] && total=`echo "$this + $total" | bc`
  #[ `echo "$this > 0" | bc` -eq 1 ] && echo -e "${Array[0]}\t$total"
done < ./list/mergelist
sleep 3
