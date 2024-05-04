#!/bin/bash

web_end_number=${1:-1} # 인수가 없을 경우 기본값은 1

if ! [[ "$web_end_number" =~ ^[0-9]+$ && "$web_end_number" -ge 1 && "$web_end_number" -le 10 ]]; then
  echo "1부터 10 사이의 숫자를 입력해주세요"
  exit 1
fi

was_end_number=${2:-1} # 인수가 없을 경우 기본값은 1

if ! [[ "$was_end_number" =~ ^[0-9]+$ && "$was_end_number" -ge 1 && "$was_end_number" -le 10 ]]; then
  echo "1부터 10 사이의 숫자를 입력해주세요"
  exit 1
fi

# /etc/hosts 수정
sed -i 's/web_end_number: [0-9]\{1,2\}/web_end_number: '"$web_end_number"'/g' ansible/env/update_inventory_hosts.yaml
sed -i 's/was_end_number: [0-9]\{1,2\}/was_end_number: '"$was_end_number"'/g' ansible/env/update_inventory_hosts.yaml

# haproxy backend http_back 수정
sed -i 's/web_end_number: [0-9]\{1,2\}/web_end_number: '"$web_end_number"'/g' ansible/web/install_haproxy.yaml
sed -i 's/was_end_number: [0-9]\{1,2\}/was_end_number: '"$was_end_number"'/g' ansible/web/install_haproxy.yaml
