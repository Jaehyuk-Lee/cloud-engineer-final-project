#/bin/bash
$number = "$1"
sed -i 's/proxy_pass http:\/\/192.168.111.21:8080;/proxy_pass http:\/\/192.168.111.2'"$number"':8080;/g' default.conf
