#!/bin/bash
rm mergelist
i=1
while read line
do
  echo "$line;`sed -n "$i"p addrlist`;`sed -n "$i"p proxylist`;`sed -n "$i"p proxylist2`" >> mergelist
  i=$((i + 1))
done < addrlist
