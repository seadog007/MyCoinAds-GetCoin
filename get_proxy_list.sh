curl --ipv4 -s http://srv.seadog007.me:9182/proxylist -O ./list/proxylist
cat ./list/proxylist | uniq | sort -R > ./list/proxylist2
cat ./list/proxylist2 | sort -R > ./list/proxylist
