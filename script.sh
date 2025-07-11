#!/bin/bash

#cat nginx-access.log | awk '{print $1}' | sort | grep "95.70.160.44" | wc

awk '{print $1}' nginx-access.log | sort -n | uniq  > ips.log
awk -F'"' '{print $2}' nginx-access.log | sort | uniq | awk '{print $2}' > paths.log
awk '{print $9}' nginx-access.log | sort | uniq > codes.log

touch temp.log
> temp.log


echo "Top IPs by requests: "
echo

while IFS= read -r ip; do
	grep $ip nginx-access.log | wc | awk -v ip="$ip" '{print $1, ip}' >> temp.log 
	#count=$(grep -c "$ip" nginx-access.log)
	#echo "$count - $ip"
	#cat count.log >> "$count - $ip"
       	#grep $ip nginx-access.log | wc | awk '{print $1}'
done < ips.log

sort -nr temp.log | uniq | head -n 5
> temp.log

echo
echo "Top PATHs by requests: "
echo

while IFS= read -r path; do
    count=$(awk -F'"' '{print $2}' nginx-access.log | awk '{print $2}' | grep -x -F "$path" | wc -l)
    echo "$count $path" >> temp.log
done < paths.log

sort -nr temp.log | uniq | head -n 5 
> temp.log

echo
echo "Top 5 response status codes: "
echo

while IFS= read -r code; do
	grep -F $code nginx-access.log | wc | awk -v code="$code" '{print $1, code}' >> temp.log 
done < codes.log

sort -n temp.log >> temp.log
tail -n 5 temp.log | sort -r
