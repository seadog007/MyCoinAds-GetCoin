#!/bin/bash
while true
do
all=`cat ./list/mergelist | wc -l`
no_more_count=`cat ./logs/no_more | sort | uniq | wc -l`
need_change=`cat ./logs/log | wc -l`
clear
date
echo "總帳號個數　：$all"
echo "處理完帳號　：$no_more_count"
echo "尚未處理帳號：$(($all - $no_more_count))"
echo ""
echo "本次循環需要更換Proxy帳號個數：$need_change"
sleep 0.5
done
