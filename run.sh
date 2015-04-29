while true
do
./deploy.sh
./get_proxy_list.sh
./update_proxy.sh
sleep 300
done
