
# 12: No Ads
# 17: Need Change IP
# 30: Argument Wrong
# 31: Other Error ( almost proxy problem )


self=$1
ref=$2
islocal=$3
proxy=$4
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'
FailTime=0

function clean_up {
rm cookie.*
}
trap "clean_up;exit" SIGTERM SIGINT SIGHUP

function retry {
echo "retry" >> /dev/null
FailTime=$((FailTime+1))
[ "$FailTime" -lt "2" ] && main
exit 31
}


function main {

sleep 3
[ $islocal -ge 1 ] && curl -s -o /dev/null -c cookie.$$ "http://mycoinads.com/?r=$ref" -A "$UA" --max-time 20
[ $islocal -ne 1 ] && curl -s -o /dev/null -c cookie.$$ "http://mycoinads.com/?r=$ref" -A "$UA" -x "$proxy" --max-time 20

[ $islocal -ge 1 ] && ads_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/surfbtc.php?btcaddress=$self" -A "$UA" -H 'Referer: http://mycoinads.com/' --max-time 20`
[ $islocal -ne 1 ] && ads_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/surfbtc.php?btcaddress=$self" -A "$UA" -H 'Referer: http://mycoinads.com/' -x "$proxy" --max-time 20`

collect_path=`echo $ads_content | grep -oh "collectcredits.php?ad=[[:digit:]]\{1,7\}&btcaddress=\w\{33,35\}&hash=\w\{32\}&id=[[:digit:]]\{0,7\}"`

[ $islocal -ge 1 ] && collect_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/$collect_path" -A "$UA" --max-time 20 | grep '( document )'`
[ $islocal -ne 1 ] && collect_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/$collect_path" -A "$UA" -x "$proxy" --max-time 20 | grep '( document )'`


if [ -z "$collect_path" ]
then
  # echo $ads_content
  [ -n "`echo "$ads_content" | grep 'have any new ads to show you.'`" ] && echo "$self" >> ./logs/no_more && clean_up && exit 12
  [ -n "`echo "$ads_content" | grep 'someone else from this ip is using MyCoinAds'`" ] && echo 'Need Change IP' >> /dev/null && clean_up && exit 17
  echo 'Other Error' >> /dev/null && retry
fi


hash=`echo $collect_content | grep -oh 'hash:"\w\{32\}"' | grep -oh '"\w\{32\}"' | sed 's/"//g'`
id=`echo $collect_content | grep -oh 'id:"[[:digit:]]\{1,7\}"' | grep -oh '"[[:digit:]]\{1,7\}"' | sed 's/"//g'`
ad=`echo $collect_content | grep -oh 'ad:"[[:digit:]]\{1,7\}"' | grep -oh '"[[:digit:]]\{1,7\}"' | sed 's/"//g'`
btcaddr=`echo $collect_content | grep -oh 'btcaddress:"\w\{33,35\}"' | grep -oh '"\w\{33,35\}"' | sed 's/"//g'`

[ $islocal -ge 1 ] && echo `curl -s -c cookie.$$ -b cookie.$$ 'http://mycoinads.com/collectcredits.php' --data "verify=verified&hash=$hash&ad=$ad&id=$id&btcaddress=$btcaddr" -A "$UA" -H "Referer: http://mycoinads.com/$collect_path?ad=$ad&btcaddress=$btcaddr&hash=$hash&id=$id" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://mycoinads.com' -H 'X-Requested-With: XMLHttpRequest' --max-time 20`
[ $islocal -ne 1 ] && echo `curl -s -c cookie.$$ -b cookie.$$ 'http://mycoinads.com/collectcredits.php' --data "verify=verified&hash=$hash&ad=$ad&id=$id&btcaddress=$btcaddr" -A "$UA" -H "Referer: http://mycoinads.com/$collect_path?ad=$ad&btcaddress=$btcaddr&hash=$hash&id=$id" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://mycoinads.com' -H 'X-Requested-With: XMLHttpRequest' -x "$proxy" --max-time 20`
clean_up
}

[ -z "$self" ] && exit 30
[ -z "$ref" ] && exit 30
[ -z "$islocal" ] && exit 30
if [ "$islocal" -gt 1 ] || [ "$islocal" -lt 0 ]
then
  exit 30
fi
if [ "$islocal" -ne 1 ] && [ -z "$proxy" ]
then
  exit 30
fi
#[ -n "$(grep $self ./logs/no_more)" ] && echo 'From Log Show No More Ads' && exit 12
#[ -z "$(grep $self ./logs/no_more)" ] && echo 'Need to do'
main
