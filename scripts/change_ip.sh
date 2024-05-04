#!/bin/bash

# IP 대역 변수 지정
new_private_network="${1:-192.168.111}"
# 예외 처리
if ! [[ "$new_private_network" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
  echo "올바른 IP 주소 형식이 아닙니다, ###.###.### 형식으로 입력해주세요"
  exit 1
fi
echo $new_private_network
exit 0

# ansible 디렉토리로 이동
cd /home/vagrant/ansible

# env/update_invetory.hosts.yaml IP 대역 변경
sed -i "s/host_ip: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./host_ip: \"$new_private_network\./g" env/update_inventory_hosts.yaml
sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.2/$new_private_network\.2/g" env/update_inventory_hosts.yaml
sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.31/$new_private_network\.31/g" env/update_inventory_hosts.yaml
sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.100/$new_private_network\.100/g" env/update_inventory_hosts.yaml

# web/install_docker_nginx.yaml IP 대역 변경
sed -i "s/WAS_IP: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./WAS_IP: \"$new_private_network\./g" web/install_docker_nginx.yaml

# web/templates/haproxy.cfg.j2 web, WASIP 대역 변경
sed -i "s/server web-{{ \"%02d\"|format(i) }} [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./server web-{{ \"%02d\"|format(i) }} $new_private_network./g" web/templates/haproxy.cfg.j2
sed -i "s/server WAS-{{ \"%02d\"|format(i) }} [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./server WAS-{{ \"%02d\"|format(i) }} $new_private_network./g" web/templates/haproxy.cfg.j2

# DB/tasks/install.yaml DB IP 대역 변경
sed -i "s/host: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.0\/24\"/host: \"$new_private_network\.0\/24\"/g" DB/tasks/install.yaml
sed -i "s/- \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.0\/24\"/- \"$new_private_network\.0\/24\"/g" DB/tasks/install.yaml

# WAS/vars/main.yaml DB IP 대역 변경
sed -i "s/- [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.31/- $new_private_network\.31/g" WAS/vars/main.yaml
