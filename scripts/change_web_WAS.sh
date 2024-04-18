#!/bin/bash

# WAS_IP 값 초기화
WAS_IP=""

# WAS 서버의 수를 지정합니다.
NUM_SERVERS=2  # 변경할 서버의 수에 맞게 설정합니다.

# 각 WAS 서버의 IP 주소를 가져와서 WAS_IP에 추가합니다.
for ((i=1; i<=$NUM_SERVERS; i++))
do

# 서버의 IP 주소를 가져오는 코드 작성 (예를 들어, ifconfig, ip addr 등을 사용하여)
server_ip=$(ip addr show eth1 | grep -oP 'inet \K[\d.]+')

# WAS_IP 값 설정
WAS_IP="$server_ip"

# 도커 컨테이너 업데이트
docker container update --env WAS_IP="$WAS_IP" my-nginx-container
