#!/bin/bash

#cat nginx-access.log | awk '{print $1}' | sort | grep "95.70.160.44" | wc

cat nginx-access.log | awk '{print $1}' | sort -n | uniq  > ips.log

while IFS= read -r ip; do
	echo "`grep $ip nginx-access.log | wc | awk '{print $1}'` - $ip" 
       	#grep $ip nginx-access.log | wc | awk '{print $1}'
done < ips.log
