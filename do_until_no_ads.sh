self=$1
ref='1N38jUyZhrbRPJrLKJHQ2aNVLKA4HmYSJW'
islocal=$2
proxy=$3

until [ $? -eq 1 ]
do
	./send.sh $self $ref $islocal $proxy
done
