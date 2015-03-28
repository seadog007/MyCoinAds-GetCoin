#!/bin/bash

rm log.log
# clear
limit=100
while read line
do
  set -- "$line"
  IFS=";"; declare -a Array=($*)
  #echo `jobs | wc -l`
  until [ `jobs | wc -l | sed 's/ //g'` -lt $limit ]
  do
    sleep 0.2
  done
  [ -z "${Array[1]}" ] && ./do_until_no_ads.sh "${Array[0]}" 1 &
  [ -n "${Array[1]}" ] && [ -n "${Array[2]}" ] && ./do_until_no_ads.sh "${Array[0]}" 0 "${Array[1]}" "${Array[2]}" &
done < mergelist

