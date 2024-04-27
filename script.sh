#!/bin/bash

# /etc/hosts 수정
end_number=${1:-1} # 인수가 없을 경우 기본값은 1
j2_end_number=$((end_number + 1))

if ! [[ $end_number =~ ^[0-9]+$ && $end_number -ge 1 && $end_number -le 10 ]]; then
  echo "1부터 10 사이의 숫자를 입력해주세요"
  exit 1
fi

sed -i 's/with_sequence: start=1 end=[0-9]\{1,2\}/with_sequence: start=1 end='"$end_number"'/g' ansible/env/update_inventory_hosts.yaml

# 인벤토리 /etc/ansible/hosts 수정
sed -i 's/{% for i in range(1, [0-9]\{1,2\}) %}/{% for i in range(1, '"$j2_end_number"') %}/g' ansible/env/templates/inventory_template.j2

# haproxy backend http_back 수정
sed -i 's/{% for i in range(1, [0-9]\{1,2\}) %}/{% for i in range(1, '"$j2_end_number"') %}/g' ansible/web/templates/haproxy.cfg.j2

# Vagrant 서버 생성 갯수 수정
sed -i 's/(1..[0-9]\{1,2\}).each do |i|/(1..'"$end_number"').each do |i|/g' Vagrantfile

vagrant up
# vagrant provision
