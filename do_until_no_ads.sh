self=$1
ref='1N38jUyZhrbRPJrLKJHQ2aNVLKA4HmYSJW'
islocal=$2
proxy=$3
proxy2=$4
line=$5

laststatus=0
until [ $laststatus -gt 0 ]
do
	./send.sh $self $ref $islocal $proxy
  laststatus=$?
done
[ $laststatus -ge 17 ] || [ $laststatus -ge 31 ] && echo "$line Need to Change the proxy1"

laststatus=0
until [ $laststatus -gt 0 ]
do
  ./send.sh $self $ref $islocal $proxy2
  laststatus=$?
done
[ $laststatus -ge 17 ] || [ $laststatus -ge 31 ] && echo "$line Need to Change the proxy2"
