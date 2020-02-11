#!/bin/bash/

# ENTER BUSSINES name, domain DONT
amass intel -org '$1' 
#read asns.txt, output to ipsrabd
for i in $(cat asns.txt); do whois -h whois.radb.net '!gas'$i''; done >ipsrabd.txt
#read file and find only ips range. ( may skip some ip range, please fix regex)
cat ipsrabd.txt | egrep -o "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\/([0-9]{2})"
