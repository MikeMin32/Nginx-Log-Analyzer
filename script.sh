#!/bin/bash

#cat nginx-access.log | awk '{print $1}' | sort | grep "95.70.160.44" | wc

cat nginx-access.log | awk '{print $1}' | sort -n | uniq  > ips.log
touch count.log
> count.log

while IFS= read -r ip; do
	grep $ip nginx-access.log | wc | awk -v ip="$ip" '{print $1, ip}' >> count.log 
	#count=$(grep -c "$ip" nginx-access.log)
	#echo "$count - $ip"
	#cat count.log >> "$count - $ip"
       	#grep $ip nginx-access.log | wc | awk '{print $1}'
done < ips.log

sort -n count.log >> count.log
tail -n 5 count.log
