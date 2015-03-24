self=$1
ref=$2
islocal=$3
proxy=$4
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'

function clean_up {
	rm cookie.*
}
trap "clean_up;exit" SIGTERM SIGINT SIGHUP


[ $islocal -ge 1 ] && curl -s -o /dev/null -c cookie.$$ "http://mycoinads.com/?r=$ref" -A "$UA"
[ $islocal -ne 1 ] && curl -s -o /dev/null -c cookie.$$ "http://mycoinads.com/?r=$ref" -A "$UA" -x "$proxy"

[ $islocal -ge 1 ] && ads_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/surfbtc.php?btcaddress=$self" -A "$UA" -H 'Referer: http://mycoinads.com/'`
[ $islocal -ne 1 ] && ads_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/surfbtc.php?btcaddress=$self" -A "$UA" -H 'Referer: http://mycoinads.com/' -x "$proxy"`

collect_path=`echo $ads_content | grep -oh "collectcredits.php?ad=[[:digit:]]\{1,7\}&btcaddress=\w\{33,35\}&hash=\w\{32\}&id=[[:digit:]]\{0,7\}"`

[ $islocal -ge 1 ] && collect_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/$collect_path" -A "$UA" | grep '( document )'`
[ $islocal -ne 1 ] && collect_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/$collect_path" -A "$UA" -x "$proxy" | grep '( document )'`

[ -z "$collect_path" ] && echo $ads_content && echo 'No more Ads' && exit 1

hash=`echo $collect_content | grep -oh 'hash:"\w\{32\}"' | grep -oh '"\w\{32\}"' | sed 's/"//g'`
id=`echo $collect_content | grep -oh 'id:"[[:digit:]]\{1,7\}"' | grep -oh '"[[:digit:]]\{1,7\}"' | sed 's/"//g'`
ad=`echo $collect_content | grep -oh 'ad:"[[:digit:]]\{1,7\}"' | grep -oh '"[[:digit:]]\{1,7\}"' | sed 's/"//g'`
btcaddr=`echo $collect_content | grep -oh 'btcaddress:"\w\{33,35\}"' | grep -oh '"\w\{33,35\}"' | sed 's/"//g'`

[ $islocal -ge 1 ] && echo `curl -s -c cookie.$$ -b cookie.$$ 'http://mycoinads.com/collectcredits.php' --data "verify=verified&hash=$hash&ad=$ad&id=$id&btcaddress=$btcaddr" -A "$UA" -H "Referer: http://mycoinads.com/$collect_path?ad=$ad&btcaddress=$btcaddr&hash=$hash&id=$id" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://mycoinads.com' -H 'X-Requested-With: XMLHttpRequest'`
[ $islocal -ne 1 ] && echo `curl -s -c cookie.$$ -b cookie.$$ 'http://mycoinads.com/collectcredits.php' --data "verify=verified&hash=$hash&ad=$ad&id=$id&btcaddress=$btcaddr" -A "$UA" -H "Referer: http://mycoinads.com/$collect_path?ad=$ad&btcaddress=$btcaddr&hash=$hash&id=$id" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://mycoinads.com' -H 'X-Requested-With: XMLHttpRequest' -x "$proxy"`

rm cookie.*
