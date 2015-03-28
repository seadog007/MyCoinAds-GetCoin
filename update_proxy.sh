#!/bin/bash
cp mergelist mergelist.original
clear
line_num=0
while read line
do
	line_num=$(($line_num + 1))
	set -- "$line"
	IFS=" "; declare -a Array=($*)
	cat mergelist | sed "s/${Array[0]}.*/${Array[0]};`sed -n "$line_num"p proxylist`;`sed -n "$line_num"p proxylist2`/" > mergelist.x
	rm mergelist
	mv mergelist.x mergelist
done < <(cat log.log | sort | uniq)
