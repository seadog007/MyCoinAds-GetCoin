curl -s http://srv.seadog007.me:9182/proxylist >> ./list/proxylist
cat ./list/proxylist | sort | uniq | sort -R > ./list/proxylist2
cat ./list/proxylist2 | sort -R > ./list/proxylist
