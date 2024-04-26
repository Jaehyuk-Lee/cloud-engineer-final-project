#!/bin/bash

# Vagrantfile IP 대역 변경
new_private_network="$1"
sed -i "s/cfg\.vm\.network \"private_network\", ip: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./cfg.vm.network \"private_network\", ip: \"$new_private_network\./g" Vagrantfile

# env/update_invetory.hosts.yaml IP 대역 변경
sed -i "s/host_ip: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./host_ip: \"$new_private_network\./g" ansible/env/update_inventory_hosts.yaml
sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.2/$new_private_network\.2/g" ansible/env/update_inventory_hosts.yaml
sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.31/$new_private_network\.31/g" ansible/env/update_inventory_hosts.yaml
sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.100/$new_private_network\.100/g" ansible/env/update_inventory_hosts.yaml

# web/install_docker_nginx.yaml IP 대역 변경
sed -i "s/was_ip: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./was_ip: \"$new_private_network\./g" ansible/web/install_docker_nginx.yaml

# web/templates/haproxy.cfg.j2 IP 대역 변경
sed -i "s/server web-{{ \"%02d\"|format(i) }} [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./server web-{{ \"%02d\"|format(i) }} $new_private_network./g" ansible/web/templates/haproxy.cfg.j2
sed -i "s/server WAS-{{ \"%02d\"|format(i) }} [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./server WAS-{{ \"%02d\"|format(i) }} $new_private_network./g" ansible/web/templates/haproxy.cfg.j2

# ansible\DB\tasks\install.yaml IP 대역 변경
sed -i "s/host: \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.0\/24\"/host: \"$new_private_network\.0\/24\"/g" ansible/DB/tasks/install.yaml
sed -i "s/- \"[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.0\/24\"/- \"$new_private_network\.0\/24\"/g" ansible/DB/tasks/install.yaml

# DB/templates/my.cnf.j2 IP 대역 변경
sed -i "s/bind-address            = [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\./bind-address            = $new_private_network./g" ansible/DB/templates/my.cnf.j2
