./proxy_lib/nntime.sh >> /dev/null
./proxy_lib/hidemyass.py >> ./list/proxylist
cat ./list/proxylist | sort -R > ./list/proxylist2
cat ./list/proxylist2 | sort -R > ./list/proxylist
