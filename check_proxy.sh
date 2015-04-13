while read line
do
echo `curl http://orange.tw -x "$line"`
done < ./list/proxylist
