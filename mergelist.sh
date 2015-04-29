#!/bin/bash
rm ./list/mergelist
i=1
while read line
do
  echo "$line;`sed -n "$i"p ./list/proxylist`;`sed -n "$i"p ./list/proxylist2`" >> ./list/mergelist
  i=$((i + 1))
done < ./list/addrlist
