./proxy_lib/nntime.sh >> ./list/proxylist
./proxy_lib/hidemyass.py >> ./list/proxylist
cat ./list/proxylist | sort | uniq | sort -R > ./list/proxylist2
cat ./list/proxylist2 | sort -R > ./list/proxylist
