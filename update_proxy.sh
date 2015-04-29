#!/bin/bash
cp ./list/mergelist ./list/mergelist.last
clear
line_num=0
while read line
do
	line_num=$(($line_num + 1))
	set -- "$line"
	IFS=" "; declare -a Array=($*)
	cat ./list/mergelist | sed "s/${Array[0]}.*/${Array[0]};`sed -n "$line_num"p ./list/proxylist`;`sed -n "$line_num"p ./list/proxylist2`/" > ./list/mergelist.x
	rm ./list/mergelist
	mv ./list/mergelist.x ./list/mergelist
done < <(cat ./logs/log | sort | uniq)
