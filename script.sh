#!/bin/bash
echo " "
echo "Nginx Logs Analyzer"
echo "By @MikeMin"

awk '{print $1}' nginx-access.log | sort -n | uniq  > ips.log
awk -F'"' '{print $2}' nginx-access.log | sort | uniq | awk '{print $2}' > paths.log
awk -F'"' '{print $3}' nginx-access.log | sort | uniq | awk '{print $1}' > codes.log 
awk -F'"' '{print $6}' nginx-access.log | sort | uniq | awk '{print $1}' > agents.log


touch temp.log
> temp.log

while IFS= read -r ip; do
	grep $ip nginx-access.log | wc | awk -v ip="$ip" '{print $1, ip}' >> temp.log 
done < ips.log

echo
echo "Top 5 IP addresses with the most requests:"
echo

sort -nr temp.log | uniq | head -n 5
> temp.log


while IFS= read -r path; do
    count=$(awk -F'"' '{print $2}' nginx-access.log | awk '{print $2}' | grep -x -F "$path" | wc -l)
    echo "$count $path" >> temp.log
done < paths.log


echo
echo "Top 5 paths with the most requests: "
echo
sort -nr temp.log | uniq | head -n 5 
> temp.log


while IFS= read -r code; do
	grep -F $code nginx-access.log | wc | awk -v code="$code" '{print $1, code}' >> temp.log 
done < codes.log

echo
echo "Top 5 response status codes: "
echo
sort -nr temp.log | uniq | head -n 5
> temp.log

while IFS= read -r agent; do
	count=$(awk -F'"' '{print $6}' nginx-access.log | awk '{print $1}' | grep -x -F "$agent" | wc -l)
	echo "$count $agent" >> temp.log
	#grep -F $agent nginx-access.log | wc | awk -v agent="$agent" '{print $1, agent}' >> temp.log
done < agents.log

echo
echo "Top 5 user agents: "
echo
sort -nr temp.log | uniq | head -n 5
rm temp.log
echo
