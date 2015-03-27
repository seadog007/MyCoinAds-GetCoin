#!/bin/bash

clear
line_num=0
while read line
do
	line_num=$(($line_num + 1))
	set -- "$line"
	IFS=" "; declare -a Array=($*)
	cat mergelist | sed "s/${Array[0]}.*/${Array[0]};$(sed -n $(($line_num * 2 - 1))p proxylist_backup);$(sed -n $(($line_num * 2 - 0))p proxylist_backup)/" > mergelist.x
	rm mergelist
	mv mergelist.x mergelist
sleep 0.1
done < <(cat log.log | sort | uniq)
