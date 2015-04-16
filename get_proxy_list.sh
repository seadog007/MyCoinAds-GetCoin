for i in {1..9}
do
curl "http://nntime.com/proxy-updated-0$i.htm" | grep '<td><input type="checkbox" name="' | grep -oh '\([[:digit:]]\{1,3\}.\)\{4\}script type="text/javascript">document.write(.*)' | sed 's/<script type="text\/javascript">document.write(":"/:/' | sed 's/)//' |\
sed 's/+l/1/g' |\
sed 's/+q/2/g' |\
sed 's/+s/3/g' |\
sed 's/+x/4/g' |\
sed 's/+j/5/g' |\
sed 's/+y/6/g' |\
sed 's/+o/7/g' |\
sed 's/+v/8/g' |\
sed 's/+h/9/g' |\
sed 's/+i/0/g' >> ./list/proxylist
done
cp ./list/proxylist ./list/proxylist2
