self=$1
ref='1N38jUyZhrbRPJrLKJHQ2aNVLKA4HmYSJW'
proxy=$2
until [ $? -eq 1 ]
do
	./send.sh $self $ref $proxy
done
