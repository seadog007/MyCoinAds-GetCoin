#!/bin/bash

# clear
while read line
do
	set -- "$line"
  IFS=";"; declare -a Array=($*)
  [ -z "${Array[2]}" ] && ./do_until_no_ads.sh "${Array[1]}" 1 &
  [ -n "${Array[2]}" ] && [ -n "${Array[3]}" ] && ./do_until_no_ads.sh "${Array[1]}" 0 "${Array[2]}" "${Array[3]}" &
done < mergelist

