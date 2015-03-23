self=$1
ref=$2
proxy=$3
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'

function clean_up {
	rm cookie.*
}

trap "clean_up;exit" SIGTERM SIGINT SIGHUP

curl -s -o /dev/null -c cookie.$$ "http://mycoinads.com/?r=$ref" -A "$UA" -x "$proxy"
ads_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/surfbtc.php?btcaddress=$self" -A "$UA" -H 'Referer: http://mycoinads.com/' -x "$proxy"`
collect_path=`echo $ads_content | grep -oh "collectcredits.php?ad=[[:digit:]]\{1,7\}&btcaddress=\w\{33,35\}&hash=\w\{32\}&id=[[:digit:]]\{0,7\}"`
collect_content=`curl -s -c cookie.$$ -b cookie.$$ "http://mycoinads.com/$collect_path" -A "$UA" -x "$proxy" | grep '( document )'`

[ -z "$collect_path" ] && echo $ads_content && echo 'No more Ads' && exit 1

hash=`echo $collect_content | grep -oh 'hash:"\w\{32\}"' | grep -oh '"\w\{32\}"' | sed 's/"//g'`
id=`echo $collect_content | grep -oh 'id:"[[:digit:]]\{1,7\}"' | grep -oh '"[[:digit:]]\{1,7\}"' | sed 's/"//g'`
ad=`echo $collect_content | grep -oh 'ad:"[[:digit:]]\{1,7\}"' | grep -oh '"[[:digit:]]\{1,7\}"' | sed 's/"//g'`
btcaddr=`echo $collect_content | grep -oh 'btcaddress:"\w\{33,35\}"' | grep -oh '"\w\{33,35\}"' | sed 's/"//g'`
# part of collect_content $(' document ').ready(function()' '{' '$.post(' '"collectcredits.php",' '{' verify: '"verified",' 'hash:"f38e54e328588203f767b83d37f48b86",' 'ad:"1414",' 'id:"578141",' 'btcaddress:"1MJ6Pg5BkjdMog1wpCW7pZJd4xNXgHmjja"' '}' ');$("#themsg").html("Thanks' for playing along, you have been awarded credits as 'promised.<br><br>Ready' for 'more?");' '});'

echo `curl -s -c cookie.$$ -b cookie.$$ 'http://mycoinads.com/collectcredits.php' --data "verify=verified&hash=$hash&ad=$ad&id=$id&btcaddress=$btcaddr" -A "$UA" -H "Referer: http://mycoinads.com/$collect_path?ad=$ad&btcaddress=$btcaddr&hash=$hash&id=$id" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://mycoinads.com' -H 'X-Requested-With: XMLHttpRequest' -x "$proxy"`

rm cookie.*
